module TR_pulse
 #(
    parameter SIZE   = 16,
    parameter N      = 100,  // nmber of pulse in hand mode
    parameter NUM_PERIOD = 2000 //  для частоты 25 кГц
  )
  
  (
    output reg          drv_pulse,       // pulse for SM

    //----------- input control signals ------------------------------------------
    input               clk,           // 50 MHz
                        rst,           // reset
                        d_v,           // from ADC reading data(this signal has a delay 20 ns)
    //----------------------------------------------------------------------------


    input               drv_en_SM,     // work SM
    input [SIZE-1:0]    n,             // period for filling with pulse


    //---------------- порт ---------------------------------------------------------
    input               invert_pulse = 1, // если invert_pulse=1, то на выход подавать инвертированные импульсы
    //-------------------------------------------------------------------------------


    //-------------- команды -------------------------------------------------------
    input               stop,
                        start,
                        start_N,
                        avto
    //--------------------------------------------------------------------------------------   

  );

reg [SIZE-1:0]          number,        // counter of pulse
                        period,
                        count_N,
                        drv_count;
reg                     drv_invert_step;
                        step;
                        step_N;
                        drv_step;        

reg [3:0]          regime;

localparam
  IDLE    = 3'b0001,
  MOVE    = 3'b0010,
  MOVE_N  = 3'b0100,
  AUTO    = 3'b1000;

//------------------------------------------------------------------------------------
always@(posedge clk)
begin
case(regime)
 //------------ переключение между состояниями --------------
 IDLE:
 begin
  if(start)
      begin
        regime<=MOVE;     	           
      end 

  else if (start_N)
    begin
      regime<=MOVE_N;
    end

  else if (avto)
    begin
      regime<=AUTO;
    end  

  else 
    begin
      regime<=IDLE;
    end  
 end

MOVE:
 begin
  if (stop)
    begin
      regime<=IDLE;
    end
  else 
      begin
        period <=NUM_PERIOD;
      end 

     /* begin
      	if (count_N<=NUM_PERIOD)
	       begin
		       count_N<=count_N+1;             
	       end 
       else 
	       begin
		        count_N<=0;
		     end
	   end  */ 
 end

 MOVE_N:
 begin
  if (count_N==0)
    begin
      regime<=IDLE;
    end
  else 
    begin
      if (count_N >= N)
	       begin
		       count_N <= count_N-1;   
           step_N <=0;          
	       end 
       else 
	       begin
		        count_N<=1;
            step_N <=1;
         end
    end
 end

 AUTO:
 begin
  if (!avto)
    begin
      regime <= IDLE;
    end
  else 
      begin
        period <= n;
      end 
 end
//----------------------------------------------------------------------------------------


//-------------------------- number for counter -----------------------------------------------------------------------------------  
always@(posedge clk)
  begin
  if(d_v)
    begin
      number<=period;  // assign value to number
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
  else if (drv_en_SM==1)    //enable signal of work SM
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

      if (drv_count>0 && drv_count<=(number+1) >>2)	// form lasting of pulse
		             begin
		               step<=1;
	              	end
	            else 
		             begin
		               step<=0;
		             end

      if (rst)
        begin
          drv_invert_step<=0;
        end
      else
        begin
          drv_invert_step<=!step;
        end  

end
//------------------------------------------------------------------------------------------------------------------------------	 

always @(posedge clk)
begin
  if (start_N)
    begin
      drv_step <= ;
    end
  else
    begin
      drv_step <= step;
    end
end      

//---------------------------- выходной сигнал  ---------------------------------------------------
always @(posedge clk)
begin
  if (invert_pulse==1)
    begin
      drv_pulse <=drv_invert_step;
    end
  else  
    begin
      drv_pulse <=drv_step;
    end
end
//----------------------------------------------------------------------------------------------------------------------------------------


endmodule
