library verilog;
use verilog.vl_types.all;
entity TR is
    generic(
        WIDTH_TR        : integer := 16
    );
    port(
        drv_en_TR       : out    vl_logic;
        dir_TR          : out    vl_logic;
        counter_en_TR   : out    vl_logic;
        period_TR       : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        dir_AUTO        : in     vl_logic;
        dir_MANUAL      : in     vl_logic;
        auto            : in     vl_logic;
        enable_AUTO     : in     vl_logic;
        enable_MANUAL   : in     vl_logic;
        count_MANUAL    : in     vl_logic;
        period_AUTO     : in     vl_logic_vector;
        period_MANUAL   : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_TR : constant is 1;
end TR;
