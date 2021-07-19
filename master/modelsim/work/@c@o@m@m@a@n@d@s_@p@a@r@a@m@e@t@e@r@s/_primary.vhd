library verilog;
use verilog.vl_types.all;
entity COMMANDS_PARAMETERS is
    generic(
        WIDTH_C_P       : integer := 16
    );
    port(
        start           : out    vl_logic;
        start_N         : out    vl_logic;
        stop            : out    vl_logic;
        auto            : out    vl_logic;
        tr              : out    vl_logic;
        tx              : out    vl_logic;
        tp              : out    vl_logic;
        dir_MANUAL      : out    vl_logic;
        count_MANUAL    : out    vl_logic;
        F1              : out    vl_logic_vector;
        F2              : out    vl_logic_vector;
        L               : out    vl_logic_vector;
        period_MANUAL   : out    vl_logic_vector;
        PULSE_NUMBER    : out    vl_logic_vector;
        DZ_TR           : out    vl_logic_vector;
        DZ_TX           : out    vl_logic_vector;
        DZ_TP           : out    vl_logic_vector;
        dx1             : out    vl_logic_vector;
        dx2             : out    vl_logic_vector;
        d_i_gate2       : out    vl_logic_vector;
        d_fi_gate2      : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        TURN_ON_RF      : in     vl_logic;
        syncpulse       : in     vl_logic;
        detuning        : in     vl_logic_vector(31 downto 0);
        fi_phm          : in     vl_logic_vector(31 downto 0);
        avs_s0_address  : in     vl_logic_vector(15 downto 0);
        avs_s0_writedata: in     vl_logic_vector(31 downto 0);
        avs_s0_readdata : out    vl_logic_vector(31 downto 0);
        avs_s0_write    : in     vl_logic;
        avs_s0_read     : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_C_P : constant is 1;
end COMMANDS_PARAMETERS;
