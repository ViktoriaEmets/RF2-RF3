onerror {resume}
quietly virtual function -install /test/delay -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000002
quietly virtual function -install /test -env /test { (2)} virtual_000003
quietly virtual function -install /test -env /test { (2)} virtual_000004
quietly virtual function -install /test -env /test { (2)} virtual_000005
quietly virtual function -install /test -env /test { 150241.76} virtual_000006
quietly virtual function -install /test -env /test { (1000)} virtual_000007
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/TR_pulse_test/drv_step
add wave -noupdate -format Analog-Step -height 74 -max 8401.0 -radix unsigned /test/TR_pulse_test/count_step
add wave -noupdate /test/TR_pulse_test/drv_pulse
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5717210 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 93
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
WaveRestoreZoom {0 ns} {31500 us}
