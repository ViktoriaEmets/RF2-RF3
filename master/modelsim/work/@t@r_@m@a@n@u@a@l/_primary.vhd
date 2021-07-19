library verilog;
use verilog.vl_types.all;
entity TR_MANUAL is
    generic(
        WIDTH_MANUAL    : integer := 16
    );
    port(
        start           : in     vl_logic;
        start_N         : in     vl_logic;
        stop            : in     vl_logic;
        enable_MANUAL   : out    vl_logic;
        PULSE_NUMBER    : in     vl_logic_vector;
        count_N         : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_MANUAL : constant is 1;
end TR_MANUAL;
