# TCL File Generated by Component Editor 13.1
# Fri Apr 23 15:49:42 NOVST 2021
# DO NOT MODIFY


# 
# tr_comp "tr_comp" v1.0
#  2021.04.23.15:49:42
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module tr_comp
# 
set_module_property DESCRIPTION ""
set_module_property NAME tr_comp
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME tr_comp
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL TR_pulse
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file TR_pulse.v VERILOG PATH ../src/tr_pulse/TR_pulse.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter SIZE INTEGER 16
set_parameter_property SIZE DEFAULT_VALUE 16
set_parameter_property SIZE DISPLAY_NAME SIZE
set_parameter_property SIZE TYPE INTEGER
set_parameter_property SIZE UNITS None
set_parameter_property SIZE ALLOWED_RANGES -2147483648:2147483647
set_parameter_property SIZE HDL_PARAMETER true
add_parameter N INTEGER 100
set_parameter_property N DEFAULT_VALUE 100
set_parameter_property N DISPLAY_NAME N
set_parameter_property N TYPE INTEGER
set_parameter_property N UNITS None
set_parameter_property N ALLOWED_RANGES -2147483648:2147483647
set_parameter_property N HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point s0
# 
add_interface s0 avalon end
set_interface_property s0 addressUnits WORDS
set_interface_property s0 associatedClock clock
set_interface_property s0 associatedReset reset
set_interface_property s0 bitsPerSymbol 8
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 burstcountUnits WORDS
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0
set_interface_property s0 ENABLED true
set_interface_property s0 EXPORT_OF ""
set_interface_property s0 PORT_NAME_MAP ""
set_interface_property s0 CMSIS_SVD_VARIABLES ""
set_interface_property s0 SVD_ADDRESS_GROUP ""

add_interface_port s0 avs_s0_write write Input 1
add_interface_port s0 avs_s0_read read Input 1
add_interface_port s0 avs_s0_readdata readdata Output 8
add_interface_port s0 avs_s0_writedata writedata Input 8
add_interface_port s0 avs_s0_address address Input 8
set_interface_assignment s0 embeddedsw.configuration.isFlash 0
set_interface_assignment s0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment s0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment s0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset reset
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end start export Output 1
add_interface_port conduit_end start_N export Output 1
add_interface_port conduit_end stop export Output 1
add_interface_port conduit_end avto export Output 1
add_interface_port conduit_end pulse_invert export Output 1
add_interface_port conduit_end drv_pulse export Output 1
add_interface_port conduit_end d_v export Input 1
add_interface_port conduit_end drv_en_SM export Input 1
add_interface_port conduit_end n export Input SIZE
add_interface_port conduit_end drv_dir export Output 1
add_interface_port conduit_end dir_auto export Input 1
add_interface_port conduit_end xyz export Output 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rst reset Input 1

