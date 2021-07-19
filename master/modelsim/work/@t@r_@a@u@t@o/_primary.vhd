library verilog;
use verilog.vl_types.all;
entity TR_AUTO is
    generic(
        WIDTH_IN        : integer := 12;
        WIDTH_AUTO      : integer := 16
    );
    port(
        enable_AUTO     : out    vl_logic;
        dir_AUTO        : out    vl_logic;
        period_AUTO     : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_valid_TR   : in     vl_logic;
        tr_mode         : in     vl_logic;
        x_set           : in     vl_logic_vector;
        x               : in     vl_logic_vector;
        dx1             : in     vl_logic_vector;
        dx2             : in     vl_logic_vector;
        F1              : in     vl_logic_vector;
        F2              : in     vl_logic_vector;
        L               : in     vl_logic_vector;
        DZ_TR           : in     vl_logic_vector;
        k_TR            : in     vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH_IN : constant is 1;
    attribute mti_svvh_generic_type of WIDTH_AUTO : constant is 1;
end TR_AUTO;
