library verilog;
use verilog.vl_types.all;
entity TR_MANUAL is
    generic(
        WIDTH_MANUAL    : integer := 16
    );
    port(
        start           : out    vl_logic;
        start_N         : out    vl_logic;
        stop            : out    vl_logic;
        dir_MANUAL      : out    vl_logic;
        enable_MANUAL   : out    vl_logic;
        count_MANUAL    : out    vl_logic;
        period_MANUAL   : out    vl_logic_vector;
        PULSE_NUMBER    : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        address         : in     vl_logic_vector(7 downto 0);
        writedata       : in     vl_logic_vector(31 downto 0);
        readdata        : out    vl_logic_vector(31 downto 0);
        write           : in     vl_logic;
        read            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_MANUAL : constant is 1;
end TR_MANUAL;
