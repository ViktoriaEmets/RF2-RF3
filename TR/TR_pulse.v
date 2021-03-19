module TR_pulse
 #(
    parameter SIZE       = 16,
    parameter N          = 100,  // nmber of pulse in hand mode
    parameter NUM_PERIOD = 2000 //  для частоты 25 кГц
  )
  
  (
    output reg          drv_pulse,     // pulse for SM

    //----------- input control signals ---------------------------------------------------------------------
    input               clk,           // 50 MHz
                        rst,           // reset
                        d_v,           // from ADC reading data(this signal has a delay 20 ns)
    //-------------------------------------------------------------------------------------------------------
    

    //---------------------------------------------------------------------------------
    input  wire [16:0] avs_s0_address,    // avalon_slave.address
    
    input  wire [31:0] avs_s0_writedata, //             .writedata
    output reg  [31:0] avs_s0_readdata,  //             .readdata

    input  wire        avs_s0_write,     //             .write
		input  wire        avs_s0_read,      //             .read 
    //----------------------------------------------------------------------------------


    input               drv_en_SM,     // work SM, разрешение работы ШД внешнее
    input [SIZE-1:0]    n             // period for filling with pulse
  );

reg [31:0]              control_reg,           
                        status_reg;

wire                    start,
                        start_N,
                        stop,
                        avto,
                        invert_pulse;   

reg                              write_addr_err;

//-------------- команды -------------------------------------------------------------------------------
assign                  
  start     = control_reg[0],
  start_N   = control_reg[1],
  stop      = control_reg[2],
  avto      = control_reg[3],
  invert_pulse = control_reg[4]; // инвертировать импульсы                    
//------------------------------------------------------------------------------------------------------                         


always @(posedge clk)
    begin
      control_reg[0] <= 1'b0;
      control_reg[1] <= 1'b0;
      control_reg[2] <= 1'b0;
      control_reg[3] <= 1'b0;
      control_reg[4] <= 1'b0;

      if (rst)
        begin
          write_addr_err <= 1'b0;
        end
      else
      // ------------------------ не понимаю что именно нужно сделать -----------------------
       /* if (avs_s0_write)
          begin
            case (avs_s0_address)
                16'h0:  start <= avs_s0_writedata;
                16'h1:  start_N <= avs_s0_writedata; 
                16'h2:  stop <= avs_s0_writedata;
                16'h3:  avto <= avs_s0_writedata;
                16'h4:  invert_pulse <= avs_s0_writedata;
                default:
                  write_addr_err <= 1'b1;
            endcase // case (avs_s0_address)
          end
        else
          if (avs_s0_read)
            begin
				      case (avs_s0_address)
                 16'h0:   avs_s0_readdata <= start;
                 16'h1:   avs_s0_readdata <= start_N;
                 16'h2:   avs_s0_readdata <= stop;
                 16'h3:   avs_s0_readdata <= avto;
                 16'h4:   avs_s0_readdata <= invert_pulse;
                default:
                  avs_s0_readdata <= 32'b0;
              endcase
            end    
            */
            //---------------------------------------------------------------------------------
    end  


reg [SIZE-1:0]          number,        // counter of pulse
                        period_AUTO,   // регистр для записи периода для авто/руч режимов
                        drv_count,     // счетчик общий 
                        count_N,       // счетчик уже сформированных импульсоВ
                        drv_step;

reg                     step,         // регистр для предоконечного значения импульсов (после общего счетчика)
                        pulse_enable, // разрешение работы ШД внутреннее (по командам start/stop) 
                        counter_en;   // регистр разрешение работы счетчика подсчета импульсов 

reg [3:0]               State=0;
reg [3:0]               NextState;

localparam
  IDLE    = 1,
  AUTO    = 2,
  MOVE    = 3,
  MOVE_N  = 4;

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
    NextState = State;
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
        end

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
          if (count_N == N || stop)  
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
              period_AUTO  = n;
              counter_en   = 1'b0;
            end  

          MOVE: 
            begin   
              pulse_enable = 1'b1; // разрешение работы ШД 
              counter_en   = 1'b0; // разрешение работы счетчика count_N
              period_AUTO  = NUM_PERIOD;
            end  

          MOVE_N: 
            begin    
              pulse_enable = 1'b1; // разрешение работы ШД 
              counter_en   = 1'b1; // разрешение работы счетчика count_N
              period_AUTO  = NUM_PERIOD;
            end 

        endcase     
      end       
end
//-------------------------------------------------------------------------------------


//-------------------------- number for counter -----------------------------------------------------------------------------------  
// FIX: нужен ли этот блок как общий, или он должен быть только при условии что 
//      работает автоматический режим
always @(posedge clk)
begin
  if(d_v)
    begin
      number <= period_AUTO;  // assign value to number
    end
end  
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
      if (drv_count <= number + 1)
          drv_count <= drv_count + 1; 
      else 
		      drv_count <= 0;
		end 

//  формирование импульсов и их длительности 
  if (drv_count > 0 && drv_count <= (number + 1) >> 2)	
		step <= 1;
  else 
		step <= 0;

// формирование N импульсов
  if (counter_en)
    begin  
    if (drv_count == 1)
      begin
      if (count_N <= N - 1)
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
