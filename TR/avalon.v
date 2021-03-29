module avalon
(
	input  wire        clk,              
    input  wire        rst,              

	input  wire [31:0]  avs_s0_address,   
	input  wire [7:0]  avs_s0_writedata, 

	output reg [7:0]   avs_s0_readdata,  

	input  wire        avs_s0_write,     
	input  wire        avs_s0_read,     

     output reg      q,

     output reg      start_comm,
                     stop_comm,
                     start_N_comm,
                     pulse_invert_comm 
	           
);
reg [31:0]           control_reg;

reg                  write_addr_err;

reg                  start,
                     stop,
                     start_N,
                     pulse_invert; 

/*assign               start = control_reg[0],
                     stop = control_reg[1], 
                     start_N = control_reg[2],
                     pulse_invert  = control_reg[3];
*/


always @(posedge clk)
    begin
    if (rst)
        begin
          write_addr_err <= 1'b0;
        end
    else
        if (avs_s0_write)
            begin
               case (avs_s0_address)
                    2'h0: control_reg <= avs_s0_writedata;
                default:
                    write_addr_err <= 1'b1;
               endcase 
            end

    else
          if (avs_s0_read)
            begin
			   case (avs_s0_address)
                    2'h0: avs_s0_readdata <= control_reg; 
                default:
                    avs_s0_readdata <= 32'b0;
               endcase
            end
           
    end


always @(posedge clk)
begin
    q <= 1'b0;
    if (avs_s0_write)
    begin
        q <= 1'b1;
     end   
end


always @(posedge q)
begin
   
start          = control_reg[0];
stop           = control_reg[1]; 
start_N        = control_reg[2];
pulse_invert   = control_reg[3];

  /* if (start == 1'b1) begin
        start_comm <= 1'b1;
     end
   else begin
        start_comm <= 1'b0; 
        end

   if (stop == 1'b1) begin
        stop_comm <= 1'b1; 
     end
   else begin
        stop_comm <= 1'b0; 
        end


   if (start_N == 1'b1) begin
        start_N_comm <= 1'b1; 
        end
   else begin
        start_N_comm <= 1'b0; 
        end


   if (pulse_invert == 1'b1) begin
        pulse_invert_comm <= 1'b1; 
        end
   else begin
        pulse_invert_comm <= 1'b0;   
        end   
*/

end


endmodule
