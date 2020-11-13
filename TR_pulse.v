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
    input reg       drv_enable_SM,             // work SM
    
    input           [WIDTH_IN-1:0]dx,         // dx=x-x0
    input           [WIDTH_WORK-13:0]dx1,     // posinion1=10
    input           [WIDTH_WORK-10:0]dx2,     // position2=100

    output reg      drv_step               // pulse for SM
    
  );
  
  reg             [WIDTH_WORK:0]N_async;      // amount of pulse
  reg 	           [WIDTH_IN-1:0]N; 			        // after d-trigger (write or not data)
  reg             [WIDTH_WORK:0]count=0;      // counter of pulse 
  
  
//------------ finding N-async (number of pulse)----------------------------------------------------------------------------------------------
always@(*)                 
begin 
		if (dx>=dx2)                           // check position of dx
		begin                                  // dx>=100
				N_async=800;
			end
			
		else if( (dx1<=dx) && (dx<dx2))
			begin                                // 10<=dx<100 
				N_async=39600;                     // ((80000-800)/2)
			end
			
	 else if ((0<dx) && (dx<dx1))
			begin                                // 0<dx<10
				N_async=80000;
			end				
end
	
	  //--------------------------- d-trigger ---------------------------------------------------------------------------------------
always@(posedge data_valid or posedge rst) //cheak a condition
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
  if (drv_enable_SM==1)                            // if it's true, make drv_step
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
