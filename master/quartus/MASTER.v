module MASTER  // совсем не то написано 
(
	input                           clk,
	output wire			commands_parameters_0_conduit_comm_par_start,
   output wire			commands_parameters_0_conduit_comm_par_stop,
   output wire			commands_parameters_0_conduit_comm_par_start_N,
                
	output wire			commands_parameters_0_conduit_comm_par_avto,
	output wire			commands_parameters_0_conduit_comm_par_drv_pulse,
	output wire			commands_parameters_0_conduit_comm_par_drv_dir
	
);

  
    master u0 (
        .clk_50                                                    (clk_50),                                                    //                               clk_50_clk_in.clk
        .reset_n                                                   (reset_n),                                                   //                         clk_50_clk_in_reset.reset_n
        .pio_led_external_connection_export                        (pio_led_external_connection_export),                        //                 pio_led_external_connection.export
        .commands_parameters_qsys_0_conduit_comm_par_start         (commands_parameters_qsys_0_conduit_comm_par_start),         // commands_parameters_qsys_0_conduit_comm_par.start
        .commands_parameters_qsys_0_conduit_comm_par_start_N       (commands_parameters_qsys_0_conduit_comm_par_start_N),       //                                            .start_N
        .commands_parameters_qsys_0_conduit_comm_par_auto          (commands_parameters_qsys_0_conduit_comm_par_auto),          //                                            .auto
        .commands_parameters_qsys_0_conduit_comm_par_stop          (commands_parameters_qsys_0_conduit_comm_par_stop),          //                                            .stop
        .commands_parameters_qsys_0_conduit_comm_par_fi_phm        (commands_parameters_qsys_0_conduit_comm_par_fi_phm),        //                                            .fi_phm
        .commands_parameters_qsys_0_conduit_comm_par_detuning      (commands_parameters_qsys_0_conduit_comm_par_detuning),      //                                            .detuning
        .commands_parameters_qsys_0_conduit_comm_par_syncpulse     (commands_parameters_qsys_0_conduit_comm_par_syncpulse),     //                                            .syncpulse
        .commands_parameters_qsys_0_conduit_comm_par_TURN_ON_RF    (commands_parameters_qsys_0_conduit_comm_par_TURN_ON_RF),    //                                            .TURN_ON_RF
        .commands_parameters_qsys_0_conduit_comm_par_d_fi_gate2    (commands_parameters_qsys_0_conduit_comm_par_d_fi_gate2),    //                                            .d_fi_gate2
        .commands_parameters_qsys_0_conduit_comm_par_d_i_gate2     (commands_parameters_qsys_0_conduit_comm_par_d_i_gate2),     //                                            .d_i_gate2
        .commands_parameters_qsys_0_conduit_comm_par_dx2           (commands_parameters_qsys_0_conduit_comm_par_dx2),           //                                            .dx2
        .commands_parameters_qsys_0_conduit_comm_par_dx1           (commands_parameters_qsys_0_conduit_comm_par_dx1),           //                                            .dx1
        .commands_parameters_qsys_0_conduit_comm_par_DZ_TP         (commands_parameters_qsys_0_conduit_comm_par_DZ_TP),         //                                            .DZ_TP
        .commands_parameters_qsys_0_conduit_comm_par_DZ_TX         (commands_parameters_qsys_0_conduit_comm_par_DZ_TX),         //                                            .DZ_TX
        .commands_parameters_qsys_0_conduit_comm_par_PULSE_NUMBER  (commands_parameters_qsys_0_conduit_comm_par_PULSE_NUMBER),  //                                            .PULSE_NUMBER
        .commands_parameters_qsys_0_conduit_comm_par_DZ_TR         (commands_parameters_qsys_0_conduit_comm_par_DZ_TR),         //                                            .DZ_TR
        .commands_parameters_qsys_0_conduit_comm_par_period_MANUAL (commands_parameters_qsys_0_conduit_comm_par_period_MANUAL), //                                            .period_MANUAL
        .commands_parameters_qsys_0_conduit_comm_par_L             (commands_parameters_qsys_0_conduit_comm_par_L),             //                                            .L
        .commands_parameters_qsys_0_conduit_comm_par_F2            (commands_parameters_qsys_0_conduit_comm_par_F2),            //                                            .F2
        .commands_parameters_qsys_0_conduit_comm_par_F1            (commands_parameters_qsys_0_conduit_comm_par_F1),            //                                            .F1
        .commands_parameters_qsys_0_conduit_comm_par_count_MANUAL  (commands_parameters_qsys_0_conduit_comm_par_count_MANUAL),  //                                            .count_MANUAL
        .commands_parameters_qsys_0_conduit_comm_par_dir_MANUAL    (commands_parameters_qsys_0_conduit_comm_par_dir_MANUAL),    //                                            .dir_MANUAL
        .commands_parameters_qsys_0_conduit_comm_par_tp            (commands_parameters_qsys_0_conduit_comm_par_tp),            //                                            .tp
        .commands_parameters_qsys_0_conduit_comm_par_tx            (commands_parameters_qsys_0_conduit_comm_par_tx),            //                                            .tx
        .commands_parameters_qsys_0_conduit_comm_par_tr            (commands_parameters_qsys_0_conduit_comm_par_tr),            //                                            .tr
        .commands_parameters_qsys_0_s0_address                     (commands_parameters_qsys_0_s0_address),                     //               commands_parameters_qsys_0_s0.address
        .commands_parameters_qsys_0_s0_writedata                   (commands_parameters_qsys_0_s0_writedata),                   //                                            .writedata
        .commands_parameters_qsys_0_s0_readdata                    (commands_parameters_qsys_0_s0_readdata),                    //                                            .readdata
        .commands_parameters_qsys_0_s0_write                       (commands_parameters_qsys_0_s0_write),                       //                                            .write
        .commands_parameters_qsys_0_s0_read                        (commands_parameters_qsys_0_s0_read),                        //                                            .read
        .pulse_qsys_conduit_drv_pulse                              (pulse_qsys_conduit_drv_pulse),                              //                          pulse_qsys_conduit.drv_pulse
        .pulse_qsys_conduit_drv_dir                                (pulse_qsys_conduit_drv_dir),                                //                                            .drv_dir
        .pulse_qsys_conduit_enable                                 (pulse_qsys_conduit_enable),                                 //                                            .enable
        .pulse_qsys_conduit_counter_en                             (pulse_qsys_conduit_counter_en),                             //                                            .counter_en
        .pulse_qsys_conduit_drv_period                             (pulse_qsys_conduit_drv_period),                             //                                            .drv_period
        .pulse_qsys_conduit_PULSE_NUMBER                           (pulse_qsys_conduit_PULSE_NUMBER),                           //                                            .PULSE_NUMBER
        .mux_qsys_conduit_drv_period                               (mux_qsys_conduit_drv_period),                               //                            mux_qsys_conduit.drv_period
        .mux_qsys_conduit_drv_dir                                  (mux_qsys_conduit_drv_dir),                                  //                                            .drv_dir
        .mux_qsys_conduit_enable                                   (mux_qsys_conduit_enable),                                   //                                            .enable
        .mux_qsys_conduit_counter_en                               (mux_qsys_conduit_counter_en),                               //                                            .counter_en
        .mux_qsys_conduit_period_TR                                (mux_qsys_conduit_period_TR),                                //                                            .period_TR
        .mux_qsys_conduit_period_TX                                (mux_qsys_conduit_period_TX),                                //                                            .period_TX
        .mux_qsys_conduit_period_TP                                (mux_qsys_conduit_period_TP),                                //                                            .period_TP
        .mux_qsys_conduit_detuning                                 (mux_qsys_conduit_detuning),                                 //                                            .detuning
        .mux_qsys_conduit_fi_phm                                   (mux_qsys_conduit_fi_phm),                                   //                                            .fi_phm
        .mux_qsys_conduit_tr                                       (mux_qsys_conduit_tr),                                       //                                            .tr
        .mux_qsys_conduit_tx                                       (mux_qsys_conduit_tx),                                       //                                            .tx
        .mux_qsys_conduit_tp                                       (mux_qsys_conduit_tp),                                       //                                            .tp
        .mux_qsys_conduit_dir_TX                                   (mux_qsys_conduit_dir_TX),                                   //                                            .dir_TX
        .mux_qsys_conduit_dir_TR                                   (mux_qsys_conduit_dir_TR),                                   //                                            .dir_TR
        .mux_qsys_conduit_dir_TP                                   (mux_qsys_conduit_dir_TP),                                   //                                            .dir_TP
        .mux_qsys_conduit_drv_en_TR                                (mux_qsys_conduit_drv_en_TR),                                //                                            .drv_en_TR
        .mux_qsys_conduit_drv_en_TX                                (mux_qsys_conduit_drv_en_TX),                                //                                            .drv_en_TX
        .mux_qsys_conduit_drv_en_TP                                (mux_qsys_conduit_drv_en_TP),                                //                                            .drv_en_TP
        .mux_qsys_conduit_counter_en_TR                            (mux_qsys_conduit_counter_en_TR),                            //                                            .counter_en_TR
        .mux_qsys_conduit_syncpulse                                (mux_qsys_conduit_syncpulse),                                //                                            .syncpulse
        .tp_qsys_conduit_k_TP                                      (tp_qsys_conduit_k_TP),                                      //                             tp_qsys_conduit.k_TP
        .tp_qsys_conduit_d_fi_gate2                                (tp_qsys_conduit_d_fi_gate2),                                //                                            .d_fi_gate2
        .tp_qsys_conduit_L                                         (tp_qsys_conduit_L),                                         //                                            .L
        .tp_qsys_conduit_DZ_TP                                     (tp_qsys_conduit_DZ_TP),                                     //                                            .DZ_TP
        .tp_qsys_conduit_F2                                        (tp_qsys_conduit_F2),                                        //                                            .F2
        .tp_qsys_conduit_F1                                        (tp_qsys_conduit_F1),                                        //                                            .F1
        .tp_qsys_conduit_detuning                                  (tp_qsys_conduit_detuning),                                  //                                            .detuning
        .tp_qsys_conduit_fi_set                                    (tp_qsys_conduit_fi_set),                                    //                                            .fi_set
        .tp_qsys_conduit_fi_phm                                    (tp_qsys_conduit_fi_phm),                                    //                                            .fi_phm
        .tp_qsys_conduit_tp_mode                                   (tp_qsys_conduit_tp_mode),                                   //                                            .tp_mode
        .tp_qsys_conduit_data_valid_TP                             (tp_qsys_conduit_data_valid_TP),                             //                                            .data_valid_TP
        .tp_qsys_conduit_period_TP                                 (tp_qsys_conduit_period_TP),                                 //                                            .period_TP
        .tp_qsys_conduit_dir_TP                                    (tp_qsys_conduit_dir_TP),                                    //                                            .dir_TP
        .tp_qsys_conduit_drv_en_TP                                 (tp_qsys_conduit_drv_en_TP),                                 //                                            .drv_en_TP
        .tx_qsys_conduit_syncpulse                                 (tx_qsys_conduit_syncpulse),                                 //                             tx_qsys_conduit.syncpulse
        .tx_qsys_conduit_k_TX                                      (tx_qsys_conduit_k_TX),                                      //                                            .k_TX
        .tx_qsys_conduit_d_i_gate2                                 (tx_qsys_conduit_d_i_gate2),                                 //                                            .d_i_gate2
        .tx_qsys_conduit_DZ_TX                                     (tx_qsys_conduit_DZ_TX),                                     //                                            .DZ_TX
        .tx_qsys_conduit_L                                         (tx_qsys_conduit_L),                                         //                                            .L
        .tx_qsys_conduit_F2                                        (tx_qsys_conduit_F2),                                        //                                            .F2
        .tx_qsys_conduit_F1                                        (tx_qsys_conduit_F1),                                        //                                            .F1
        .tx_qsys_conduit_i_fid_TX                                  (tx_qsys_conduit_i_fid_TX),                                  //                                            .i_fid_TX
        .tx_qsys_conduit_i_set                                     (tx_qsys_conduit_i_set),                                     //                                            .i_set
        .tx_qsys_conduit_tx_mode                                   (tx_qsys_conduit_tx_mode),                                   //                                            .tx_mode
        .tx_qsys_conduit_i_fid                                     (tx_qsys_conduit_i_fid),                                     //                                            .i_fid
        .tx_qsys_conduit_data_valid_TX                             (tx_qsys_conduit_data_valid_TX),                             //                                            .data_valid_TX
        .tx_qsys_conduit_period_TX                                 (tx_qsys_conduit_period_TX),                                 //                                            .period_TX
        .tx_qsys_conduit_dir_TX                                    (tx_qsys_conduit_dir_TX),                                    //                                            .dir_TX
        .tx_qsys_conduit_drv_en_TX                                 (tx_qsys_conduit_drv_en_TX),                                 //                                            .drv_en_TX
        .tr_qsys_conduit_drv_en_TR                                 (tr_qsys_conduit_drv_en_TR),                                 //                             tr_qsys_conduit.drv_en_TR
        .tr_qsys_conduit_dir_TR                                    (tr_qsys_conduit_dir_TR),                                    //                                            .dir_TR
        .tr_qsys_conduit_counter_en_TR                             (tr_qsys_conduit_counter_en_TR),                             //                                            .counter_en_TR
        .tr_qsys_conduit_period_TR                                 (tr_qsys_conduit_period_TR),                                 //                                            .period_TR
        .tr_qsys_conduit_dir_AUTO                                  (tr_qsys_conduit_dir_AUTO),                                  //                                            .dir_AUTO
        .tr_qsys_conduit_dir_MANUAL                                (tr_qsys_conduit_dir_MANUAL),                                //                                            .dir_MANUAL
        .tr_qsys_conduit_auto                                      (tr_qsys_conduit_auto),                                      //                                            .auto
        .tr_qsys_conduit_enable_AUTO                               (tr_qsys_conduit_enable_AUTO),                               //                                            .enable_AUTO
        .tr_qsys_conduit_enable_MANUAL                             (tr_qsys_conduit_enable_MANUAL),                             //                                            .enable_MANUAL
        .tr_qsys_conduit_period_AUTO                               (tr_qsys_conduit_period_AUTO),                               //                                            .period_AUTO
        .tr_qsys_conduit_count_MANUAL                              (tr_qsys_conduit_count_MANUAL),                              //                                            .count_MANUAL
        .tr_qsys_conduit_period_MANUAL                             (tr_qsys_conduit_period_MANUAL),                             //                                            .period_MANUAL
        .tr_auto_qsys_conduit_enable_AUTO                          (tr_auto_qsys_conduit_enable_AUTO),                          //                        tr_auto_qsys_conduit.enable_AUTO
        .tr_auto_qsys_conduit_dir_AUTO                             (tr_auto_qsys_conduit_dir_AUTO),                             //                                            .dir_AUTO
        .tr_auto_qsys_conduit_period_AUTO                          (tr_auto_qsys_conduit_period_AUTO),                          //                                            .period_AUTO
        .tr_auto_qsys_conduit_data_valid_TR                        (tr_auto_qsys_conduit_data_valid_TR),                        //                                            .data_valid_TR
        .tr_auto_qsys_conduit_tr_mode                              (tr_auto_qsys_conduit_tr_mode),                              //                                            .tr_mode
        .tr_auto_qsys_conduit_x_set                                (tr_auto_qsys_conduit_x_set),                                //                                            .x_set
        .tr_auto_qsys_conduit_x                                    (tr_auto_qsys_conduit_x),                                    //                                            .x
        .tr_auto_qsys_conduit_dx1                                  (tr_auto_qsys_conduit_dx1),                                  //                                            .dx1
        .tr_auto_qsys_conduit_dx2                                  (tr_auto_qsys_conduit_dx2),                                  //                                            .dx2
        .tr_auto_qsys_conduit_F1                                   (tr_auto_qsys_conduit_F1),                                   //                                            .F1
        .tr_auto_qsys_conduit_F2                                   (tr_auto_qsys_conduit_F2),                                   //                                            .F2
        .tr_auto_qsys_conduit_DZ_TR                                (tr_auto_qsys_conduit_DZ_TR),                                //                                            .DZ_TR
        .tr_auto_qsys_conduit_k_TR                                 (tr_auto_qsys_conduit_k_TR),                                 //                                            .k_TR
        .tr_auto_qsys_conduit_L                                    (tr_auto_qsys_conduit_L),                                    //                                            .L
        .tr_manual_qsys_conduit_count_N                            (tr_manual_qsys_conduit_count_N),                            //                      tr_manual_qsys_conduit.count_N
        .tr_manual_qsys_conduit_PULSE_NUMBER                       (tr_manual_qsys_conduit_PULSE_NUMBER),                       //                                            .PULSE_NUMBER
        .tr_manual_qsys_conduit_enable_MANUAL                      (tr_manual_qsys_conduit_enable_MANUAL),                      //                                            .enable_MANUAL
        .tr_manual_qsys_conduit_stop                               (tr_manual_qsys_conduit_stop),                               //                                            .stop
        .tr_manual_qsys_conduit_start_N                            (tr_manual_qsys_conduit_start_N),                            //                                            .start_N
        .tr_manual_qsys_conduit_start                              (tr_manual_qsys_conduit_start)                               //                                            .start
    );


endmodule 
