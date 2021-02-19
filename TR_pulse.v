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

    input               drv_en_SM,     // work SM, разрешение работы ШД внешнее
    input [SIZE-1:0]    n,             // period for filling with pulse



  reg [31:0]              cr          // control reg КАК СДЕЛАТЬ??? ТУТ ЛИ ОН ДОЛЖЕН БЫТЬ?
  );

reg [SIZE-1:0]          number,        // counter of pulse
                        period_AUTO,   // регистр для записи периода для авто/руч режимов
                        count_N,       // счетчик уже сформированных импульсов 
                        drv_count;     // счетчик общий 


reg                     step,         // регистр для предоконечного значения импульсов (после общего счетчика)
                        step_N,       // регистр для N импульсов (НУЖЕН ЛИ ОН?)
                        cnt_en;       // разрешение работы ШД
                        

//-------------- команды (КАК ИХ ПРАВИЛЬНО ЗАПИСАТЬ ?)-------------------------------------------------------------------------------
   reg                  start     = cr[0],
                        start_N   = cr[1],
                        stop      = cr[2],
                        avto      = cr[3],
                        invert_pulse = cr[5]; // инвертировать импульсы 
//------------------------------------------------------------------------------------------------------  

reg [3:0]               State=0;
reg [3:0]               NextState;


localparam
  IDLE    = 1,
  AUTO    = 2,
  MOVE    = 3,
  MOVE_N  = 4;
 

always @(posedge clk)
begin
  if(rst)
    State <= IDLE;
  else
    State <= NextState;
end


always @(*)
begin
  // по умолчанию сохраняем текущее состояние 
    NextState = State;
    case (State)

      IDLE: 
        begin
          if(avto) 
            begin
              NextState = AUTO;
            end
          else if(start) 
            begin
              NextState = MOVE;
            end
          else if(start_N) 
            begin
              NextState = MOVE_N;
            end  
        end

      AUTO:
        begin
          if (!avto)
            begin
              NextState = IDLE;
            end
          else
            begin
              NextState = AUTO;
            end  
        end

      MOVE:
        begin
          if (stop)
            begin
              NextState = IDLE;
            end
          else
            begin
              NextState = MOVE;
            end  
        end

      MOVE_N:
        begin
          if (count_N==0 || stop==1)  
            begin
              NextState = IDLE;
            end
          else
            begin
              NextState = MOVE_N;
            end  
        end  
  
      default:
        NextState = IDLE;
    endcase 
end

// задание выхода
always @(posedge clk)
begin
    if(rst)
      begin
        
        cnt_en      <= 0;
        period_AUTO <= 0;
      end
    else
      begin
        //чтобы значение выхода изменялось вместе с изменением
        //состояния, а не на следующем такте, анализируем NextState
        case(NextState)
         
          IDLE: 
            begin    
              
              cnt_en      <= 0;
              period_AUTO <= 0;
            end

          AUTO: 
            begin    
              
              cnt_en      <= drv_en_SM;
              period_AUTO <= n;
            end  

          MOVE: 
            begin    
              
              cnt_en      <= 1;
              period_AUTO <= NUM_PERIOD;
            end  

          MOVE_N: 
            begin    
              
              cnt_en      <= 1;
              period_AUTO <= NUM_PERIOD;
              
            end  
        endcase     
      end       
end


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

  else if (cnt_en==1)    //enable signal of work SM
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


// ----------------------- формирование импульсов и их длительности --------------------------------
  else if (drv_count>0 && drv_count<=(number+1) >>2)	// form lasting of pulse
		      begin
		        step<=1;
	        end
	      else 
		      begin
		        step<=0;
		      end

if (cnt_en)
begin
  if() // что должно юыть?
    begin
      count_N <= 0;
    end
  else
    begin
      count_N <= count_N - 1;
    end    
end


end            
//---------------------------------------------------------------------------------------------------  


//---------------------------- выходной сигнал  ---------------------------------------------------
always @(posedge clk)
begin
 drv_pulse <= step^cr[5]; // юит определяет прямой сигнал или инвертированный 
end
//----------------------------------------------------------------------------------------------------------------------------------------


endmodule
