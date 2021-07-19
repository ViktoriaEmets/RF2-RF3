onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /Test/F1
add wave -noupdate -radix unsigned /Test/F2
add wave -noupdate -radix unsigned /Test/dx1
add wave -noupdate -radix unsigned /Test/dx2
add wave -noupdate -radix unsigned /Test/TR_Test/x_set
add wave -noupdate -format Analog-Step -height 74 -max 499.99999999999994 -radix unsigned /Test/TR_Test/x
add wave -noupdate -format Analog-Step -height 74 -max 495.0 -radix unsigned /Test/TR_Test/d_x
add wave -noupdate -radix unsigned /Test/TR_Test/n_async
add wave -noupdate -format Analog-Step -height 74 -max 6250.0 -radix unsigned /Test/TR_Test/period_AUTO
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {955760 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {3150 us}
