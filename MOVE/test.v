`timescale 10ns/10ns
module test();
 
integer      F1=60,  // MIN frequency  6 kHz          // value is set
             F2=500, // MAX frequency  60 kHz          // value is set
             i_fid = 0,
             i_set = 50;

reg          clk_50MHz,   
        	    syncpulse;

initial
begin
  syncpulse =0;
  #30 syncpulse=1;
  #10 syncpulse=0;
end

//--------------------------------- CLK -------------------------------------------------------------------------
initial
begin
  clk_50MHz=0;
  forever
  clk_50MHz=#10!clk_50MHz;
end
//--------------------------------------------------------------------------------------------------------------


always @(posedge clk_50MHz)
begin
i_fid= i_fid +10;
end


TX TX_test
(
  .clk                (clk_50MHz), 
  .syncpulse          (syncpulse),
  .F2                 (F2),
  .F1                 (F1),
  .i_fid              (i_fid),
  .i_set              (i_set)

);

endmodule