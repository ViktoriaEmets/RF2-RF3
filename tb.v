`timescale 10ns/10ns
module test();
  
reg clk_50MHz;                      // clk
reg data_valid;                     // write data from ADC
reg enable;                         // signal of permit
reg rst;                            // reset

reg [11:0]x;                        // data from ADC
reg [9:0]counter;                   // for data_valid
reg N_async;                        // number of pulse


integer n;
parameter DX=1;
parameter       F=14;
parameter       S=10;

//parameter K=1000;                   // for getting 50 KHz 
//parameter D=1;                     // for get 1 takt pulse (50 MHz)  


wire dx1;
wire dx2;
//wire v1;
//wire v2;

//--------------------------------- CLK -------------------------------------------------------------------------
initial
begin
  clk_50MHz=0;
  forever
  clk_50MHz=#10!clk_50MHz;
end
//--------------------------------------------------------------------------------------------------------------


//----------------------- RST (not sure)-----------------------------------------------------------------------------------
initial
begin
  rst =0;
  #510 rst=1;
  #100 rst=0;
end
//---------------------------------------------------------------------------------------------------------------


//------------------------------ ENABLE -------------------------------------------------------------------------
initial
begin
  enable =0;
   //x=25;
  #300 enable=1;
  //for(n=1; n<10; n=n+DX)
    //begin
   // x=x-n; 
   // delay(2);
  #500 enable=0;
  #200 enable=1;
end
//end
//---------------------------------------------------------------------------------------------------------------


//------------------------------ DATA_VALID ----------------------------------------------------------------------
initial
begin
  data_valid=0;
 forever
  begin
      data_valid=0;
    repeat(4)
    @(posedge clk_50MHz);
      data_valid=1;
    @(posedge clk_50MHz);
  end
end
//---------------------------------------------------------------------------------------------------------------------


//----------------------------------- X --------------------------------------------------------------------------------
always @(posedge clk_50MHz)
begin
  if (enable==0)
    begin
      x=25;
    end 
   
else begin
    if (x>0)
      begin 
        x=x-1;
      end
    else 
      begin while(x<F)
        x=x+1;
      end
    end
   end
   
//--------------------------------------------------------------------------------------------------------------------------


//------------------------------------------- DELAY -----------------------------------------------------------------------
task delay;

input integer N;
repeat (N)
@(posedge clk_50MHz);
endtask
//----------------------------------------------------------------------------------------------------------------------------


TR TR_test(.clk (clk_50MHz), .x (x), .x0 (5), .data_valid (data_valid), .enable (enable), .rst (rst),
.drv_SM (drv_SM), .drv_step (drv_step), .drv_dir(drv_dir), .dx1(5), .dx2(10));
endmodule
