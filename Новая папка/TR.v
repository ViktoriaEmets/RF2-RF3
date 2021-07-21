module TR
#(
parameter  WIDTH_IN        = 12,   // x,x0,dx
parameter  WIDTH_WORK      = 16,   // dx1,dx2,v1,v2,v,N,count 
parameter  WIDTH_PULSE     = 32,   // for N_async

parameter  DEADZONE        = 50,   // stepmotor does not react, dx in DEAD ZONE

parameter  L               = 16
)

(
output reg [WIDTH_WORK-1:0]    period_AUTO, 			  // after d-trigger (write or not data)  

output reg                     dir_AUTO,       // dir_AUTO 
                       		   drv_en_SM,  // inner signal, enable work SM	

//----------- input control signals ------------------------------------------
input wire          		   clk,            // 50 MHz
                   	 		   data_valid,     // from ADC reading data
                    		   tr_mode_enable, // enable signal, outsignal
                    		   rst,            // reset
//-------------------------------------------------------------------------------
input [WIDTH_IN-1:0]    	   x0,             // TABLE

input [WIDTH_WORK-1:0]  	   x,              // ADC
          					   dx1, 
							   dx2,  
          					   F1,
							   F2, 					
							   k 			  //[19:0]
);

reg [WIDTH_WORK-1:0]    	   dx;            // dx=x-x0
          					     
reg [WIDTH_PULSE+3:0]          n_async;       // amount of pulse [35:0]
     
 
reg [1:0]               	   c;                    

reg [1:0]               	   state=0;       // read data from ADC

localparam
	STARTING      = 0,   // state 1 - on/off
	TO_ZERO       = 1,   // state 2 - dx->0
	LEAVING_DZ    = 2;   // state 3 - dx in deadzone


//-------------------------- ON/OFF WORK ------------------------------------------------------------------------------------
always@(posedge clk)
begin
case(state)
  
  STARTING:    // state 1 - on/off
  begin
    if(tr_mode_enable == 1)
      begin
        state <= TO_ZERO;     	           
        drv_en_SM <= 1;
      end 
    else begin
      state <= STARTING;
    end
  end 
  
  TO_ZERO:     // state 2 - dx->0
  begin
     if (tr_mode_enable == 0)
          begin
            state <= STARTING;            
          end       
     else if(dx==0)
          begin
            state <= LEAVING_DZ;               
            drv_en_SM <= 0;
          end 
   end
  
   LEAVING_DZ: // state 3 - dx=0 deadzone
   begin
      if (tr_mode_enable == 0)
          begin
            state <= STARTING;            
          end   
     else if (dx >= DEADZONE)
          begin
            state <= TO_ZERO;             
            drv_en_SM <= 1;
          end 
   end    

default
  state <= STARTING;                       
endcase     
end
//-----------------------------------------------------------------------------------------------------------------------------


//------------------------------	number sign ---------------------------------------------------------------------------------
	always @(*)
	begin
	  if (x <= x0)
	    begin
	      dx = x0 - x;
	      c = 0;
	      end
	   else 
	   begin
	     dx = x - x0;
	     c = 1;
	   end   
	  end
//------------------------------------------------------------------------------------------------------------------------------	          


//------------------ determination ofdir_auto --------------------------------------------------------------------------------	
always@(posedge clk)  // checkdir_auto 
	    begin 
	      if (c == 0)
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
begin     // check position of dx
		if (dx >= dx2)                          
		  begin                                  
				n_async <= F2;
			end
	
		else if( (dx1 <= dx) && (dx < dx2))
			begin                           
				n_async <= ((k * (dx - dx1)) / L) + F1;
			end	
		
	 else if ((DEADZONE < dx) && (dx < dx1))
			begin                                
				n_async <= F1;
			end					
end
//------------------------------------------------------------------------------------------------------------------------------------------


//--------------------------- d-trigger for N (needed period)---------------------------------------------------------------------------------------
always@(posedge data_valid or posedge rst)  //cheak a condition
begin
	if(rst)
		begin
			period_AUTO <= 0; 		                    // not write data
		end	
	else if (data_valid == 1)
		begin
			period_AUTO <= n_async[19:3];	            // write data
		end
end
//-----------------------------------------------------------------------------------------------------------------------------	


endmodule
