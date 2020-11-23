onerror {resume}
quietly virtual function -install /test/delay -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000002
quietly virtual function -install /test -env /test { (2)} virtual_000003
quietly virtual function -install /test -env /test { (2)} virtual_000004
quietly virtual function -install /test -env /test { (2)} virtual_000005
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/TR_pulse_test/clk
add wave -noupdate /test/TR_pulse_test/rst
add wave -noupdate /test/TR_pulse_test/data_valid_trig
add wave -noupdate /test/TR_pulse_test/in_drv_enable_SM
add wave -noupdate -format Analog-Step -height 74 -max 39600.0 -radix unsigned /test/TR_pulse_test/N
add wave -noupdate -format Analog-Step -height 74 -max 39600.0 -radix unsigned /test/TR_pulse_test/number
add wave -noupdate -format Analog-Step -height 74 -max 14469.0 -radix unsigned /test/TR_pulse_test/drv_count
add wave -noupdate -radix unsigned /test/TR_pulse_test/drv_step
add wave -noupdate -format Analog-Step -height 74 -max 2798.0 -radix unsigned /test/TR_test/dx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {900330 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 236
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
WaveRestoreZoom {2477500 ns} {3527500 ns}
