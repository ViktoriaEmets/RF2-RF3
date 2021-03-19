module avalon
(
	input  wire        clk,              
    input  wire        rst,              

	input  wire [3:0] avs_s0_address,   
	input  wire [3:0] avs_s0_writedata, 

	output reg [3:0] avs_s0_readdata,  

	input  wire        avs_s0_write,     
	input  wire        avs_s0_read      
	           
);
reg [31:0]                      control_reg;
reg                             read_reg;

reg                            start;


/*assign
    start = control_reg[0],
    stop  = control_reg[1]; 
*/
always @(posedge clk)
    begin
    //  control_reg[0] <= 1'b0;
    //  control_reg[1] <= 1'b0;

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
   
end

endmodule
