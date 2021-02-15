module TR_pulse
 #(
    parameter SIZE   = 16,
    parameter N      = 100,  // nmber of pulse in hand mode
    parameter NUM_PERIOD = 2000 //  для частоты 25 кГц
  )
  
  (
    //----------- input control signals ------------------------------------------
    input               clk,           // 50 MHz
                        rst,           // reset
                        d_v,           // from ADC reading data(this signal has a delay 20 ns)
    //----------------------------------------------------------------------------

    input               drv_en_SM,     // work SM

    input [SIZE-1:0]    n,             // period for filling with pulse
    
    output reg          drv_step       // pulse for SM
 
  );

reg [SIZE-1:0]          number,        // counter of pulse
                        drv_count;
reg                     drv_invert_step;        


localparam
  IDLE    = 4'b00001,
  MOVE    = 4'b00010,
  MOVE_N  = 4'b00100,
  STOP    = 4'b01000,
  AUTO    = 4'b10000;

reg [4:0]          regime;


//------------------------------------------------------------------------------------
// МОЖНО ЛИ СДЕЛАТЬ ТАК?
always @(posedge clk)
begin


  if (regime|=1<<1) // записать единицу в первый бит 
                    // импульсы идут постоянно      
    begin // что-то сдеоать с импульсами, чтобы они постоянно работали?
      if (drv_en_SM <= 1)
      begin
      	if (drv_count<=NUM_PERIOD)
	       begin
		       drv_count<=drv_count+1;             
	       end 
       else 
	       begin
		        drv_count<=0;
		     end
	   end

      if (drv_count>0 && drv_count <= NUM_PERIOD >>2)	// form lasting of pulse
		             begin
		               drv_step<=1;
	              	end
	            else 
		             begin
		               drv_step<=0;
		             end
    end


  else if (regime|=1<<2) // записать единицу во второй бит
                         // импульсы идут N раз 
          begin
            // как сделать так чтобы импульсов было определенное кол-во
          end    


  else if (regime|=1<<3) // записать единицу в третий бит    
                         // нет импульсов
          begin
            drv_en_SM <= 0;
            drv_step <= 0;
          end   


  else if (regime|=1<<4) // записать единицу в старший бит
                         // автоматический режим 
          begin
            // как сделать ? как правильнее сослаться на блоки ниже? 
          end                                         
end


/* 
// переход между состояниями - вообще нет идей 
always @(posedge clk)
begin
  if (rst)
    begin
      regime <= IDLE; // шд не вращаются 
    end
  else
    begin
      case (regime)

      IDLE:
        begin
          // шд не вращаются
          // приходит некоторая команда 
          // команда = "1"
          regime <= AUTO;
          // команда = "0"
          regime <= MOVE;
        end


      MOVE:
        begin
          // ваполняются какие-то условия в том числе  
          // drv_en_SM = 1
          // начинают идти импульсы
          // как только N заданно определенному числу
          regime <= MOVE_N; 
        end


      MOVE_N:
       begin
          // как только  drv_en_SM = 0
           regime <= STOP;
        end


      STOP:  
       begin
          regime <= IDLE;
        end


      AUTO:
       begin
        // режим работы описан ниже 
        end
      
      default:
             regime <= IDLE;

      endcase 

    end
end*/
//----------------------------------------------------------------------------------------






//-------------------------- number for counter -----------------------------------------------------------------------------------  
always@(posedge clk)
  begin
  if(d_v)
    begin
      number<=n;  // assign value to number
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
		               drv_step<=1;
	              	end
	            else 
		             begin
		               drv_step<=0;
		             end
end
//------------------------------------------------------------------------------------------------------------------------------	 


//---------------------------- invert step ---------------------------------------------------
always @(posedge clk)
begin
  if (rst)
    begin
      drv_invert_step<=0;
    end
  else
    begin
      drv_invert_step<=!drv_step;
    end  
end
//----------------------------------------------------------------------------------------------------------------------------------------


endmodule
