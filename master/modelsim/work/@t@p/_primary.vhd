library verilog;
use verilog.vl_types.all;
entity TP is
    generic(
        WIDTH_TP        : integer := 16
    );
    port(
        drv_en_TP       : out    vl_logic;
        dir_TP          : out    vl_logic;
        period_TP       : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_valid_TP   : in     vl_logic;
        tp_mode         : in     vl_logic;
        fi_phm          : in     vl_logic_vector;
        fi_set          : in     vl_logic_vector;
        detuning        : in     vl_logic_vector;
        F1              : in     vl_logic_vector;
        F2              : in     vl_logic_vector;
        DZ_TP           : in     vl_logic_vector;
        L               : in     vl_logic_vector;
        d_fi_gate2      : in     vl_logic_vector;
        k_TP            : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_TP : constant is 1;
end TP;
