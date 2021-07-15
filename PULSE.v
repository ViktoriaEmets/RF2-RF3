module PULSE
#(
    parameter WIDTH = 16
)
(
    output                          drv_pulse,
    output reg                      drv_dir,

    input [2*WIDTH-1:0]             period_TR,
                                    period_TX,
                                    period_TP,
                                    PULSE_NUMBER,
              
                                    detuning,

    input                           dir_TR,
                                    dir_TX,
                                    dir_TP, 

                                    drv_en_TR,
                                    drv_en_TX,
                                    drv_en_TP,                                 
                                    counter_en_TR,

                                    clk,
                                    rst,

                                    syncpulse,
                                    fi_phm                           
);

reg                                 pulse_invert,
                                    counter_en,
                                    enable,
                                    drv_step,
                                    write_addr_err;

reg [WIDTH-1:0]                     count_N,
                                    drv_count,
                                    drv_period;

                                             

//-----------------------------------------------------------------------------------------------------------------------------	

  //-----------------------------------------------------------------------------------


// FIX: есть ли смысл реализовать автоматом
//      не уверена при переходах между состояниями 
reg [3:0]         State=0,
                  NextState;
localparam
    TR    = 1,
    TX    = 2,
    TP    = 3;

always @(posedge clk)
    begin
      if(rst)
        State <= TR;
      else
        State <= NextState;
    end

always @(*)
    begin
      case (State)
        TR:
        begin
            if(syncpulse)
                NextState = TX;
            /*
            else if(fi_phm = detuning)
                NextState = TP;
            */
            else
                NextState = TR;
        end  
        TX:
          begin
            if (fi_phm == detuning)
              NextState = TP;
            else if(syncpulse)
              NextState = TX;
          end
        TP:
          begin
            if (fi_phm > detuning)
              NextState = TX;
            else
              NextState = TP;
          end
        default:
          NextState = TR;
      endcase
    end    
//-----------------------------------------------------------------------------------------
always @(*)
    begin
      if(rst)
        begin
          enable = 0;
        end
      else
        begin
          case (NextState)
            TR:                                         
              begin
               enable         = drv_en_TR;
               drv_period     = period_TR;
               drv_dir        = dir_TR;
               counter_en     = counter_en_TR;
              end
            TX:
              begin
                enable        = drv_en_TX;
                drv_period    = period_TX;
                drv_dir       = dir_TX;
                counter_en    = 1'b0;
              end
            TP:
              begin
                enable        = drv_en_TP; // разрешение работы ШД
                drv_period    = period_TP;
                drv_dir       = dir_TP;
                counter_en    = 1'b0;
              end
          endcase
        end
    end
//-----------------------------------------------------------------------------------------

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
