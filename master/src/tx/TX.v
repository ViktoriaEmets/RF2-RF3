module TX   // Режим TX, ограничение тока фидера   
#(
    parameter WIDTH_TX       = 16
  )
(
    output reg                          drv_en_TX,      // разрешение работы ШД в режиме TX
                                        dir_TX,         // направление вращения режим TX          
    
    output reg [WIDTH_TX-1:0]           period_TX,      // период режимTX

    input wire                          clk,            // тактовая частота 
                                        rst,            // сброс
                                        data_valid_TX,
                                        tx_mode,        // разрешающий внешний сигнал

    input [WIDTH_TX-1:0]                i_fid,          // ток генератора
                                        i_set,          // ток уставки     
                                        i_fid_TX,       // ограничение по току I_fid = 0.5 * I_fid_TX
                                        F1,             // частота минимальная
                                        F2,             // частолта максимальная 
                                        DZ_TX,          // зона нечувствительности
                                        L,
                                        d_i_gate2,
    input [WIDTH_TX+3:0]                k_TX,
    input                               syncpulse      // синхроимпульс     
);

reg                	                    sign_TX;          // знак ошибки TX 
                                      
reg [3:0]               	              state_TX=0;

reg [35:0]                              n_TX;

reg [WIDTH_TX-1:0]                      d_i;              // ошибка для TX   

//----------------------переход между состояниями ---------------------------------------------------------------------------
localparam
	START_TX            = 0,   
	TO_ZERO_TX          = 1,   
	PASS_DZ_TX          = 2;   

always@(posedge clk)
begin
case(state_TX)

  START_TX:    
  begin
    if(tx_mode == 1)
      begin
        state_TX <= TO_ZERO_TX;     	           
        drv_en_TX <= 1'b1;
      end 
    else begin
      state_TX <= START_TX;
    end
  end 
  
  TO_ZERO_TX:    
  begin
     if (tx_mode == 0)
          begin
            state_TX <= START_TX;            
          end       
     else if(d_i==0)
          begin
            state_TX <= PASS_DZ_TX;               
            drv_en_TX <= 1'b0;
          end 
   end
  
   PASS_DZ_TX: 
   begin
      if (tx_mode == 0)
          begin
            state_TX <= START_TX;            
          end   
     else if (d_i >= DZ_TX)
          begin
            state_TX <= TO_ZERO_TX;             
            drv_en_TX <= 1'b1;
          end 
   end    

default
  state_TX <= START_TX;                       
endcase     
end
//-----------------------------------------------------------------------------------

//---------------------найти разность -----------------------------------------------------------------------
always@*
	begin
    if (i_fid < i_set)
	    begin
	      d_i = i_set - i_fid;
	      sign_TX = 1'b0;
	    end
	  else 
	    begin
	      d_i = i_fid - i_set;
	      sign_TX = 1'b1;
	    end        
	end
//---------------------------------------------------------------------------------------------

//----------направление вращения-----------------------------------------------------------------------
always@(posedge clk)  
	    begin 
	      if (sign_TX == 1'b0)
	        begin
		        dir_TX <= 1'b1;
	        end   
	     else
	        begin 
		        dir_TX <= 1'b0; 
	     	  end 
      end         	   
//--------------------------------------------------------------------------------------------- 

//---------------период изменение -----------------------------------------------------------------------
always @(posedge clk)
    begin
    //if (i_fid >= i_fid_TX)
    //  begin 

        if (d_i >= d_i_gate2)
          begin
            n_TX <= F2;
          end

        else if( (DZ_TX <= d_i) && (d_i < d_i_gate2))
		      begin                           
			      n_TX <= ((k_TX * (d_i - DZ_TX)) / L) + F1;
		      end	
     // end
	 //else 
		//begin                                
	//		n_TX <= 0;
	//	end		
    end
//----------------------------------------------------------------------------------------------
 
//---------------------------------------------------------------------------------
always@(posedge data_valid_TX or posedge rst)  //cheak a condition
begin
	if(rst)
		begin
			period_TX <= 0; 		                    // not write data
		end	
	else if (data_valid_TX == 1)
		begin
			period_TX <= n_TX[19:3];	            // write data
		end
end

  endmodule          
        