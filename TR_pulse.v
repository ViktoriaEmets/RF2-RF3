module TR_pulse
 #(
    parameter SIZE       = 16,
    parameter N          = 100,  // nmber of pulse in hand mode
    parameter NUM_PERIOD = 2000 //  для частоты 25 кГц
  )
  
  (
    output reg          drv_pulse,     // pulse for SM

    //----------- input control signals ---------------------------------------------------------------------
    input               clk,           // 50 MHz
                        rst,           // reset
                        d_v,           // from ADC reading data(this signal has a delay 20 ns)
    //-------------------------------------------------------------------------------------------------------

    input               drv_en_SM,     // work SM
    input [SIZE-1:0]    n,             // period for filling with pulse

    //---------------- порт --------------------------------------------------------------------------------
    input               invert_pulse,  // если invert_pulse=1, то на выход подавать инвертированные импульсы
    //------------------------------------------------------------------------------------------------------
reg [3:0]              cr; // control reg
  );

reg [SIZE-1:0]          number,        // counter of pulse
                        period_AUTO,
                        count_N,
                        drv_count;

reg [31:0]              cr; // control reg

reg                     drv_invert_step,
                        step,
                        step_N,
                        drv_step;  

//-------------- команды -------------------------------------------------------------------------------
   reg                  start     = cr[0],
                        start_N   = cr[1],
                        stop      = cr[2],
                        avto      = cr[3],
                        invert_pulse = cr[5] // инвертировать импульсы 
//------------------------------------------------------------------------------------------------------  

reg [3:0]               regime;

localparam
  IDLE    = 1,
  MOVE    = 2,
  MOVE_N  = 3,
  AUTO    = 4;

//------------------------------------------------------------------------------------
always@(posedge clk)
begin
case(regime)
 //------------ переключение между состояниями --------------------------------------
 // переделать вместо отдельных сигналов сделать один регистр
 
 IDLE:
 begin
  if (avto)
    begin
      regime<=AUTO;
    end  

  else if(start)
      begin
        regime<=MOVE;     	           
      end 

  else if (start_N)
    begin
      regime<=MOVE_N;
    end

  else 
    begin
      regime<=IDLE;
    end  
 end

AUTO:
 begin
  if (!avto)
    begin
      regime <= IDLE;
    end

    // во всем автомате сделать так чтобы был только переход между состояниями 
    // посмотри статью еще раз и наверно попытайся сделать в два блока always 
  /*else 
      begin
        period_AUTO <= n;
      end */
 end

MOVE:
 begin
  if (stop)
    begin
      regime<=IDLE;
    end
  /*else 
      begin
        period_AUTO <=NUM_PERIOD;
      end */
 end

 MOVE_N:
 begin
  if (drv_count==0 || stop==1)
    begin
      regime<=IDLE;
    end
  //-------------------------------------------------------------------------------------------  
  /*else 
      begin
        period_AUTO <=NUM_PERIOD;
      end */  
    /*  if (count_N >= N)
	       begin
		       count_N <= count_N-1;   
           step_N <=1;          
	       end 
       else 
	       begin
		        count_N<=0;
            step_N <=0;
         end
    */
    end
  //--------------------------------------------------------------------------------  

default:
      regime <= IDLE;
endcase 
end
//----------------------------------------------------------------------------------------


//-------------------------- number for counter -----------------------------------------------------------------------------------  
always@(posedge clk)
  begin
  if(d_v)
    begin
      number<=period_AUTO;  // assign value to number
    end
  end  
//-------------------------------------------------------------------------------------------------------------------------------
     
  
//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
//------------------------------- счетчик ----------------------------------------------
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
//--------------------------------------------------------------------------------------------------



// ----------------------- не уверена --------------------------------------------------------------
//------------------------------- формирование N импульсов -----------------------------------------
 /*    if (start_N)   
        begin
          if (count_N >= N)
	          begin
		          count_N <= count_N-1;   
              step <=1;          
	          end 
          else 
	          begin
		          count_N <= 0;
               step <= 0;
            end
        end   */
//--------------------------------------------------------------------------------------------------



// ----------------------- формирование импульсов и их длительности --------------------------------
      else if (drv_count>0 && drv_count<=(number+1) >>2)	// form lasting of pulse
		             begin
		               step<=1;
	              	end
	            else 
		             begin
		               step<=0;
		             end
//---------------------------------------------------------------------------------------------------  


// ------------------------------------ фиксированное кол-во импульсов или нет ----------------------
/*
always @(posedge clk)
begin
  if (start_N)
    begin
      drv_step <= step_N;
    end
  else
    begin
      drv_step <= step;
    end
end */    
//---------------------------------------------------------------------------------------------------


//---------------------------- выходной сигнал  ---------------------------------------------------
always @(posedge clk)
begin
 drv_pulse <= step^cr[5]; // юит определяет прямой сигнал или инвертированный 
end
//----------------------------------------------------------------------------------------------------------------------------------------


endmodule
