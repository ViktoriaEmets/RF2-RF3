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
  );

reg [SIZE-1:0]          number,        // counter of pulse
                        period_AUTO,   // регистр для записи периода для авто/руч режимов
                        count_N,       // счетчик уже сформированных импульсов 
                        drv_count;     // счетчик общий 
                        drv_step


reg                     step,         // регистр для предоконечного значения импульсов (после общего счетчика)
                        step_N,       // регистр для N импульсов (НУЖЕН ЛИ ОН?)
                        pulse_enable, // разрешение работы ШД внутреннее (по командам start/stop) 
                        cnt_en;       // регистр разрешение работы ШД

reg [31:0]              control_reg           

wire                    start,
                        start_N,
                        stop,
                        avto,
                        invert_pulse;        
//-------------- команды -------------------------------------------------------------------------------
assign                  
  start     = control_reg[0],
  start_N   = control_reg[1],
  stop      = control_reg[2],
  avto      = control_reg[3],
  invert_pulse = control_reg[5]; // инвертировать импульсы                    
//------------------------------------------------------------------------------------------------------                         

//---------------------- сигнал разрешения и прерывания импульсов -----------------
always @(posedge clk) 
begin
  if (rst)
        pulse_enable <= 1'b0;
  else
    begin
      if (start)
        pulse_enable <=1'b1;

      if (stop)
        pulse_enable <=1'b0;
    end
end    
//----------------------------------------------------------------------------------------


reg [3:0]               State=0;
reg [3:0]               NextState;

localparam
  IDLE    = 1,
  AUTO    = 2,
  MOVE    = 3,
  MOVE_N  = 4;

 //-----------------------------------------------------------------------------------
always @(posedge clk)
begin
  if(rst)
    State <= IDLE;
  else
    State <= NextState;
end

 // по умолчанию сохраняем текущее состояние 
always @(*)
begin
 
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

// чтобы значение выхода изменялось вместе с изменением состояния, а не на следующем такте, 
// анализируем NextState
always @(posedge clk)
begin
    if(rst)
      begin
        cnt_en      <= 0;
      end
    else
      begin
        
        case(NextState)
         
          IDLE: 
            begin    
              cnt_en      <= 0;
            end

          AUTO: 
            begin  
              cnt_en      <= drv_en_SM;
            end  

          MOVE: 
            begin   
              cnt_en      <= pulse_enable;
            end  

          MOVE_N: 
            begin    
              cnt_en      <= pulse_enable;
            end 

        endcase     
      end       
end
//-------------------------------------------------------------------------------------

//------------------- мультиплексор --------------------------------------------
always @(*)
begin
  period_AUTO = avto ? n : NUM_PERIOD; // если avto=1, period_AUTO=n
                                       // если avto=0, period_AUTO=NUM_PERIOD
end
//----------------------------------------------------------------------------------------


//-------------------------- number for counter -----------------------------------------------------------------------------------  
// FIX: нужен ли этот блок как общий, или он должен быть только при условии что 
//      работает автоматический режим
always @(posedge clk)
begin
  if(d_v)
    begin
      number <= period_AUTO;  // assign value to number
    end
end  
//-------------------------------------------------------------------------------------------------------------------------------
     
  
//--------------------	импульсы -----------------------------------------------------------------------------------------
// счетчик 
always @(posedge clk)
begin
  begin
  if (rst || !cnt_en)
    begin
      drv_count<=0;
      pulse_width <= 0;
    end
  else if (drv_count<=number+1)
	          begin
                  drv_count <= drv_count+1;    
                  pulse_width <= 1;       
	          end 
          else 
	          begin
		          drv_count <= 0;
              pulse_width <= 0; 
		        end 

//  формирование импульсов и их длительности 
  else if (drv_count>0 && drv_count<=(number+1) >> 2)	// form lasting of pulse
		      begin
		        step <= 1;
	        end
	      else 
		      begin
		        step <= 0;
		      end

// формирование N импульсов
if (start_N && pulse_width)
    begin  
      if(count_N <= N && count_N > 0)
        begin
          count_N <= count_N -1;
        end
      else
        begin
         count_N <= 0;
        end 
    end   
else if (count_N > 0 && count_N <= N >> 2)	// form lasting of pulse
		      begin
		        step_N <= 1;
	        end
	      else 
		      begin
		        step_N <= 0;
		      end


end            
//---------------------------------------------------------------------------------------------------  

always @(*)
begin
  drv_step = start_N ? step_N : step; // если start_N=1, drv_step=step_N 
                                       // если start_N=0, drv_step=step
end

//---------------------------- выходной сигнал  ---------------------------------------------------
assign
 drv_pulse <= drv_step^control_reg[5]; // юит определяет прямой сигнал или инвертированный 


endmodule
