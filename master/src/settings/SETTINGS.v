module SETTINGS
#(
    parameter WIDTH_SET = 16, 
    parameter N = 16,         // от фонаря два параметра 
    parameter M = 256         //
)
(
    output reg [2*WIDTH_SET-1:0]    x_set,
                                    i_set,
                                    fi_set,
                                    
    input                           clk,
                                    rst,
                                         
    input wire [15:0]               address,        // ширина может быть 1-64
    input wire [31:0]               writedata,
    output reg [31:0]               readdata,
    input wire                      write,
    input wire                      read,

  // ------------ для памяти -------------------------------------------------------
    //output reg [7:0] data_out,       вроде readdata
    // input write_enable,             вроде как это сигнал  write 
    // input [7:0] address,
    // input [7:0] data_in             вроде это  writedata
    //--------------------------------------------------------------------  
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

          set_reg[1] <= 1'b0; // tr
          set_reg[2] <= 1'b0; // tx
          set_reg[3] <= 1'b0; // tp
          
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
                16'h0: readdata <= set_reg;
                16'h1: readdata <= x_point;
                16'h2: readdata <= i_point;
                16'h3: readdata <= fi_point;
             default:
                readdata <= 32'b0;
              endcase
            end
        end
    end   

always @(*)
    begin
      point_comm       = set_reg[0];

      tr               = set_reg[1];
      tx               = set_reg[2];
      tp               = set_reg[3];
    end


//----------------------------------- запись в память ----------------------------
// это не точно 
// см в шапке модуля 
// в этом блоке  memory = x_table
reg [N:0] x_table[0:M];            
always @(posedge clk) 
  begin
    if (write) 
      begin
        if (tr)
              begin
                x_table[address] <= writedata;
              end
              readdata <= x_table[address];
      end  
  end 



reg [N:0] i_table[0:M];              // tx
always @(posedge clk) 
  begin
    if (write) 
      begin
        if (tx)
          begin
            i_table[address] <= writedata;
          end
          readdata <= i_table[address];
      end    
  end


reg [N:0] fi_table[0:M];              // tp
always @(posedge clk) 
  begin
    if (write) 
      begin
        if (tp)
          begin
            fi_table[address] <= writedata;
          end
          readdata <= fi_table[address];
      end
  end
//----------------------------------------------------------------------------------

always @(*)
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

