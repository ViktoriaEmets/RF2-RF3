module SETTINGS
#(
    WIDTH_SET
)
(
    input                           clk,
                                    rst,
                                         
    input wire [15:0]               address,        // ширина может быть 1-64
    input wire [31:0]               writedata,
    output reg [31:0]               readdata,
    input wire                      write,
    input wire                      read  
); 
    reg                             write_addr_err,
                                    point_comm,
                                    start_table;

    reg [WIDTH_SET-1:0]             set_reg;

    reg [2*WIDTH_SET-1:0]           x_point,
                                    i_point,
                                    fi_point,

                                    x_table,
                                    i_table, 
                                    fi_table;
always @(posedge clk)
    begin
      if (rst)
        begin
          write_addr_err <= 1'b0;
          set_reg <= 0;     
        end
      else
        begin
          set_reg[0] <= 1'b0; // 1-point / 0-table         
          set_reg[1] <= 1'b0; // разрешение работы табличного режима
          
          if (write)
            begin
              case (address)
                16'h0:  set_reg     <= writedata;
                16'h1:  x_point     <= writedata;
                16'h2:  i_point     <= writedata;
                16'h3:  fi_point    <= writedata; 
              default:
                write_addr_err  <= 1'b1;
              endcase
            end
      else if (read)
            begin
              case (address)
                16'h0: avs_s0_readdata <= set_reg;
                16'h1: avs_s0_readdata <= x_point;
                16'h2: avs_s0_readdata <= i_point;
                16'h3: avs_s0_readdata <= fi_point;
             default:
                readdata <= 32'b0;
              endcase
            end
        end
    end   

always @(*)
    begin
      point_comm       = set_reg[0];
      start_table      = set_reg[1];
    end



always *()
begin
    if (point_comm)
        begin
            x_set   = x_point;
            i_set   = i_point;
            fi_set  = fi_point;
        end
    else 
        begin
            x_set   = x_table;
            i_set   = i_table;
            fi_set  = fi_table;

        end    
end

endmodule

