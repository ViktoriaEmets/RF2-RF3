onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /Test/TR_AUTO_Test/rst
add wave -noupdate -radix unsigned /Test/tr_mode
add wave -noupdate -radix unsigned /Test/x_set
add wave -noupdate -format Analog-Step -height 74 -max 499.99999999999994 -radix unsigned /Test/TR_AUTO_Test/x
add wave -noupdate -format Analog-Step -height 74 -max 465.0 -radix unsigned /Test/TR_AUTO_Test/d_x
add wave -noupdate -format Analog-Step -height 74 -max 2.0 -radix unsigned /Test/TR_AUTO_Test/state_auto
add wave -noupdate -format Analog-Step -height 74 -max 6250.0 -radix unsigned /Test/TR_AUTO_Test/period_AUTO
add wave -noupdate -radix unsigned /Test/TR_AUTO_Test/dir_AUTO
add wave -noupdate /Test/TR_AUTO_Test/enable_AUTO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {581700 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 222
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
WaveRestoreZoom {7500 ns} {3157500 ns}
