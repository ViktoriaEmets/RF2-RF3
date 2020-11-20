module TR_pulse
 #(
    parameter SIZE=16
  )
  (
    input wire      clk,                       // 50 MHz
    input wire      rst,                       // reset
    input wire      data_valid_trig,           // from ADC reading data(this signal has a delay 20 ns)
    
    input           in_drv_enable_SM,             // work SM
    input           [SIZE:0] N,
    
    output reg      drv_step                   // pulse for SM
    
  );
  
    reg             [SIZE:0]drv_count;         // counter of pulse
    reg [16:0]n;
  
always@( posedge data_valid_trig)
  begin
  if(data_valid_trig)
    begin
      n<=N;
    end
  end  
//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@( posedge rst or posedge data_valid_trig)
begin
  if (rst)
    begin
    drv_step<=0;
    end
    
    
  else if (in_drv_enable_SM==1) //enable signal of work SM
    begin
      	if (drv_count<=n+1)
	       begin
		        drv_count<=drv_count+1;
		        drv_step<=drv_step+1;
		       //drv_count=0;
		        //drv_step=0;
	       end 
      else 
	       begin
		        drv_count<=0;
		        drv_step<=0;
		        //drv_count=drv_count-1;
		        //drv_step=drv_step-1;
		     end
		 end
	/*else begin
	      data_valid_trig;
	      drv_step=0;
	     end  	 
	     */    
end
//------------------------------------------------------------------------------------------------------------------------------	 

/*always@(posedge clk)
begin
if (data_valid_trig==1)
  begin
    n=N;
  end 
  	if (drv_count<=n)
  	begin 
  	 drv_count=drv_count+1; 
   end
 end
 */
   
endmodule
