`timescale 10ns/10ns
module test();
  
reg             clk_50MHz;                  // clk
reg             data_valid;                 // write data from ADC
reg             tr_mode_enable;             // signal of permit
reg             rst;                        // reset

reg             data_valid_trig;
reg             [11:0]x;                    // data from ADC

wire            abc;
wire[16:0]      period;

integer         n;
parameter       DX=1;
parameter       F=150;


wire            dx1;
wire            dx2;

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
            x=50;
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
  .x0                 (10),
  .dx1                (45), 
  .dx2                (60),  
  .drv_step           (drv_step), 
  .drv_dir            (drv_dir),  
  //.led                (led), 
  .drv_enable_SM      (abc),
  .N      	           (period)
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
