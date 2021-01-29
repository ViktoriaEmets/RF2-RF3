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
add wave -noupdate /test/TR_pulse_test/rst
add wave -noupdate /test/TR_pulse_test/in_drv_enable_SM
add wave -noupdate -format Analog-Step -height 74 -max 29995.000000000004 -radix unsigned /test/TR_test/dx
add wave -noupdate -radix unsigned -childformat {{{/test/TR_test/k[15]} -radix unsigned} {{/test/TR_test/k[14]} -radix unsigned} {{/test/TR_test/k[13]} -radix unsigned} {{/test/TR_test/k[12]} -radix unsigned} {{/test/TR_test/k[11]} -radix unsigned} {{/test/TR_test/k[10]} -radix unsigned} {{/test/TR_test/k[9]} -radix unsigned} {{/test/TR_test/k[8]} -radix unsigned} {{/test/TR_test/k[7]} -radix unsigned} {{/test/TR_test/k[6]} -radix unsigned} {{/test/TR_test/k[5]} -radix unsigned} {{/test/TR_test/k[4]} -radix unsigned} {{/test/TR_test/k[3]} -radix unsigned} {{/test/TR_test/k[2]} -radix unsigned} {{/test/TR_test/k[1]} -radix unsigned} {{/test/TR_test/k[0]} -radix unsigned}} -subitemconfig {{/test/TR_test/k[15]} {-height 15 -radix unsigned} {/test/TR_test/k[14]} {-height 15 -radix unsigned} {/test/TR_test/k[13]} {-height 15 -radix unsigned} {/test/TR_test/k[12]} {-height 15 -radix unsigned} {/test/TR_test/k[11]} {-height 15 -radix unsigned} {/test/TR_test/k[10]} {-height 15 -radix unsigned} {/test/TR_test/k[9]} {-height 15 -radix unsigned} {/test/TR_test/k[8]} {-height 15 -radix unsigned} {/test/TR_test/k[7]} {-height 15 -radix unsigned} {/test/TR_test/k[6]} {-height 15 -radix unsigned} {/test/TR_test/k[5]} {-height 15 -radix unsigned} {/test/TR_test/k[4]} {-height 15 -radix unsigned} {/test/TR_test/k[3]} {-height 15 -radix unsigned} {/test/TR_test/k[2]} {-height 15 -radix unsigned} {/test/TR_test/k[1]} {-height 15 -radix unsigned} {/test/TR_test/k[0]} {-height 15 -radix unsigned}} /test/TR_test/k
add wave -noupdate -format Analog-Step -height 74 -max 103197.0 -min 6000.0 -radix unsigned -childformat {{{/test/TR_test/N_async[31]} -radix unsigned} {{/test/TR_test/N_async[30]} -radix unsigned} {{/test/TR_test/N_async[29]} -radix unsigned} {{/test/TR_test/N_async[28]} -radix unsigned} {{/test/TR_test/N_async[27]} -radix unsigned} {{/test/TR_test/N_async[26]} -radix unsigned} {{/test/TR_test/N_async[25]} -radix unsigned} {{/test/TR_test/N_async[24]} -radix unsigned} {{/test/TR_test/N_async[23]} -radix unsigned} {{/test/TR_test/N_async[22]} -radix unsigned} {{/test/TR_test/N_async[21]} -radix unsigned} {{/test/TR_test/N_async[20]} -radix unsigned} {{/test/TR_test/N_async[19]} -radix unsigned} {{/test/TR_test/N_async[18]} -radix unsigned} {{/test/TR_test/N_async[17]} -radix unsigned} {{/test/TR_test/N_async[16]} -radix unsigned} {{/test/TR_test/N_async[15]} -radix unsigned} {{/test/TR_test/N_async[14]} -radix unsigned} {{/test/TR_test/N_async[13]} -radix unsigned} {{/test/TR_test/N_async[12]} -radix unsigned} {{/test/TR_test/N_async[11]} -radix unsigned} {{/test/TR_test/N_async[10]} -radix unsigned} {{/test/TR_test/N_async[9]} -radix unsigned} {{/test/TR_test/N_async[8]} -radix unsigned} {{/test/TR_test/N_async[7]} -radix unsigned} {{/test/TR_test/N_async[6]} -radix unsigned} {{/test/TR_test/N_async[5]} -radix unsigned} {{/test/TR_test/N_async[4]} -radix unsigned} {{/test/TR_test/N_async[3]} -radix unsigned} {{/test/TR_test/N_async[2]} -radix unsigned} {{/test/TR_test/N_async[1]} -radix unsigned} {{/test/TR_test/N_async[0]} -radix unsigned}} -subitemconfig {{/test/TR_test/N_async[31]} {-height 15 -radix unsigned} {/test/TR_test/N_async[30]} {-height 15 -radix unsigned} {/test/TR_test/N_async[29]} {-height 15 -radix unsigned} {/test/TR_test/N_async[28]} {-height 15 -radix unsigned} {/test/TR_test/N_async[27]} {-height 15 -radix unsigned} {/test/TR_test/N_async[26]} {-height 15 -radix unsigned} {/test/TR_test/N_async[25]} {-height 15 -radix unsigned} {/test/TR_test/N_async[24]} {-height 15 -radix unsigned} {/test/TR_test/N_async[23]} {-height 15 -radix unsigned} {/test/TR_test/N_async[22]} {-height 15 -radix unsigned} {/test/TR_test/N_async[21]} {-height 15 -radix unsigned} {/test/TR_test/N_async[20]} {-height 15 -radix unsigned} {/test/TR_test/N_async[19]} {-height 15 -radix unsigned} {/test/TR_test/N_async[18]} {-height 15 -radix unsigned} {/test/TR_test/N_async[17]} {-height 15 -radix unsigned} {/test/TR_test/N_async[16]} {-height 15 -radix unsigned} {/test/TR_test/N_async[15]} {-height 15 -radix unsigned} {/test/TR_test/N_async[14]} {-height 15 -radix unsigned} {/test/TR_test/N_async[13]} {-height 15 -radix unsigned} {/test/TR_test/N_async[12]} {-height 15 -radix unsigned} {/test/TR_test/N_async[11]} {-height 15 -radix unsigned} {/test/TR_test/N_async[10]} {-height 15 -radix unsigned} {/test/TR_test/N_async[9]} {-height 15 -radix unsigned} {/test/TR_test/N_async[8]} {-height 15 -radix unsigned} {/test/TR_test/N_async[7]} {-height 15 -radix unsigned} {/test/TR_test/N_async[6]} {-height 15 -radix unsigned} {/test/TR_test/N_async[5]} {-height 15 -radix unsigned} {/test/TR_test/N_async[4]} {-height 15 -radix unsigned} {/test/TR_test/N_async[3]} {-height 15 -radix unsigned} {/test/TR_test/N_async[2]} {-height 15 -radix unsigned} {/test/TR_test/N_async[1]} {-height 15 -radix unsigned} {/test/TR_test/N_async[0]} {-height 15 -radix unsigned}} /test/TR_test/N_async
add wave -noupdate -format Analog-Step -height 74 -max 65249.0 -radix unsigned /test/TR_test/N
add wave -noupdate /test/TR_pulse_test/drv_step
add wave -noupdate /test/TR_pulse_test/drv_pulse
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17520490 ns} 0}
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
WaveRestoreZoom {0 ns} {52500 us}
