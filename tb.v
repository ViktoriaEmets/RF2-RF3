`timescale 10ns/10ns
module test();
  
reg             clk_50MHz;                 // clk                         //output in TR and TR_pulse
reg             data_valid;                // write data from ADC         //output in TR 
reg             tr_mode_enable;            // signal of permit            //output in TR
reg             rst;                       // reset                       //output in TR and TR_pulse

reg             d_v;                                          //output in TR_pulse
reg             [35:0]x;                   // data from ADC

wire            abc;                       // wire for connection TR and TR_pulse - drv_enable_SM
wire          	 [16:0]period;              // wire for connection TR and TR_pulse - N

integer         x0=5;
parameter       F=20000;                    // limit for x
integer         dx1=250;
integer         dx2=555;                     // limits for dx                 // value is set
integer         F1=6000;                     // MIN frequency  6 kHz          // value is set
integer         F2=50000;                   // MAX frequency  60 kHz          // value is set

integer         k;                         // factor of incline               // value is set
integer         L=16;


//--------------------------- find k --------------------------------------------------------------------------
initial
begin
  k=((F2-F1)/(dx2-dx1))*L;
  $display("k=%d",k);
end

/*integer L=16;
reg [32:0]  K,TX;
initial 
begin
  TX=k*L*dx;
  $display("TX=%d",TX);
  K=(TX/L);
  $display("K=%d",K);
end
*/

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
  #51000 rst=1;
  #30000 rst=0;
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
  d_v=1;
 forever
  begin
    d_v=1;
    @(posedge clk_50MHz);
      d_v=0;
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
            x=30000;
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
  .d_v                (d_v), 
  .drv_step           (drv_step),
  .drv_en_SM          (abc),
  .N     	            (period)
);
//----------------------------------------------------------------------------------------------------------------------------

endmodule
