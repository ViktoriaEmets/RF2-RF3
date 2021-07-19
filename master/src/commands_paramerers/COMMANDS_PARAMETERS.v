module COMMANDS_PARAMETERS
(
    output reg                      start,         // непрерывное формирования импульсов, в TR_MANUAL
                                    start_N,       // формирования N импульсов, в TR_MANUAL 
                                    stop,          // выход в неопределенное состояние, в TR_MANUAL (нет импульсов вообще)

                                    dir_MANUAL,    // направление вращения, в TR
                                    count_MANUAL,  // разрешение работы счетчика уже сформированных импульсов, в TR

    output  reg [WIDTH_TP-1:0]      F1,            // мин.частота работы станции, в TR_AUTO, TX, TP
                                    F2,            // макс.частота работы станции, в TR_AUTO, TX, TP

                                    L,             // для повышения точности изменения скорости, L=16, в TR_AUTO, TX, TP
                                                   // ASK: может лучше сделать parameter L для каждого модуля отдельно 
                                        
                                    period_MANUAL, // период, импульсов для ручного режима, в TR 
                                    PULSE_NUMBER,  // количество импульсов для ручного режима, в TR_MANUAL
                                    
                                    DZ_TR,         // граница зоны нечувствительности, в TR_AUTO
                                    DZ_TX,         // в TX
                                    DZ_TP,         // в TP

                                    dx1,           // граница изменения скорости смещения в TR_AUTO
                                    dx2,           // дальняя граница изменения скорости TR_AUTO
                                    d_i_gate2,     // дальняя граница в TX
                                    d_fi_gate2,    // дальняя граница в TP

    input                           clk,                    // 50 MHz
                                    rst,                    // reset

    input wire [15:0]               avs_s0_address,        // ширина может быть 1-64
    input wire [31:0]               avs_s0_writedata,
    output reg [31:0]               avs_s0_readdata,
    input wire                      avs_s0_write,
    input wire                      avs_s0_read   
);
   
    reg                                 write_addr_err;
    
    reg [31:0]                          control_reg;

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

          if (avs_s0_write)
            begin
              case (avs_s0_address)
            // ASK: можно ли сделать такое перечисление 
            //      есть  ли числа 16'hA или 16'h10?

            //------------------- TR_MANUAL --------------------
                16'h0: control_reg   <= avs_s0_writedata;
                16'h1: period_MANUAL <= avs_s0_writedata;
                16'h2: PULSE_NUMBER  <= avs_s0_writedata;
                16'h3: dir_MANUAL    <= avs_s0_writedata;
                16'h4: count_MANUAL  <= avs_s0_writedata;
            //-------------------- общее ------------------------
                16'h5: F1            <= avs_s0_writedata; 
                16'h6: F2            <= avs_s0_writedata;
                16'h7: L             <= avs_s0_writedata;
            //-------------------- TR_AUTO ----------------------
                16'h8: dx1          <= avs_s0_writedata;
                16'h9: dx2          <= avs_s0_writedata;
                16'hA: DZ_TR        <= avs_s0_writedata;
            //--------------------- TX --------------------------    
                16'hB: d_i_gate2    <= avs_s0_writedata;
                16'hC: DZ_TX        <= avs_s0_writedata;
            //--------------------- TP --------------------------    
                16'hD: d_fi_gate2   <= avs_s0_writedata;
                16'hE: DZ_TP        <= avs_s0_writedata;

                default:
                  write_addr_err  <= 1'b1;
              endcase
            end
      else if (avs_s0_read)
            begin
              case (avs_s0_address)
            //------------------- TR_MANUAL --------------------
                16'h0: avs_s0_readdata <= control_reg;
                16'h1: avs_s0_readdata <= period_MANUAL;
                16'h2: avs_s0_readdata <= PULSE_NUMBER;
                16'h3: avs_s0_readdata <= dir_MANUAL;
                16'h4: avs_s0_readdata <= count_MANUAL;
            //-------------------- общее ------------------------    
                16'h5: avs_s0_readdata <= F1;
                16'h6: avs_s0_readdata <= F2;
                16'h7: avs_s0_readdata <= L;
            //-------------------- TR_AUTO ----------------------
                16'h8: avs_s0_readdata <= dx1;
                16'h9: avs_s0_readdata <= dx2;
                16'hA: avs_s0_readdata <= DZ_TR;
            //--------------------- TX --------------------------
                16'hB: avs_s0_readdata <= d_i_gate2;
                16'hC: avs_s0_readdata <= DZ_TX;
            //--------------------- TP --------------------------
                16'hD: avs_s0_readdata <= d_fi_gate2;
                16'hE: avs_s0_readdata <= DZ_TP; 

                default:
                    avs_s0_readdata <= 32'b0;
              endcase
            end
    end

    always @(*)
    begin
      stop           = control_reg[0];
      start          = control_reg[1];
      start_N        = control_reg[2];
    end

endmodule
