module divider (led, clkout, out, rst, start_N, cnt_en, button, enable, clk, sw_0, sw_1);

parameter width=12;	// разрядность счетчика
parameter k=500;		// коэффицент делителя 
parameter d=50; 		// коэффицент для формирования длительности импульса t=0.1T

input  clk, rst, start_N;
input wire sw_0;
input wire sw_1;

wire key0=~sw_0;
wire key1=~sw_1;

output wire clkout;
output reg [width-5:0]led;
output reg [1:0]enable;
//output reg [width-1:0] count;
output reg out, button;

assign clkout=clk;

reg [1:0]state=0;	
//localparam [1:0] IDLE=1;		
//localparam [1:0] LED_ON=2;		
//localparam [1:0] LED_OFF=3;	

/*always @(posedge clk)

begin
// --- счетчик делителя частоты до 100 КГц -----------------------------------------------------------------
	if (enable==1)
	begin
	if (count<=k)		
		begin
		count<=count+1;
		end
	else 
		begin
		count<=0;
		end	
	end
	else begin
			count<=0;
			end
//-------------------------------------------------------------------------------------------------------

		
// --- счетчик формирования импульсов длительностью 10 КГц -----------------------------------------------
	if (count<=k-d)	
		begin
		out<=0;
		end
	else 
		begin
		out<=1;
		end
//--------------------------------------------------------------------------------------------------------

		
// --- работа кнопок -------------------------------------------------------------------------------------		
	if( key1==1)
		begin
		led<=0;
		button<=0;
		end 
	else if(key0==1)
		begin
		led<=1;
		button<=1;
		end
//--------------------------------------------------------------------------------------------------------
	

case(state)		// выбор сстояний 
//----------------------------------------------------------------------------------------------------------
	1:
	begin
		if (key0==1) 
		begin 
		state<=2;	// переход в состояние 2
		enable<=1;
		end
	end
//------------------------------------------------------------------------------------------------------------	
	2:
	begin
		if (key1==1) 
		begin
		state<=3;	// переход в состояние 3
		enable<=1;
		end
	end
//-----------------------------------------------------------------------------------------------------------------
	 3: 
	 begin
		if(out==0) 
			begin
			state<=1;	// возвращение в состояние 1
			enable<=0;
			end
	 end
//-------------------------------------------------------------------------------------------------------------					
default 
state<=1;
endcase
end
*/
//----------------------------------------------------------------------------------------------------------------

parameter N      = 10;  
parameter number = 2000;

reg [31:0]             // count_N,       // ??????? ??? ?????????????? ????????? 
                        drv_count;     // ??????? ????? 
reg [31:0]                        count;
                        
input cnt_en;

reg pulse_width;
reg    step;
reg    step_N;                         
// ??????? 
always @(posedge clk)
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
	      

//  ???????????? ????????? ? ?? ???????????? 
 if (drv_count>0 && drv_count<=(number+1) >> 2)	// form lasting of pulse
		      begin
		        step <= 1;
	        end
	      else 
		      begin
		        step <= 0;
		      end

// ???????????? N ?????????
if(rst || !start_N)
  begin
   count <= 0;
  end   
else 
    begin  
      if(count <= number && count > 0)
        begin
          count <= count - 1;
        end
      else
        begin
         count <= number;
        end 
    end   
 
if (!pulse_width || count > 0 && count<= (number-N) >> 2)	// form lasting of pulse
		      begin
		        step_N <= 1;
	        end
	      else 
		      begin
		        step_N <= 0;
		      end
end            
//------------------------------------------------------------------------------------------------------------------
endmodule
