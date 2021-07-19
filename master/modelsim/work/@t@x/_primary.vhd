library verilog;
use verilog.vl_types.all;
entity TX is
    generic(
        WIDTH_TX        : integer := 16
    );
    port(
        drv_en_TX       : out    vl_logic;
        dir_TX          : out    vl_logic;
        period_TX       : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_valid_TX   : in     vl_logic;
        tx_mode         : in     vl_logic;
        i_fid           : in     vl_logic_vector;
        i_set           : in     vl_logic_vector;
        i_fid_TX        : in     vl_logic_vector;
        F1              : in     vl_logic_vector;
        F2              : in     vl_logic_vector;
        DZ_TX           : in     vl_logic_vector;
        L               : in     vl_logic_vector;
        d_i_gate2       : in     vl_logic_vector;
        k_TX            : in     vl_logic_vector;
        syncpulse       : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_TX : constant is 1;
end TX;
