`timescale 10ns/10ns
module test1();
reg           clk_50MHz,
              rst,
              counter_en;

reg           avs_s0_writedata,
              avs_s0_write,
              avs_s0_read;    

reg           avs_s0_address = 1'b1111;



reg           start,
              start_N,
              stop,
             
              avto;

wire         stop_conn,
             start_conn,
             start_N_conn;

initial
begin
clk_50MHz=0;
forever
clk_50MHz=#10!clk_50MHz;
end

initial
begin
  rst =0;
  #80000 rst=1;
  #100000 rst=0;
end

initial
begin
  avto=0;
  #100000 avto=1;
  #10 avto=0;
end
/*
initial
begin
  start=0;
  #300000 start=1;
  #10 start=0;
end

initial
begin
  start_N =0;
  #1000000 start_N=1;
  #10 start_N=0;
end

initial
begin
  stop=0;
  #900000 stop=1;
  #10 stop=0;
  #900000 stop=1;
  #10 stop=0;
end
*/

initial
begin
  avs_s0_write =0;
  #600000 avs_s0_write=1;
  #50000 avs_s0_write=0;
end


initial
begin
  avs_s0_read =0;
  #900000 avs_s0_read=1;
  #50000 avs_s0_read=0;
end

TR_P TR_P_test1
(
  .clk                (clk_50MHz), 
  .rst                (rst), 

  .stop               (stop_conn),
  .start              (start_conn),
  .start_N            (start_N_conn),
  
  .avto               (avto)
);

//-------------------------------------------------------------------------------------------------
avalon avalon_test
(
  .clk                (clk_50MHz), 
  .rst                (rst),

  .avs_s0_writedata   (avs_s0_writedata),
  .avs_s0_address     (avs_s0_address),
  .avs_s0_write       (avs_s0_write),
  .avs_s0_read        (avs_s0_read),

  .avs_s0_readdata    (avs_s0_readdata),

  .stop               (stop_conn),
  .start              (start_conn),
  .start_N            (start_N_conn)
 
);
endmodule
