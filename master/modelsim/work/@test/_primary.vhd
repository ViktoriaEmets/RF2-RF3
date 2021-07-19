library verilog;
use verilog.vl_types.all;
entity Test is
    generic(
        F               : integer := 450
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of F : constant is 1;
end Test;
