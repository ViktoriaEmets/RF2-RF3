`timescale 10ns/10ns
module test1();
reg           clk_50MHz,
              rst,
              counter_en;

reg           start,
              start_N,
              stop,
              avto;

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

TR_P TR_P_test1(
.clk      (clk_50MHz), 
.rst      (rst), 
.start_N  (start_N), 
.start    (start),
.stop     (stop),
.avto     (avto)
);
endmodule

