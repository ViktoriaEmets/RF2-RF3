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

                                        //start,
                                       // stop,
                                        //start_N,
                                        
    input [2*WIDTH_TR-1:0]              period_AUTO,
                                        period_MANUAL,
                                        //PULSE_NUMBER,
                                        //DZ_TR,
                                        F1,
                                        F2,
                                        L,
                                        dx1,
                                        dx2                                    

);

/*reg                                     //clk,
                                        //auto,
                                        start,
                                        stop,
                                        start_N;*/

reg [WIDTH_TR-1:0]                      enable_MANUAL_conn,
                                        period_AUTO_conn,
                                        enable_AUTO_conn;


COMMANDS_PARAMETERS COMMANDS_PARAMETERS_insts 
(
    .clk            (clk),
    .auto           (auto),

    //.start          (start),
    //.stop           (stop),
    //.start_N        (start_N),
    //.PULSE_NUMBER   (PULSE_NUMBER),

    .period_MANUAL  (period_MANUAL),
    .dir_MANUAL     (dir_MANUAL),
    .count_MANUAL   (count_MANUAL),

    .F1             (F1),
    .F2             (F2),
    .L              (L),
    //.DZ_TR          (DZ_TR),
    .dx1            (dx1),
    .dx2            (dx2)
);

TR_MANUAL TR_MANUAL_insts
(
    .clk            (clk),

    //.start          (start),
    //.stop           (stop),
    //.start_N        (start_N),
    //.PULSE_NUMBER   (PULSE_NUMBER),

    .enable_MANUAL  (enable_MANUAL_conn)
);

TR_AUTO TR_AUTO_insts
(
    .clk            (clk),

    .F1             (F1),
    .F2             (F2),
    .L              (L),
    //.DZ_TR          (DZ_TR),
    .dx1            (dx1),
    .dx2            (dx2),

    .dir_AUTO       (dir_AUTO_conn),
    .period_AUTO    (period_AUTO_conn),
    .enable_AUTO    (enable_AUTO_conn)
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
