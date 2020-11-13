module TR_pulse
 #(
    parameter SIZE=16
  )
  (
    input wire      clk,                       // 50 MHz
    input wire      rst,                       // reset
    input wire      data_valid_trig,           // from ADC reading data
    
    input reg       drv_enable_SM,             // work SM
    input reg       N,
    
    output reg      drv_step               // pulse for SM
    
  );
  
    reg             [SIZE:0]drv_count;      // counter of pulse
     
  
//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
      	if (drv_count<=N)
	       begin
	         //count<=count+1;
		        drv_step<=drv_step+1;
		       
	       end 
      else 
	       begin
		        //count<=0;
		        drv_step<=0;
		     end
end
//------------------------------------------------------------------------------------------------------------------------------	 

endmodule
