module TR_MANUAL
#(
parameter  WIDTH_MANUAL             = 16 
)
(
    output reg                            start,
                                          start_N,
                                          stop,
                                          dir_MANUAL,
                                          enable_MANUAL,
                                          count_MANUAL,

    output reg [2*WIDTH_MANUAL-1:0]       period_MANUAL,
                                          PULSE_NUMBER,

    input wire                            clk,
                                          rst,

    input wire [7:0]                      address,
    input wire [31:0]                     writedata,
    output reg [31:0]                     readdata,
    input wire                            write,
    input wire                            read 
);
  reg [2*WIDTH_MANUAL-1:0]                control_reg,
                                          count_N;        

  reg                                     write_addr_err;

  reg [3:0]         state_manual=0,
                    NextState_TR;

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
          control_reg    <= 1'b0;
        end
      else
        begin
          control_reg[0] <= 1'b0; // stop           1
          control_reg[1] <= 1'b0; // start          2
          control_reg[2] <= 1'b0; // start_N        4
         

          if (write)
            begin
              case (address)
                8'h0: control_reg     <= writedata;
                // 8'h1: 
                // 8'h2:
                // 8'h3: 
                // 8'h4:
                8'h5: period_MANUAL   <= writedata;  
                8'h6: PULSE_NUMBER    <= writedata;   
                8'h7: dir_MANUAL      <= writedata; 
                default:
                  write_addr_err  <= 1'b1;
              endcase
            end
          else
            if (read)
              begin
                case (address)
                  8'h0: readdata <= control_reg;
                  // 8'h1: 
                  8'h2: readdata <= state_manual;
                  // 8'h3: 
                  8'h4: readdata <= count_MANUAL;
                  8'h5: readdata <= period_MANUAL;
                  8'h6: readdata <= PULSE_NUMBER;
                  8'h7: readdata <= dir_MANUAL; 
                  default:
                    readdata <= 32'b0;
                endcase
              end
        end
    end   
 
always @(*)
    begin
      stop           = control_reg[0];
      start          = control_reg[1];
      start_N        = control_reg[2];
    
    end

  

always @(posedge clk)
    begin
      if(rst)
        state_manual <= IDLE;
      else
        state_manual <= NextState_TR;
    end

  // по умолчанию сохраняем текущее состояние
always @(*)
    begin
      case (state_manual)
        IDLE:
          begin
                if(start)
                  NextState_TR = MOVE;
                else
                  begin
                    if(start_N)
                      NextState_TR = MOVE_N;
                    else
                      NextState_TR = IDLE;
                  end
          end 

        MOVE:
          begin
            if (stop)
              NextState_TR = IDLE;
            else
              NextState_TR = MOVE;
          end

        MOVE_N:
          begin
            if (count_N > PULSE_NUMBER || stop) 
              begin
                NextState_TR = IDLE;
              end
            else
              begin
                NextState_TR = MOVE_N;
              end
          end
        default:
          NextState_TR = IDLE;
      endcase
    end

  // чтобы значение выхода изменялось вместе с изменением состояния, а не на следующем такте,
  // анализируем NextState_TR
always @(*)
    begin
      if(rst)
        begin
          enable_MANUAL = 0;
        end
      else
        begin
          case(NextState_TR)
            IDLE:
              begin
                enable_MANUAL = 1'b0;
              end

            MOVE:
              begin
                enable_MANUAL  = 1'b1; // разрешение работы ШД
              end
            MOVE_N:
              begin
                enable_MANUAL  = 1'b1; // разрешение работы ШД
              end
          endcase
        end
    end

endmodule
