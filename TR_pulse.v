module TR_pulse
 #(
    parameter SIZE=16
  )
  
  (
    input wire                    clk,                            // 50 MHz
    input wire                    rst,                            // reset
    input wire                    data_valid_trig,                // from ADC reading data(this signal has a delay 20 ns)
    
    input                         in_drv_enable_SM,               // work SM
    input        [SIZE-1:0]       N,                              // period for filling with pulse
    
    output reg                    drv_step,                       // pulse for SM
    output reg                    drv_pulse, out
  );
  
    reg          [32:0]           drv_count;                      // counter of pulse
    reg          [SIZE-1:0]       NUMBER;                         // number of counter
     
//-------------------------- number for counter -----------------------------------------------------------------------------------  
always@(posedge clk)
  begin
  if(data_valid_trig)
    begin
      NUMBER<=N;                            // assign value to number
    end
  end  
//-------------------------------------------------------------------------------------------------------------------------------
    
  
  
  
//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
  if (rst)
    begin
      drv_step<=0;
    end
  else if (in_drv_enable_SM==1)             //enable signal of work SM
    begin
      	if (drv_count<=NUMBER+1)
	       begin
		       drv_count<=drv_count+1;            
		          if (drv_count<=(NUMBER+1)>>2)	// form lasting of pulse
		             begin
		               drv_step<=1;
	              	end
	            else 
		             begin
		               drv_step<=0;
		             end
	       end 
       else 
	       begin
		        drv_count<=0;
		        drv_step<=0;
		     end
	   end
end
//------------------------------------------------------------------------------------------------------------------------------	 

endmodule
