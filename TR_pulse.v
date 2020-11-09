//------------------------- NOT SURE -------------------------------------------------------------------------------------------
package TR_pulse;


//--------------------------- d-trigger ---------------------------------------------------------------------------------------
always@(posedge clk or posedge rst)
begin
	if(rst)
		begin
			N<=0; 		                             // not write data
		end
	else if (data_valid==1)
		begin
			N<=N_async;	                         // write data
		end
end
//-----------------------------------------------------------------------------------------------------------------------------	


//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
  if (drv_SM==1)                           // if it's true, make drv_step
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

endpackage	
