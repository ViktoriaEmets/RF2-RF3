module TP
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

  /*  input wire [7:0]                    avs_s0_address,
    input wire [31:0]                   avs_s0_writedata,

    output reg [31:0]                   avs_s0_readdata,

    input wire                          avs_s0_write,
    input wire                          avs_s0_read     
  */                                    
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
/*
always @(posedge clk)
    begin
      if (rst)
        begin
          write_addr_err <= 1'b0;
        end
      else if (avs_s0_write)
            begin
              case (avs_s0_address)
                8'h0: F1          <= avs_s0_writedata; 
                8'h1: F2          <= avs_s0_writedata;
                8'h2: d_fi_gate2  <= avs_s0_writedata;
                8'h3: DZ_TP       <= avs_s0_writedata;
                8'h4: L        <= avs_s0_writedata;
                8'h5: fi_set      <= avs_s0_writedata;
                8'h6: detuning    <= avs_s0_writedata;
                default:
                  write_addr_err  <= 1'b1;
              endcase
            end
      else if (avs_s0_read)
            begin
              case (avs_s0_address)
                8'h0: avs_s0_readdata <= F1;
                8'h1: avs_s0_readdata <= F2;
                8'h2: avs_s0_readdata <= d_fi_gate2;
                8'h3: avs_s0_readdata <= DZ_TP;
                8'h4: avs_s0_readdata <= L;
                8'h5: avs_s0_readdata <= fi_set;
                8'h6: avs_s0_readdata <= detuning;
                default:
                    avs_s0_readdata <= 32'b0;
              endcase
            end
    end
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
