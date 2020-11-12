module TR
#(
parameter       WIDTH_IN=12,              // x,x0,dx
parameter       WIDTH_WORK=16,            // dx1,dx2,v1,v2,v,N,count 
parameter       DEADZONE=9,               // stepmotor does not react, dx in DEAD ZONE
parameter       CONST=0                   // dx->0 = dx->const
//parameter       K=10                   // for getting 50 KHz 
)
(
input wire      clk,                      // 50 MHz
input wire      data_valid,               // from ADC reading data
input wire      tr_mode_enable,           // enable signal, outsignal
input wire      rst,                      // reset

input           [WIDTH_IN-1:0]x,          // ADC
input           [WIDTH_IN-1:0]x0,         // TABLE
input           [WIDTH_WORK-13:0]dx1,     // posinion1=10
input           [WIDTH_WORK-10:0]dx2,     // position2=100 
    
output reg      drv_step=0,pulse,                // pulse for SM
output reg      drv_dir=0,                 // direction 
output reg      drv_enable_SM              // inner signal, enable work SM
);

reg             [WIDTH_IN-1:0]dx;          // dx=x-x0
reg             [WIDTH_WORK:0]N_async;     // amount of pulse
reg             [WIDTH_WORK:0]count=0;     // counter of pulse 
reg 	           [WIDTH_WORK:0]N,v; 			       // after d-trigger (write or not data)
reg             [1:0]c;                    // number sign
reg             [10:0]K;

reg             [1:0]state=0;              // read data from ADC
localparam      [1:0]STARTING=0;           // state 1 - on/off
localparam      [1:0]TO_ZERO=1;            // state 2 - dx->0
localparam      [1:0]LEAVING_DZ=2;         // state 3 - dx in deadzone


//-------------------------- ON/OFF WORK ------------------------------------------------------------------------------------
always@(posedge clk)
begin
case(state)
  
  STARTING:                              // state 1 - on/off
  begin
    if(tr_mode_enable==1)
      begin
        state<=TO_ZERO;     	           
        drv_enable_SM <= 1;
      end 
    else begin
      state<=STARTING;
    end
  end 
  
  TO_ZERO:                               // state 2 - dx->0
  begin
     if (tr_mode_enable==0)
          begin
            state<=STARTING;            
          end       
     else if(dx==0)
          begin
            state<=LEAVING_DZ;               
            drv_enable_SM <= 0;
          end 
   end
  
   LEAVING_DZ:                           // state 3 - dx=0 deadzone
   begin
      if (tr_mode_enable==0)
          begin
            state<=STARTING;            
          end   
     else if (dx>=DEADZONE)
          begin
            state<=TO_ZERO;             
            drv_enable_SM <= 1;
          end 
   end    

default
  state<=STARTING;                       
endcase     
end
//-----------------------------------------------------------------------------------------------------------------------------


//------------------------------	number sign ---------------------------------------------------------------------------------
	always @(*)
	begin
	  if (x<=x0)
	    begin
	      dx=x0-x;
	      c=0;
	      end
	   else 
	   begin
	     dx=x-x0;
	     c=1;
	   end   
	  end
//------------------------------------------------------------------------------------------------------------------------------	


//------------------ determination of direction ------------------------------------------------------------	

always@(posedge clk)                        // check direction 
	    begin 

	      if (c==0)
	        begin
	          
		          drv_dir<=1;
	         end
	     else
	         begin 
		          drv_dir<=0; 
	     	   end
  end 
//-------------------------------------------------------------------------------------------------------------------------------

//------------ finding N-async (number of pulse)----------------------------------------------------------------------------------------------
always@(*)                 
begin 
		if (dx>=dx2)                           // check position of dx
		begin                                  // dx>=100
				N_async=800;
				v=60;
			end
			
		else if( (dx1<=dx) && (dx<dx2))
			begin                                // 10<=dx<100 
				N_async=39600;                     // ((80000-800)/2)
				v=27;
			end
			
	 else if ((0<dx) && (dx<dx1))
			begin                                // 0<dx<10
				N_async=80000;
				v=6;
			end				
end
	
	  //--------------------------- d-trigger ---------------------------------------------------------------------------------------
always@(posedge data_valid or posedge rst) //cheak a condition
begin
	if(rst)
		begin
			N<=0; 		                               // not write data
		end
	else if (data_valid==1)
		begin
			N<=N_async;	                           // write data
		end
end
//-----------------------------------------------------------------------------------------------------------------------------	


//--------------------	counter of pulse -----------------------------------------------------------------------------------------
always@(posedge clk)
begin
  if (drv_enable_SM && !rst)                            // if it's true, make drv_step
    begin
      	if (count<=N_async)
	       begin
	         //count<=count+1;
		        drv_step<=drv_step+1;
		       
	       end 
      else 
	       begin
		        //count<=0;
		        drv_step<=0;
		     end
	  end
	else 
	  begin 
	     drv_step<=0;
	  end
end

always@(posedge clk)
begin
  if (N==800)
    begin
      K=10;
    end
  else if (N==39600)
    begin
      K=100;
    end  
  else if (N==800000)
    begin
      K=1000;
    end    
end 


//------------------------------------------------------------------------------------------------------------------------------	 

endmodule