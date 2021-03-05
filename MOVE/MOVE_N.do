onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test1/TR_P_test1/rst
add wave -noupdate /test1/TR_P_test1/avto
add wave -noupdate /test1/TR_P_test1/start
add wave -noupdate /test1/TR_P_test1/start_N
add wave -noupdate /test1/TR_P_test1/stop
add wave -noupdate /test1/TR_P_test1/starting
add wave -noupdate -format Analog-Step -height 74 -max 2001.9999999999998 -radix unsigned /test1/TR_P_test1/drv_count
add wave -noupdate -radix unsigned /test1/TR_P_test1/counter_en
add wave -noupdate -format Analog-Step -height 74 -max 10.0 -radix unsigned /test1/TR_P_test1/count_N
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13031700 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 194
configure wave -valuecolwidth 39
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
WaveRestoreZoom {0 ns} {24414950 ns}
