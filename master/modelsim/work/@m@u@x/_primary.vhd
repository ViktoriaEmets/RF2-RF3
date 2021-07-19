library verilog;
use verilog.vl_types.all;
entity MUX is
    generic(
        WIDTH_MUX       : integer := 16
    );
    port(
        drv_period      : out    vl_logic_vector;
        drv_dir         : out    vl_logic;
        enable          : out    vl_logic;
        counter_en      : out    vl_logic;
        period_TR       : in     vl_logic_vector;
        period_TX       : in     vl_logic_vector;
        period_TP       : in     vl_logic_vector;
        detuning        : in     vl_logic_vector;
        fi_phm          : in     vl_logic_vector;
        tr              : in     vl_logic;
        tx              : in     vl_logic;
        tp              : in     vl_logic;
        dir_TR          : in     vl_logic;
        dir_TX          : in     vl_logic;
        dir_TP          : in     vl_logic;
        drv_en_TR       : in     vl_logic;
        drv_en_TX       : in     vl_logic;
        drv_en_TP       : in     vl_logic;
        counter_en_TR   : in     vl_logic;
        syncpulse       : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_MUX : constant is 1;
end MUX;
