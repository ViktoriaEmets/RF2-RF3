module TR_P 
  #(
    parameter SIZE       = 16,
    parameter N          = 5,  // nmber of pulse in hand mode
    parameter NUM_PERIOD = 2000 //  ??? ??????? 25 ???
  )
  (
    input               clk,                 
    input               rst,
                      
    input               drv_en_SM,     // work SM, ?????????? ?????? ?? ???????
    input [SIZE-1:0]    n,  
    
    input               start_N, 
                        start,
                        stop,
                        avto,
                             
    output reg          step                          
  );
reg [SIZE-1:0]          period_AUTO,   // ??????? ??? ?????? ??????? ??? ????/??? ???????
                        count_N,       // ??????? ??? ?????????????? ????????? 
                        drv_count;     // ??????? ?????                   

reg                     pulse_enable; // ?????????? ?????? ?? ?????????? (?? ???????? start/stop) 
                         
reg                     counter_en;


reg starting;
always @(*) 
begin
  if (rst)
        starting <=0;
  else 
    begin
      if (start)
        starting <=1;

      if (stop)
        starting <=0;
    end
end  

reg Ning;
always @(*) 
begin
  if (rst)
        Ning <=0;
  else 
    begin
      if (start_N)
        Ning <=1;

      if (stop)
        Ning <=0;
    end
end  
           
reg [3:0]               State=0;
reg [3:0]               NextState=0;

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

 // ?? ????????? ????????? ??????? ????????? 
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
          if (starting)
            begin
              NextState = MOVE;
            end
          else
            begin
              NextState = IDLE;
            end  
        end

      MOVE_N:
        begin
          if (Ning)  // if (count_N == N) {count_done==1}
            begin
              NextState = MOVE_N;
            end
          else if (count_N == N || stop)
            begin
              NextState = IDLE;
            end  
            
        end  
  
      default:
        NextState = IDLE;
    endcase 
end

always @(*)
begin
    if(rst)
      begin
        pulse_enable = 0;
      end
    else
      begin
        
        case(NextState)
         
          IDLE: 
            begin    
              pulse_enable = 1'b0;
              counter_en   = 1'b0;
            end

          AUTO: 
            begin  
              pulse_enable = drv_en_SM;
              period_AUTO  = n;
              counter_en   = 1'b0;
            end  

          MOVE: 
            begin   
              pulse_enable = 1'b1; // ?????????? ?????? ?? 
              counter_en   = 1'b0; // ?????????? ?????? ???????? count_N
              period_AUTO  = NUM_PERIOD;
            end  

          MOVE_N: 
            begin    
              pulse_enable = 1'b1; // ?????????? ?????? ?? 
              counter_en   = 1'b1; // ?????????? ?????? ???????? count_N
              period_AUTO  = NUM_PERIOD;
            end 

        endcase     
      end       
end

// ??????? 
always @(posedge clk)
begin
  if (rst || pulse_enable == 0)
    begin
      drv_count<=0;
    end
  else if (drv_count<= period_AUTO +1)
	          begin
              drv_count <= drv_count+1;        
	          end 
          else 
	          begin
		          drv_count <= 0;
		        end 

//  ???????????? ????????? ? ?? ???????????? 
 if (drv_count>0 && drv_count<=(period_AUTO +  1) >> 2)	
		      begin
		        step <= 1;
	        end
	      else 
		      begin
		        step <= 0;
		      end

// ???????????? N ?????????
  if (counter_en)
    begin  
      if(count_N <= N - 1)
        begin
          count_N <= count_N + 1;
        end
      else
        begin
         count_N <= 0;
        end 
    end   

end 
      
endmodule 
