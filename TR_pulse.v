//------------------------- NOT SURE -------------------------------------------------------------------------------------------
module TR_pulse
  #(
    parameter       WIDTH_IN=12,              // x,x0,dx
    parameter       WIDTH_WORK=16             // dx1,dx2,v1,v2,v,N,count 
  )
  (
    input wire      clk,                      // 50 MHz
    input wire      rst,                      // reset
    input wire      data_valid,               // from ADC reading data
    output reg      drv_step=0,               // pulse for SM
    output reg      drv_SM                    // work SM
  );
  
  reg 	           [WIDTH_IN-1:0]N; 			        // after d-trigger (write or not data)
  reg             [WIDTH_WORK:0]count=0;      // counter of pulse 
  reg             [WIDTH_WORK:0]N_async;      // amount of pulse
  
//--------------------------- d-trigger ---------------------------------------------------------------------------------------
always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
			N<=0; 		                               // not write data
		end
	else if (data_valid==1)
		begin
			N<=N_async;	                           // write data
		end
end
//-----------------------------------------------------------------------------------------------------------------------------	


//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
  if (drv_SM==1)                            // if it's true, make drv_step
    begin
      	if (count<=N)
	       begin
	         count<=count+1;
		        drv_step<=1;
	       end 
      else 
	       begin
		        count<=0;
		        drv_step<=0;
	       end	
	  end
	else 
	  begin 
	     drv_step<=0;
	  end
end
//------------------------------------------------------------------------------------------------------------------------------	 

endmodule
