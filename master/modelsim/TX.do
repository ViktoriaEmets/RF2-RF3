onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /Test/TX_Test/rst
add wave -noupdate -radix unsigned /Test/TX_Test/i_set
add wave -noupdate -format Analog-Step -height 74 -max 5660.0 -min 10.0 -radix unsigned /Test/TX_Test/i_fid
add wave -noupdate -format Analog-Step -height 74 -max 5610.0 -radix unsigned /Test/TX_Test/d_i
add wave -noupdate -radix unsigned /Test/TX_Test/syncpulse
add wave -noupdate -radix unsigned /Test/TX_Test/tx_mode
add wave -noupdate -format Analog-Step -height 74 -max 2.0 -radix unsigned /Test/TX_Test/state_TX
add wave -noupdate -format Analog-Step -height 74 -max 6250.0 -radix unsigned /Test/TX_Test/period_TX
add wave -noupdate -radix unsigned /Test/TX_Test/dir_TX
add wave -noupdate -radix unsigned /Test/TX_Test/drv_en_TX
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {311340 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 203
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ns} {2100 us}
