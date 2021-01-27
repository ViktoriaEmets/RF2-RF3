onerror {resume}
quietly virtual function -install /test/delay -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000002
quietly virtual function -install /test -env /test { (2)} virtual_000003
quietly virtual function -install /test -env /test { (2)} virtual_000004
quietly virtual function -install /test -env /test { (2)} virtual_000005
quietly virtual function -install /test -env /test { 150241.76} virtual_000006
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/TR_pulse_test/clk
add wave -noupdate /test/TR_pulse_test/rst
add wave -noupdate /test/TR_pulse_test/data_valid_trig
add wave -noupdate /test/TR_pulse_test/in_drv_enable_SM
add wave -noupdate -format Analog-Step -height 74 -max 80000.0 -radix unsigned /test/TR_pulse_test/N
add wave -noupdate -format Analog-Step -height 74 -max 65525.000000000007 -radix unsigned /test/TR_test/dx
add wave -noupdate -format Analog-Step -height 74 -max 80000.0 -radix unsigned /test/TR_pulse_test/number
add wave -noupdate -format Analog-Step -height 74 -max 41220.0 -radix unsigned -childformat {{{/test/TR_pulse_test/drv_count[16]} -radix unsigned} {{/test/TR_pulse_test/drv_count[15]} -radix unsigned} {{/test/TR_pulse_test/drv_count[14]} -radix unsigned} {{/test/TR_pulse_test/drv_count[13]} -radix unsigned} {{/test/TR_pulse_test/drv_count[12]} -radix unsigned} {{/test/TR_pulse_test/drv_count[11]} -radix unsigned} {{/test/TR_pulse_test/drv_count[10]} -radix unsigned} {{/test/TR_pulse_test/drv_count[9]} -radix unsigned} {{/test/TR_pulse_test/drv_count[8]} -radix unsigned} {{/test/TR_pulse_test/drv_count[7]} -radix unsigned} {{/test/TR_pulse_test/drv_count[6]} -radix unsigned} {{/test/TR_pulse_test/drv_count[5]} -radix unsigned} {{/test/TR_pulse_test/drv_count[4]} -radix unsigned} {{/test/TR_pulse_test/drv_count[3]} -radix unsigned} {{/test/TR_pulse_test/drv_count[2]} -radix unsigned} {{/test/TR_pulse_test/drv_count[1]} -radix unsigned} {{/test/TR_pulse_test/drv_count[0]} -radix unsigned}} -subitemconfig {{/test/TR_pulse_test/drv_count[16]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[15]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[14]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[13]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[12]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[11]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[10]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[9]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[8]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[7]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[6]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[5]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[4]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[3]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[2]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[1]} {-height 15 -radix unsigned} {/test/TR_pulse_test/drv_count[0]} {-height 15 -radix unsigned}} /test/TR_pulse_test/drv_count
add wave -noupdate /test/TR_pulse_test/drv_pulse
add wave -noupdate -radix unsigned /test/TR_test/k
add wave -noupdate -radix unsigned /test/TR_test/F0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {52224700 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
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
WaveRestoreZoom {0 ns} {68890500 ns}
