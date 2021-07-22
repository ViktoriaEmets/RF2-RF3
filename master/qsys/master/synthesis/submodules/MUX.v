module MUX
#(
    parameter WIDTH_MUX = 16  
)
(
    output reg  [2*WIDTH_MUX-1:0]   drv_period,
    output reg                      drv_dir,
                                    enable,
                                    counter_en,

    input [2*WIDTH_MUX-1:0]         period_TR,
                                    period_TX,
                                    period_TP,
                                    
              
                                    detuning,
                                    fi_phm,

    input                           tr,
                                    tx,
                                    tp,

                                    dir_TR,
                                    dir_TX,
                                    dir_TP, 

                                    drv_en_TR,
                                    drv_en_TX,
                                    drv_en_TP,                                 
                                    counter_en_TR,

                                    //mode_reg,
                                    
                                    syncpulse, 

    input                           clk,
                                    rst
);
    reg                             write_addr_err;

// FIX: есть ли смысл реализовать автоматом
//      не уверена при переходах между состояниями 
/*reg [3:0]         State=0,
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
           
            //else if(fi_phm = detuning)
            //    NextState = TP;
            
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
 */   
//-----------------------------------------------------------------------------------------     

always @(*)
    begin
      if(rst)
        begin
          enable = 0;
        end
      else
        begin
            if (tr)
              begin
               enable         = drv_en_TR;
               drv_period     = period_TR;
               drv_dir        = dir_TR;
               counter_en     = counter_en_TR;
              end

            else if (tx)
              begin
                enable        = drv_en_TX;
                drv_period    = period_TX;
                drv_dir       = dir_TX;
                counter_en    = 1'b0;
              end

            else if (tp)
              begin
                enable        = drv_en_TP; // разрешение работы ШД
                drv_period    = period_TP;
                drv_dir       = dir_TP;
                counter_en    = 1'b0;
              end
        end      
    end          

endmodule
