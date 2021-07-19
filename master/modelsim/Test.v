`timescale 10ns/10ns  // Модуль для отладки в modelsim
module Test();
 
reg         clk_50MHz,
            rst,
             
            data_valid_TR,
            data_valid_TX,
            data_valid_TP,
        	    
        	  tr_mode,
        	  tx_mode, 
        	  tp_mode; 
        	    
        	    
integer     //L = 16, 
            //F1 = 6000,
        	  //F2 = 50000,
            L, F1, F2,
             
            x_set = 35,
            //dx1 = 150,
        	  //dx2 = 400,
        	  //DZ_TR  = 170,
            dx1, dx2, DZ_TR,
        	    
            i_set = 50,
        	  //d_i_gate2 = 95,
            //DZ_TX = 25,
            d_i_gate2, DZ_TX,
             
        	  fi_set = 70,
        	  //d_fi_gate2 =165,
        	  //DZ_TP = 85,
            d_fi_gate2, DZ_TP,
        	  detuning = 70;

/*wire [31:0]  L_conn,
             F1_conn,
             F2_conn;   	    
*/
        	    
//--------------------------------- CLK -------------------------------------------------------------------------
initial
begin
  clk_50MHz = 0;
  forever
  clk_50MHz = #10!clk_50MHz;
end
//--------------------------------------------------------------------------------------------------------------

//----------------------- RST -----------------------------------------------------------------------------------
initial
begin
  rst =0;
  #5100 rst=1;
  #3000 rst=0;
end
//---------------------------------------------------------------------------------------------------------------

//------------------------------ DATA_VALID_TR ----------------------------------------------------------------------
initial
begin
  data_valid_TR=0;
 forever
  begin
      data_valid_TR=0;
    repeat(4)
    @(posedge clk_50MHz);
      data_valid_TR=1;
    @(posedge clk_50MHz);
  end
end
//---------------------------------------------------------------------------------------------------------------

//------------------------------ DATA_VALID_TX ----------------------------------------------------------------------
initial
begin
  data_valid_TX=0;
 forever
  begin
      data_valid_TX=0;
    repeat(4)
    @(posedge clk_50MHz);
      data_valid_TX=1;
    @(posedge clk_50MHz);
  end
end
//---------------------------------------------------------------------------------------------------------------

//------------------------------ DATA_VALID_TP ----------------------------------------------------------------------
initial
begin
  data_valid_TP=0;
 forever
  begin
      data_valid_TP=0;
    repeat(4)
    @(posedge clk_50MHz);
      data_valid_TP=1;
    @(posedge clk_50MHz);
  end
end
//---------------------------------------------------------------------------------------------------------------


//------------------------------------------- DELAY ------------------------------------------------------------
task delay;
input integer T;
repeat (T)
@(posedge clk_50MHz);
endtask
//-------------------------------------------------------------------------------------------------------------


//-------------------------- tr_mode ------------------------------------------------------------------------------------
initial
begin
  tr_mode = 0;
  #30000 tr_mode = 1;
  #50000 tr_mode = 0;
  #20000 tr_mode = 1;
end
//---------------------------- k_TR --------
integer k_TR;
initial
begin
  k_TR=((F2 - F1)/(dx2 - dx1)) * L;
  $display("k_TR = %d", k_TR);
end  
//----------------------------------------------------------------------------------------------------------------------- 


//--------------------------- tx_mode ------------------------------------------------------------------------------------
initial
begin
  tx_mode = 0;
  #17000 tx_mode = 1;
  #50000 tx_mode = 0;
  #20000 tx_mode = 1;
end
//---------------------------- k_TX --------
integer k_TX;
initial
begin
  k_TX=((F2 - F1)/(d_i_gate2 - DZ_TX)) * L;
  $display("k_TX = %d", k_TX);
end  
//-------------------------------------------------------------------------------------------------------------------------


//--------------------------- tp_mode ---------------------------------------------------------------------------------------
initial
begin
  tp_mode = 0;
  #22000 tp_mode = 1;
  #50000 tp_mode = 0;
  #20000 tp_mode = 1;
end
//---------------------------- k_TP -----------
integer k_TP;
initial
begin
  k_TP=((F2 - F1)/(d_fi_gate2 - DZ_TP)) * L;
  $display("k_TP = %d", k_TP);
end        	    
//--------------------------------------------------------------------------------------------------------------------------


//----------------------------------- X --------------------------------------------------------------------------------
parameter    F=450;
reg [15:0]   x;
always @(posedge data_valid_TR)
begin
        if (tr_mode == 0)
          begin
            x = 500;
          end 
   
        else 
          begin
            if (x > 0)
   	           begin 
                    x = x - 1;
               end
 	          else 
                begin 
                  while(x < F)
                    x = x + 1;
                end
            end
    end
//--------------------------------------------------------------------------------------------------------------------------


//----------------------------------- i_fid --------------------------------------------------------------------------------
reg syncpulse;

initial
begin
  syncpulse =0;
  #7100 syncpulse=1;
  #3000 syncpulse=0;
end

reg [31:0]   i_fid;
always @(posedge clk_50MHz)
begin
  if(syncpulse || tx_mode == 1)
    begin  
      if (i_fid <= 7000)
        begin
          i_fid <= i_fid + 1; 
        end  
      else
        begin
          i_fid <=i_fid;
        end  
    end
  else
    begin
     i_fid <= 10; 
    end
end      
//--------------------------------------------------------------------------------------------------------------------------


//----------------------------------- fi_phm --------------------------------------------------------------------------------
reg [31:0]   fi_phm;
always @(posedge clk_50MHz)
begin
        if (tp_mode == 0)
          begin
            fi_phm = 180;
          end 
   
        else 
          begin
            if (fi_phm > 0)
   	           begin 
                    fi_phm = fi_phm - 1;
               end
 	          else 
                begin 
                    fi_phm = 0;
                end
            end
    end
//--------------------------------------------------------------------------------------------------------------------------

TR_AUTO TR_AUTO_Test
(
  .clk                (clk_50MHz),
  .data_valid_TR      (data_valid_TR), 
  .tr_mode            (tr_mode), 
  .rst                (rst),
  
  .x                  (x), 
  .x_set              (x_set),
  .dx1                (dx1), 
  .dx2                (dx2),
  .DZ_TR              (DZ_TR),

  .L                  (L),
  .F2                 (F2),
  .F1                 (F1),
  .k_TR               (k_TR)
);

TX TX_Test
(
  .clk                (clk_50MHz), 
  .data_valid_TX      (data_valid_TX),
  .tx_mode            (tx_mode), 
  .rst                (rst), 

  .i_fid              (i_fid),          
  .i_set              (i_set),           
  //.i_fid_TX           (i_fid_TX),
  .syncpulse          (syncpulse),
  .DZ_TX              (DZ_TX),
  .d_i_gate2          (d_i_gate2),
  
  .L                  (L),
  .F2                 (F2),
  .F1                 (F1),
  .k_TX               (k_TX) 
);

TP TP_Test
(
  .clk                (clk_50MHz), 
  .tp_mode            (tp_mode), 
  .data_valid_TP      (data_valid_TP),
  .rst                (rst), 
  
  .fi_phm             (fi_phm),
  .fi_set             (fi_set),
  .detuning           (detuning),
  .DZ_TP              (DZ_TP),
  .d_fi_gate2         (d_fi_gate2),
  
  .L                  (L),
  .F2                 (F2),
  .F1                 (F1),
  .k_TP               (k_TP)   
);

/*TR TR_Test
(
  .clk                (clk_50MHz),
  .data_valid         (data_valid), 
  .tr_mode            (tr_mode), 
  .rst                (rst), 

  .x                  (x), 
  .x_set              (x_set),
  .dx1                (dx1), 
  .dx2                (dx2),
  .DZ_TR              (DZ_TR),
  .L                  (L_conn),
  .F2                 (F2),
  .F1                 (F1),
  .k_TR               (k_TR) 
);


PULSE PULSE_test
(
  .clk                (clk_50MHz),  
  .rst                (rst), 
  .drv_pulse          (drv_pulse)
);
*/

endmodule
