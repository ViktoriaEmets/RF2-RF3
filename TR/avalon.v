module avalon
(
	input  wire        clk,              
    input  wire        rst,              

	input  wire [3:0] avs_s0_address,   
	input  wire [7:0] avs_s0_writedata, 

	output reg [7:0] avs_s0_readdata,  

	input  wire        avs_s0_write,     
	input  wire        avs_s0_read,     


     output reg       start,
                      stop,
                      start_N
                      //pulse_invert 
	           
);
reg [31:0]            control_reg;

assign avs_s0_writedata = avs_s0_address;

/*assign
    start           = control_reg[0],
    stop            = control_reg[1], 
    start_N         = control_reg[2],
    pulse_invert    = control_reg[3];
*/
always @(posedge clk)
    begin
      control_reg[0] <= 1'b0;
      control_reg[1] <= 1'b0;
      control_reg[2] <= 1'b0;
     // control_reg[3] <= 1'b0;

        if (avs_s0_write)
            begin
                control_reg <= avs_s0_writedata;
            end

        if (avs_s0_read)
            begin
                avs_s0_readdata <= control_reg;     
            end
    end

always @(posedge clk)
begin
    start           = control_reg[0];
    stop            = control_reg[1]; 
    start_N         = control_reg[2];
    //pulse_invert    = control_reg[3];
 
end

endmodule
