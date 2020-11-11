onerror {resume}
quietly virtual function -install /test/delay -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000001
quietly virtual function -install /test -env /test { (2)} virtual_000002
quietly virtual function -install /test -env /test { (2)} virtual_000003
quietly virtual function -install /test -env /test { (2)} virtual_000004
quietly virtual function -install /test -env /test { (2)} virtual_000005
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/clk_50MHz
add wave -noupdate -radix decimal /test/TR_test/data_valid
add wave -noupdate /test/rst
add wave -noupdate /test/enable
add wave -noupdate -radix unsigned -childformat {{{/test/TR_test/count[16]} -radix unsigned} {{/test/TR_test/count[15]} -radix unsigned} {{/test/TR_test/count[14]} -radix unsigned} {{/test/TR_test/count[13]} -radix unsigned} {{/test/TR_test/count[12]} -radix unsigned} {{/test/TR_test/count[11]} -radix unsigned} {{/test/TR_test/count[10]} -radix unsigned} {{/test/TR_test/count[9]} -radix unsigned} {{/test/TR_test/count[8]} -radix unsigned} {{/test/TR_test/count[7]} -radix unsigned} {{/test/TR_test/count[6]} -radix unsigned} {{/test/TR_test/count[5]} -radix unsigned} {{/test/TR_test/count[4]} -radix unsigned} {{/test/TR_test/count[3]} -radix unsigned} {{/test/TR_test/count[2]} -radix unsigned} {{/test/TR_test/count[1]} -radix unsigned} {{/test/TR_test/count[0]} -radix unsigned}} -subitemconfig {{/test/TR_test/count[16]} {-height 15 -radix unsigned} {/test/TR_test/count[15]} {-height 15 -radix unsigned} {/test/TR_test/count[14]} {-height 15 -radix unsigned} {/test/TR_test/count[13]} {-height 15 -radix unsigned} {/test/TR_test/count[12]} {-height 15 -radix unsigned} {/test/TR_test/count[11]} {-height 15 -radix unsigned} {/test/TR_test/count[10]} {-height 15 -radix unsigned} {/test/TR_test/count[9]} {-height 15 -radix unsigned} {/test/TR_test/count[8]} {-height 15 -radix unsigned} {/test/TR_test/count[7]} {-height 15 -radix unsigned} {/test/TR_test/count[6]} {-height 15 -radix unsigned} {/test/TR_test/count[5]} {-height 15 -radix unsigned} {/test/TR_test/count[4]} {-height 15 -radix unsigned} {/test/TR_test/count[3]} {-height 15 -radix unsigned} {/test/TR_test/count[2]} {-height 15 -radix unsigned} {/test/TR_test/count[1]} {-height 15 -radix unsigned} {/test/TR_test/count[0]} {-height 15 -radix unsigned}} /test/TR_test/count
add wave -noupdate -radix unsigned /test/N_async
add wave -noupdate -radix unsigned /test/TR_test/N
add wave -noupdate -radix decimal /test/TR_test/x0
add wave -noupdate -format Analog-Step -height 74 -max 3.0 -radix unsigned -childformat {{{/test/TR_test/state[1]} -radix decimal} {{/test/TR_test/state[0]} -radix decimal}} -subitemconfig {{/test/TR_test/state[1]} {-height 15 -radix decimal} {/test/TR_test/state[0]} {-height 15 -radix decimal}} /test/TR_test/state
add wave -noupdate -format Analog-Step -height 74 -max 25.0 -min 10.0 -radix unsigned -childformat {{{/test/x[11]} -radix decimal} {{/test/x[10]} -radix decimal} {{/test/x[9]} -radix decimal} {{/test/x[8]} -radix decimal} {{/test/x[7]} -radix decimal} {{/test/x[6]} -radix decimal} {{/test/x[5]} -radix decimal} {{/test/x[4]} -radix decimal} {{/test/x[3]} -radix decimal} {{/test/x[2]} -radix decimal} {{/test/x[1]} -radix decimal} {{/test/x[0]} -radix decimal}} -subitemconfig {{/test/x[11]} {-height 15 -radix decimal} {/test/x[10]} {-height 15 -radix decimal} {/test/x[9]} {-height 15 -radix decimal} {/test/x[8]} {-height 15 -radix decimal} {/test/x[7]} {-height 15 -radix decimal} {/test/x[6]} {-height 15 -radix decimal} {/test/x[5]} {-height 15 -radix decimal} {/test/x[4]} {-height 15 -radix decimal} {/test/x[3]} {-height 15 -radix decimal} {/test/x[2]} {-height 15 -radix decimal} {/test/x[1]} {-height 15 -radix decimal} {/test/x[0]} {-height 15 -radix decimal}} /test/x
add wave -noupdate -format Analog-Step -height 74 -max 4083.9999999999995 -min 4.0 -radix unsigned /test/TR_test/dx
add wave -noupdate /test/drv_SM
add wave -noupdate -radix unsigned /test/drv_step
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4700 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 164
configure wave -valuecolwidth 58
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
WaveRestoreZoom {0 ns} {10500 ns}
