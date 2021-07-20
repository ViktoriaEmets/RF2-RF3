module TR_pulse
  #(
    parameter SIZE            = 16,
    parameter PULSE_NUMBER    = 3  // nmber of pulse in hand mode
    )

  (
   //-----------------------commands-------------------------------------------------
   output reg       start,
                    start_N,
                    stop,
                    avto,
                    pulse_invert,

   output reg       drv_pulse, // pulse for SM
                    drv_dir,

   output   wire    xyz,                 
   //----------- input control signals ---------------------------------------------------------------------
   input            clk, // 50 MHz
                    rst, // reset
                    d_v, // from ADC reading data(this signal has a delay 20 ns)
   //-------------------------------------------------------------------------------------------------------

   input            drv_en_SM, // work SM, разрешение работы ШД внешнее

   input [SIZE-1:0] period_AUTO,         // period for filling with pulse
   input            dir_AUTO,


   input wire [7:0] avs_s0_address,
   input wire [31:0] avs_s0_writedata,

   output reg [31:0] avs_s0_readdata,

   input wire       avs_s0_write,
   input wire       avs_s0_read

   );


  reg [31:0]        period_MANUAL;
  reg               dir_MANUAL;

  reg [31:0]        control_reg;
  reg [7:0]         read_reg;
  reg               write_addr_err;

  
  reg [SIZE-1:0]    drv_period,     // период импульсов
                    period,         // регистр для записи периода для авто/руч режимов
                    drv_count,     // счетчик общий
                    count_N;       // счетчик уже сформированных импульсоВ


  reg               drv_step,       // регистр для предоконечного значения импульсов (после общего счетчика)
                    pulse_enable,   // разрешение работы ШД внутреннее (по командам start/stop)
                    counter_en;     // регистр разрешение работы счетчика подсчета импульсов

assign xyz=(count_N ==PULSE_NUMBER);
 
  reg [3:0]         State=0;

  localparam
    IDLE    = 1,
    MOVE    = 2,
    MOVE_N  = 4,
    AUTO    = 10;

  always @(posedge clk)
    begin
      if (rst)
        begin
          write_addr_err <= 1'b0;

          control_reg <= 0;
        end
      else
        begin
          control_reg[0] <= 1'b0; // stop           1
          control_reg[1] <= 1'b0; // start          2
          control_reg[2] <= 1'b0; // start_N        4
          control_reg[3] <= 1'b0; // pulse_invert   8

          //control_reg[4] <= 1'b0; // avto         10

          if (avs_s0_write)
            begin
              case (avs_s0_address)
                8'h0:
                  control_reg <= avs_s0_writedata;
                8'h1:
                  read_reg <= avs_s0_writedata;
                8'h5:
                  period_MANUAL <= avs_s0_writedata;  
                2'h6: 
                 dir_MANUAL <= avs_s0_writedata; 
                default:
                  write_addr_err <= 1'b1;
              endcase
            end
          else
            if (avs_s0_read)
              begin
                case (avs_s0_address)
                  8'h0:
                    avs_s0_readdata <= control_reg;
                  8'h1:
                    avs_s0_readdata <=read_reg;
                  8'h2:
                    avs_s0_readdata <= State;
                  8'h3:
                    avs_s0_readdata <= count_N[7:0];
                  8'h4:  
                    avs_s0_readdata <= counter_en;
                  8'h5:
                    avs_s0_readdata <= period_MANUAL;
                  8'h6: 
                    avs_s0_readdata <= dir_MANUAL; 
                  default:
                    avs_s0_readdata <= 32'b0;
                endcase
              end
        end

    end

  always @(*)
    begin
      stop           = control_reg[0];
      start          = control_reg[1];
      start_N        = control_reg[2];
      pulse_invert   = control_reg[3];

      avto           = control_reg[4];
    end


  reg [3:0]               NextState;



  //-----------------------------------------------------------------------------------
  always @(posedge clk)
    begin
      if(rst)
        State <= IDLE;
      else
        State <= NextState;
    end

  // по умолчанию сохраняем текущее состояние
  always @(*)
    begin

      case (State)

        IDLE:
          begin
            if(avto)
              NextState = AUTO;
            else
              begin
                if(start)
                  NextState = MOVE;
                else
                  begin
                    if(start_N)
                      NextState = MOVE_N;
                    else
                      NextState = IDLE;
                  end
              end
          end // case: IDLE

        AUTO:
          begin
            if (!avto)
              NextState = IDLE;
            else
              NextState = AUTO;
          end

        MOVE:
          begin
            if (stop)
              NextState = IDLE;
            else
              NextState = MOVE;
          end

        MOVE_N:
          begin
            if /*(count_N ==PULSE_NUMBER || stop)*/ (stop) 
              begin
                NextState = IDLE;
              end
            else
              begin
                NextState = MOVE_N;
              end
          end

        default:
          NextState = IDLE;
      endcase
    end

  // чтобы значение выхода изменялось вместе с изменением состояния, а не на следующем такте,
  // анализируем NextState
  always @(*)
    begin
      if(rst)
        begin
          pulse_enable = 0;
        end
      else
        begin

          case(NextState)

            IDLE:
              begin
                pulse_enable = 1'b0;
                counter_en   = 1'b0;
              end

            AUTO:
              begin
                pulse_enable = drv_en_SM;
                //period  = period_AUTO;
                counter_en   = 1'b0;

                drv_dir      = dir_AUTO;
              end

            MOVE:
              begin
                pulse_enable = 1'b1; // разрешение работы ШД
                counter_en   = 1'b0; // разрешение работы счетчика count_N

                //period  = period_MANUAL;

                drv_dir      = dir_MANUAL;
              end

            MOVE_N:
              begin
                pulse_enable = 1'b1; // разрешение работы ШД
                counter_en   = 1'b1; // разрешение работы счетчика count_N

               // period  = period_MANUAL;

                drv_dir      = dir_MANUAL;
              end

          endcase
        end
    end
  //-------------------------------------------------------------------------------------


  //-------------------------- period for counter -----------------------------------------------------------------------------------
  // FIX: нужен ли этот блок как общий, или он должен быть только при условии что
  //      работает автоматический режим
 /* always @(posedge clk)
    begin
      if(d_v)
        begin
          drv_period <= period;  // assign value to period
        end
    end*/
  //-------------------------------------------------------------------------------------------------------------------------------


  //--------------------	импульсы -----------------------------------------------------------------------------------------
  // счетчик
  always @(posedge clk)
    begin
      if (rst || pulse_enable == 0)
        begin
          drv_count<=0;
        end
      else
        begin
          if (drv_count <= period_MANUAL)
            drv_count <= drv_count + 1;
          else
            drv_count <= 0;
        end

      //  формирование импульсов и их длительности
      if (  (drv_count > 0) && (drv_count <= period_MANUAL  >> 2))
        drv_pulse  <= 1;
      else
        drv_pulse  <= 0;

      // формирование PULSE_NUMBER импульсов
      if (counter_en)
        begin
          if (drv_count == 1)
            begin
              if (count_N <= (PULSE_NUMBER - 1) )
                count_N <= count_N + 1;
              else
                count_N <= 0;
            end
        end
      else
        begin
          count_N <= 1'b0;
        end
    end
  //-------------------------------------------------------------------------------------------------

  //---------------------------- выходной сигнал  ---------------------------------------------------
  //assign
  // drv_pulse = drv_step ^ pulse_invert; // юит определяет прямой сигнал или инвертированный


endmodule
