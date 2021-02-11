module TR_pulse
 #(
    parameter SIZE=16
  )
  
  (
    //----------- input control signals ------------------------------------------
    input                         clk,              // 50 MHz
                                  rst,              // reset
                                  d_v,              // from ADC reading data(this signal has a delay 20 ns)
    //----------------------------------------------------------------------------

    input                         drv_en_SM,        // work SM

    input [SIZE-1:0]              N,                // period for filling with pulse
    
    output reg                    drv_step          // pulse for SM
 
  );
  
    reg [SIZE-1:0]                number;           // counter of pulse
    reg [SIZE-1:0]                drv_count;        // counter of pulse
                          
    
    

//-------------------------- number for counter -----------------------------------------------------------------------------------  
always@(posedge clk)
  begin
  if(d_v)
    begin
      number<=N;                                    // assign value to number
    end
  end  
//-------------------------------------------------------------------------------------------------------------------------------
    
  
  
  
//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
  if (rst)
    begin
      drv_count<=0;
    end
  else if (drv_en_SM==1)                            //enable signal of work SM
    begin
      	if (drv_count<=number+1)
	       begin
		       drv_count<=drv_count+1;             
	       end 
       else 
	       begin
		        drv_count<=0;
		     end
	   end

      if (drv_count>0 && drv_count<=(number+1) >>2)	                // form lasting of pulse
		             begin
		               drv_step<=1;
	              	end
	            else 
		             begin
		               drv_step<=0;
		             end
end
//------------------------------------------------------------------------------------------------------------------------------	 

endmodule
