module TR_MANUAL  // Режим ручной выстовки тюнеров
#(
parameter  WIDTH_MANUAL             = 16 
)
(
    input                                 start,
                                          start_N,
                                          stop,

    output reg                            enable_MANUAL,   // разрешение работы ШД, в TR
                                          
    input [2*WIDTH_MANUAL-1:0]            PULSE_NUMBER,
                                          count_N,         // счетчик сформированных импульсов 

    input wire                            clk,
                                          rst
);

  reg [3:0]         state_manual=0,
                    NextState_TR;

  localparam
    IDLE    = 1,
    MOVE    = 2,
    MOVE_N  = 4;


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
