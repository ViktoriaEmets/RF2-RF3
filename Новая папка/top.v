module top
(
                input                           clk,
                //output wire           tr_pulse_comp_0_conduit_end_1_drv_pulse


                output wire			avs_comp_0_conduit_end_start,
                output wire			avs_comp_0_conduit_end_stop,
                output wire			avs_comp_0_conduit_end_start_N,
                output wire			avs_comp_0_conduit_end_pulse_invert,
					 output wire			avs_comp_0_conduit_end_avto,
					 output wire			avs_comp_0_conduit_end_drv_pulse,
					 
					 output wire 			xyz
);

  // rfn_ctrl_pld rfn_ctrl_pld_test
  //   (
  //    .clk_clk                           (clk),
  //    .reset_reset_n             (1),
  //    //.tr_pulse_comp_0_conduit_end_1_drv_pulse  (tr_pulse_comp_0_conduit_end_1_drv_pulse)

  //    .avs_comp_0_conduit_end_start				(avs_comp_0_conduit_end_start),
  //    .avs_comp_0_conduit_end_stop                               (avs_comp_0_conduit_end_stop),
  //    .avs_comp_0_conduit_end_start_N			(avs_comp_0_conduit_end_start_N),
  //    .avs_comp_0_conduit_end_pulse_invert	(avs_comp_0_conduit_end_pulse_invert)
  //    );

  rfn_ctrl_pld rfn_ctrl_pld_test
    (
     .clk_clk                            (clk),                                 // clk.clk
     .reset_reset_n                      (1'b1),                                // reset.reset_n
     .pio_led_export                     (),                                    // pio_led.export
     .tr_comp_0_conduit_end_start        (avs_comp_0_conduit_end_start),       // tr_comp_0_conduit_end.start
     .tr_comp_0_conduit_end_start_N      (avs_comp_0_conduit_end_start_N),      // .start_N
     .tr_comp_0_conduit_end_stop         (avs_comp_0_conduit_end_stop),         // .stop
     .tr_comp_0_conduit_end_avto         (avs_comp_0_conduit_end_avto),                                    // .avto
     .tr_comp_0_conduit_end_pulse_invert (avs_comp_0_conduit_end_pulse_invert), // .pulse_invert
     .tr_comp_0_conduit_end_drv_pulse    (avs_comp_0_conduit_end_drv_pulse),                                    // .drv_pulse
     .tr_comp_0_conduit_end_d_v          (),                                    // .d_v
     .tr_comp_0_conduit_end_drv_en_SM    (),                                    // .drv_en_SM
     .tr_comp_0_conduit_end_n            (),             
	  // .n
	  .tr_comp_0_conduit_end_xyz		  (xyz)
     );




endmodule
