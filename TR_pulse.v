module TR_pulse
 #(
    parameter SIZE=16
  )
  (
    input wire      clk,                       // 50 MHz
    input wire      rst,                       // reset
    input wire      data_valid_trig,           // from ADC reading data(this signal has a delay 20 ns)
    
    input           in_drv_enable_SM,          // work SM
    input           [SIZE:0]N,                 // period for filling with pulse
    
    output reg      drv_step,                  // pulse for SM
    output reg      drv_pulse
  );
  
    reg             [16:0]drv_count;           // counter of pulse
    reg             [16:0]number;              // number of counter 
    
    
//-------------------------- number for counter -----------------------------------------------------------------------------------  
always@(posedge clk)
  begin
  if(data_valid_trig)
    begin
      number<=N;                               // assign value to number
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
    
  else if (in_drv_enable_SM==1) //enable signal of work SM
    begin
      	if (drv_count<=number+1)
	       begin
		        drv_count<=drv_count+1;
		        drv_step<=0;
		      
	       end 
      else 
	       begin
		        drv_count<=0;
		        drv_step<=1;
		       
		     end
		 end
end
//------------------------------------------------------------------------------------------------------------------------------	 



always@(posedge clk)
  begin
  if(drv_count==0)
    begin
        drv_pulse<=0;                            // assign value to number
    end
  else begin drv_pulse <=1; end  
  end  


   
endmodule
