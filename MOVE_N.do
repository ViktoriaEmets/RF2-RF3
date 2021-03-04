onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /test1/TR_P_test1/rst
add wave -noupdate /test1/TR_P_test1/avto
add wave -noupdate -radix unsigned /test1/TR_P_test1/start
add wave -noupdate /test1/TR_P_test1/start_N
add wave -noupdate -radix unsigned /test1/TR_P_test1/stop
add wave -noupdate -radix unsigned -childformat {{{/test1/TR_P_test1/NextState[3]} -radix unsigned} {{/test1/TR_P_test1/NextState[2]} -radix unsigned} {{/test1/TR_P_test1/NextState[1]} -radix unsigned} {{/test1/TR_P_test1/NextState[0]} -radix unsigned}} -subitemconfig {{/test1/TR_P_test1/NextState[3]} {-height 15 -radix unsigned} {/test1/TR_P_test1/NextState[2]} {-height 15 -radix unsigned} {/test1/TR_P_test1/NextState[1]} {-height 15 -radix unsigned} {/test1/TR_P_test1/NextState[0]} {-height 15 -radix unsigned}} /test1/TR_P_test1/NextState
add wave -noupdate /test1/TR_P_test1/starting
add wave -noupdate /test1/TR_P_test1/Ning
add wave -noupdate -radix unsigned /test1/TR_P_test1/pulse_enable
add wave -noupdate -radix unsigned /test1/TR_P_test1/counter_en
add wave -noupdate -radix unsigned /test1/TR_P_test1/period_AUTO
add wave -noupdate -format Analog-Step -height 74 -max 2001.9999999999998 -radix unsigned -childformat {{{/test1/TR_P_test1/drv_count[15]} -radix unsigned} {{/test1/TR_P_test1/drv_count[14]} -radix unsigned} {{/test1/TR_P_test1/drv_count[13]} -radix unsigned} {{/test1/TR_P_test1/drv_count[12]} -radix unsigned} {{/test1/TR_P_test1/drv_count[11]} -radix unsigned} {{/test1/TR_P_test1/drv_count[10]} -radix unsigned} {{/test1/TR_P_test1/drv_count[9]} -radix unsigned} {{/test1/TR_P_test1/drv_count[8]} -radix unsigned} {{/test1/TR_P_test1/drv_count[7]} -radix unsigned} {{/test1/TR_P_test1/drv_count[6]} -radix unsigned} {{/test1/TR_P_test1/drv_count[5]} -radix unsigned} {{/test1/TR_P_test1/drv_count[4]} -radix unsigned} {{/test1/TR_P_test1/drv_count[3]} -radix unsigned} {{/test1/TR_P_test1/drv_count[2]} -radix unsigned} {{/test1/TR_P_test1/drv_count[1]} -radix unsigned} {{/test1/TR_P_test1/drv_count[0]} -radix unsigned}} -subitemconfig {{/test1/TR_P_test1/drv_count[15]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[14]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[13]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[12]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[11]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[10]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[9]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[8]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[7]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[6]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[5]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[4]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[3]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[2]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[1]} {-height 15 -radix unsigned} {/test1/TR_P_test1/drv_count[0]} {-height 15 -radix unsigned}} /test1/TR_P_test1/drv_count
add wave -noupdate -format Analog-Step -height 74 -max 100.0 -radix unsigned /test1/TR_P_test1/count_N
add wave -noupdate -radix unsigned /test1/TR_P_test1/step
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11612500 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
configure wave -valuecolwidth 49
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {21 ms}
