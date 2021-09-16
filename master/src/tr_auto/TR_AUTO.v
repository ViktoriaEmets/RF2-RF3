module TR_AUTO  // Режим выставки тюнеров по датчикам положения 
#(
parameter  WIDTH_IN        			= 12,   		// x, x_set, d_x,
parameter  WIDTH_AUTO      			= 16   			// dx1,dx2,v1,v2,v,N,count 
)
(
output reg                      	enable_AUTO,   // разрешение работы ШД, в TR
									dir_AUTO,	   // направление вращения ШД, в TR 

output reg [2*WIDTH_AUTO-1:0]  		period_AUTO,   // период импульсов, в TR 

input wire          		   		clk,            // 50 MHz
									rst,            // reset
                   	 		   		data_valid_TR,  // стробирующий сигнал
                    		   		tr_mode, 		// enable signal, outsignal
 
input [WIDTH_IN-1:0]    			x_set,          // TABLE
input [2*WIDTH_AUTO-1:0]  			x,              // ADC
          					   		dx1, 
							   		dx2,  
          					   		F1,
							   		F2,
									L,
									DZ_TR, 

input [WIDTH_AUTO+3:0]		   	    k_TR 			// коэфициент наклона изменения скорости						   
);

reg [WIDTH_AUTO-1:0]    	 		d_x;           // d_x=x-x_set									
reg 		               	   		sign_TR;       // переменная для определения направления ШД      

reg [3:0]			               	state_auto=0;   

reg [35:0]        					n_async;       // amount of pulse [35:0]

//-------------------------- ON/OFF WORK ------------------------------------------------------------------------------------
localparam
	START_TR      	= 0,   // state_auto 1 - on/off
	TO_ZERO_TR      = 1,   // state_auto 2 - d_x->0
	PASS_DZ_TR    	= 2;   // state_auto 3 - d_x in DZ_TR

always@(posedge clk)
begin
case(state_auto)

  START_TR:    // state_auto 1 - on/off
  begin
    if(tr_mode == 1)
      begin
        state_auto <= TO_ZERO_TR;     	           
        enable_AUTO <= 1;
      end 
    else begin
      state_auto <= START_TR;
    end
  end 

  TO_ZERO_TR:     // state_auto 2 - d_x->0
  begin
     if (tr_mode == 0)
          begin
            state_auto <= START_TR;            
          end       
     else if(d_x==DZ_TR)
          begin
            state_auto <= PASS_DZ_TR;               
            enable_AUTO <= 0;
          end 
   end 

   PASS_DZ_TR: // state_auto 3 - d_x=0 DZ_TR
   begin
      if (tr_mode == 0)
          begin
            state_auto <= START_TR;            
          end   
     else if (d_x >= DZ_TR)
          begin
            state_auto <= TO_ZERO_TR;             
            enable_AUTO <= 1;
          end 
   end  
     
default
  state_auto <= START_TR;                       
endcase     
end
//-----------------------------------------------------------------------------------------------------------------------------

//------------------------------	number sign ---------------------------------------------------------------------------------
	always @(*)
	begin
	  if (x <= x_set)
	    begin
	      d_x = x_set - x;
	      sign_TR = 0;
	      end
	   else 
	   begin
	     d_x = x - x_set;
	     sign_TR = 1;
	   end   
	  end
//------------------------------------------------------------------------------------------------------------------------------	          

//------------------ determination of dir_auto --------------------------------------------------------------------------------	
always@(posedge clk)  // checkdir_auto 
	    begin 
	      if (sign_TR == 0)
	        begin
		     dir_AUTO <= 1;
	         end   
	     else
	         begin 
		     dir_AUTO <= 0; 
	     	   end     	   
  end 
//-------------------------------------------------------------------------------------------------------------------------------

//------------ finding N-async (number of pulse)----------------------------------------------------------------------------------------------
always@(*)                 
begin     // check position of d_x
		if (d_x >= dx2)                          
		  	begin                                  
				n_async <= F2;
			end
	
		else if( (dx1 <= d_x) && (d_x < dx2))
			begin                           
				n_async <= ((k_TR * ( d_x - dx1)) / L) + F1;
			end	
		
	 	else if ((DZ_TR < d_x) && (d_x < dx1))
			begin                                
				n_async <= F1;
			end					
end
//------------------------------------------------------------------------------------------------------------------------------------------

//--------------------------- d-trigger for N (needed period)---------------------------------------------------------------------------------------
always@(posedge data_valid_TR or posedge rst)  //cheak a condition
begin
	if(rst)
		begin
			period_AUTO <= 0; 		                    // not write data
		end	
	else if (data_valid_TR == 1)
		begin
			period_AUTO <= n_async[19:3];	            // write data
		end
end


endmodule
