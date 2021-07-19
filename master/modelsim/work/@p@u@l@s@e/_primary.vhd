library verilog;
use verilog.vl_types.all;
entity PULSE is
    generic(
        WIDTH           : integer := 16
    );
    port(
        drv_pulse       : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        drv_dir         : in     vl_logic;
        enable          : in     vl_logic;
        counter_en      : in     vl_logic;
        drv_period      : in     vl_logic_vector;
        PULSE_NUMBER    : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end PULSE;
