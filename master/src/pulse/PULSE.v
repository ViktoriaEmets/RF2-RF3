module PULSE    // Модуль формирования импульсов в зависимости от режимав работы 
#(
    parameter WIDTH = 16
)
(
    output                          drv_pulse,
    output reg                      drv_dir,

    
    input                           clk,
                                    rst,                          
);

reg                                 pulse_invert,
                                    drv_step;

reg [WIDTH-1:0]                     count_N,
                                    drv_count,
                                    drv_period;
                                           
always @(posedge clk)
    begin
      if (rst || enable == 0)
        begin
          drv_count<=0;
        end
      else
        begin
          if (drv_count <= drv_period)
            drv_count <= drv_count + 1;
          else
            drv_count <= 0;
        end

      //  формирование импульсов и их длительности
      if (  (drv_count > 0) && (drv_count <= drv_period  >> 2))
        drv_step  <= 1;
      else
        drv_step  <= 0;

// формирование PULSE_NUMBER импульсов
      if (counter_en)
        begin
          if (drv_count == 1)
            begin
              if (count_N <= PULSE_NUMBER)
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
    

assign drv_pulse = drv_step ^ pulse_invert; 

endmodule
