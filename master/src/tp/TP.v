module TP  // Режим TP, настройка по фазометру 
#(
    parameter WIDTH_TP       = 16
)
(
    output reg                          drv_en_TP,
                                        dir_TP,

    output reg [WIDTH_TP-1:0]           period_TP,                             

    input wire                          clk,
                                        rst,
                                        data_valid_TP,
                                        tp_mode,

    input [WIDTH_TP-1:0]                fi_phm,          // разность с фазометра
                                        fi_set,          // уставка
                                        detuning,        // заданная расстройка
                                        F1,              // частота минимальная
                                        F2,              // частолта максимальная 
                                        DZ_TP,
                                        L,
                                        d_fi_gate2,
                                        k_TP                       
);

reg [WIDTH_TP-1:0]                      d_fi;

reg                                     sign_TP,
                                        write_addr_err;

reg [3:0]                               state_TP = 0;  
reg [35:0]                              n_TP;                                      

/*reg [WIDTH_TP-1:0]                    F1,
                                      F2,
                                      d_fi_gate2,
                                      DZ_TP,
                                      L,
                                      fi_set,
                                      detuning;
*/  

//----------------------переход между состояниями ---------------------------------------------------------------------------
localparam
	START_TP            = 0,   
	TO_ZERO_TP          = 1,   
	PASS_DZ_TP          = 2;   

always@(posedge clk)
begin
case(state_TP)

  START_TP:    
  begin
    if(tp_mode == 1)
      begin
        state_TP <= TO_ZERO_TP;     	           
        drv_en_TP <= 1'b1;
      end 
    else begin
      state_TP <= START_TP;
    end
  end 
  
  TO_ZERO_TP:    
  begin
     if (tp_mode == 0)
          begin
            state_TP <= START_TP;            
          end       
     else if(d_fi==0)
          begin
            state_TP <= PASS_DZ_TP;               
            drv_en_TP <= 1'b0;
          end 
   end
  
   PASS_DZ_TP: 
   begin
      if (tp_mode == 0)
          begin
            state_TP <= START_TP;            
          end   
     else if (d_fi >= DZ_TP)
          begin
            state_TP <= TO_ZERO_TP;             
            drv_en_TP <= 1'b1;
          end 
   end    

default
  state_TP <= START_TP;                       
endcase     
end

//-----------------------------------------------------------------------------------
always @*
  begin
    if (fi_phm > fi_set)
      begin
        d_fi = fi_phm - fi_set;
        sign_TP = 1'b1;
      end
    else    
      begin
        d_fi = fi_set - fi_phm;
        sign_TP = 1'b0;
      end
  end

always @(posedge clk)
  begin
    if (sign_TP == 1'b0)
      begin
        dir_TP <= 1'b1;
      end
    else
      begin
        dir_TP <= 1'b0;
      end    
  end   

//---------------период изменение -----------------------------------------------------------------------
always @(posedge clk)
    begin
 //       if (fi_phm == 70)
 //           begin
                if (d_fi > d_fi_gate2)
                    begin
                        n_TP <= F2;
                    end
                else if ( (DZ_TP <= d_fi) && (d_fi < d_fi_gate2))
		            begin                           
			            n_TP <= ((k_TP * (d_fi - DZ_TP)) / L) + F1;
		            end	
//            end
//	    else 
//		    begin                                
//			    n_TP <= 0;
//		    end		
    end   

always@(posedge data_valid_TP or posedge rst)  //cheak a condition
begin
	if(rst)
		begin
			period_TP <= 0; 		                    // not write data
		end	
	else if (data_valid_TP == 1)
		begin
			period_TP <= n_TP[19:3];	            // write data
		end
end

endmodule
