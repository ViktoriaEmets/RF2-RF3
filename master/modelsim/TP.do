onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /Test/TP_Test/tp_mode
add wave -noupdate -radix unsigned /Test/TP_Test/fi_set
add wave -noupdate -format Analog-Step -height 74 -max 180.0 -radix unsigned /Test/TP_Test/fi_phm
add wave -noupdate -format Analog-Step -height 74 -max 110.0 -radix unsigned /Test/TP_Test/d_fi
add wave -noupdate -format Analog-Step -height 74 -max 2.0 -radix unsigned /Test/TP_Test/state_TP
add wave -noupdate -format Analog-Step -height 74 -max 2468.0 -radix unsigned /Test/TP_Test/period_TP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {911010 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
configure wave -valuecolwidth 42
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
