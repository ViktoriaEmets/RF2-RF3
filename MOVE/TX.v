module TX

(
    input       clk,
                i_fid,
                i_set,
                syncpulse,
                i_fid_TX,
                F1,
                F2  


                //dir_AUTO;         
);



reg [15:0]      di,               
                sign,
                period;


always@*
	begin
        if (syncpulse)
        begin
	    if (i_fid < i_set)
	        begin
	            di = i_set - i_fid;
	            sign = 0;
	        end
	    else
	        begin
	            di = i_fid - i_set;
	            sign <= 1;
	        end
        end        
	end


// как будет меняться период и должен ли он меняться? 
always @(posedge clk)
    begin
    if (di >  i_set)
        begin
            period <= (F2-F1)/2 ;
        end
    else 
        begin
            period <= 0;
        end
    end    
        
  endmodule          
        