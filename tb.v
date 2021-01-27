`timescale 10ns/10ns
module test();
  
reg             clk_50MHz;                 // clk                         //output in TR and TR_pulse
reg             data_valid;                // write data from ADC         //output in TR 
reg             tr_mode_enable;            // signal of permit            //output in TR
reg             rst;                       // reset                       //output in TR and TR_pulse

reg             data_valid_trig;                                          //output in TR_pulse
reg             [36:0]x;                   // data from ADC

wire            abc;                       // wire for connection TR and TR_pulse - drv_enable_SM
wire          	 [16:0]period;              // wire for connection TR and TR_pulse - N

integer         x0=1000;
parameter       F=87500;                    // limit for x
integer         dx1=10;
integer         dx2=10000;                  // limits for dx                // value is set
integer         F1=16;
integer         F2=166;                   // MIN and MAX for frequency    // value is set

integer         k;                         // factor of incline            // value is set


//--------------------------- find k --------------------------------------------------------------------------
initial
begin
  k=(F2-F1)/(dx2-dx1);
  $display("k=%d",k);
   
  //F0=((F1*dx2)-(F2*dx1))/(dx2-dx1);
 // $display("F0=%d",F0);
 
end
//---------------------------------------------------------------------------------------------------------------


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
  #300 rst=0;
end
//---------------------------------------------------------------------------------------------------------------


//------------------------------ TR_MODE_ENABLE -------------------------------------------------------------------------
initial
begin
  tr_mode_enable =0;
  #300 tr_mode_enable=1;
  #500 tr_mode_enable=0;
  #200 tr_mode_enable=1;
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


//------------------------------ DATA_VALID_TRIG ----------------------------------------------------------------------
initial
begin
  data_valid_trig=1;
 forever
  begin
    data_valid_trig=1;
    @(posedge clk_50MHz);
      data_valid_trig=0;
    repeat(4)
    @(posedge clk_50MHz);    
  end
end
//---------------------------------------------------------------------------------------------------------------------


//----------------------------------- X --------------------------------------------------------------------------------
always @(posedge data_valid)
begin
        if (tr_mode_enable==0)
          begin
            x=100000;
          end 
   
        else 
          begin
            if (x>0)
   	           begin 
                    x=x-1;
               end
 	          else 
                begin 
                  while(x<F)
                    x=x+1;
                end
            end
    end
 //end   
   
//--------------------------------------------------------------------------------------------------------------------------


//------------------------------------------- DELAY -----------------------------------------------------------------------
task delay;
input integer T;
repeat (T)
@(posedge clk_50MHz);
endtask
//----------------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------------
TR TR_test
(
  .clk                (clk_50MHz),
  .data_valid         (data_valid), 
  .tr_mode_enable     (tr_mode_enable), 
  .rst                (rst), 
  .x                  (x), 
  .x0                 (x0),
  .dx1                (dx1), 
  .dx2                (dx2),  
  .drv_step           (drv_step), 
  .drv_dir            (drv_dir),  
  .drv_enable_SM      (abc),
  .N      	           (period),
  .k      	           (k),
  .F2                 (F2),
  .F1                 (F1)
);
//----------------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------------
TR_pulse TR_pulse_test 
(
  .clk                (clk_50MHz), 
  .rst                (rst), 
  .data_valid_trig    (data_valid_trig), 
  .drv_step           (drv_step),
  .in_drv_enable_SM   (abc),
  .N     	            (period)
);
//----------------------------------------------------------------------------------------------------------------------------

endmodule
