module TR   // мультиплексор для определения ручного или автоматического режима TR
#(
    parameter WIDTH_TR       = 16
  )
(
    output reg                          drv_en_TR,      // разрешение работы ШД в режиме TX
                                        dir_TR,         // направление вращения режим TX
                                        counter_en_TR,  // разрешение счетчику заданного количества импульсов        
    
    output reg [WIDTH_TR-1:0]           period_TR,      // период импульсов, в PULSE

    input wire                          clk,
                                        rst,

    input                               dir_AUTO,
                                        dir_MANUAL,
                                        auto,
                                        enable_AUTO,
                                        enable_MANUAL,
                                        count_MANUAL,
                                        
    input [WIDTH_TR-1:0]                period_AUTO,
                                        period_MANUAL                                    

);

always @(*)
    begin
        if (auto) // режим AUTO
            begin 
                period_TR       = period_AUTO;
                dir_TR          = dir_AUTO;
                drv_en_TR       = enable_AUTO;
                counter_en_TR   = 1'b0;
            end
        else      // режим MANUAL
            begin
                period_TR       = period_MANUAL;
                dir_TR          = dir_MANUAL;
                drv_en_TR       = enable_MANUAL;
                counter_en_TR   = count_MANUAL; 
            end    
    end            

endmodule
