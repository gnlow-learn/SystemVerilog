module sillyfunction(
    input logic a, b, c,
    output logic y
);
    assign y = ~b & ~c | a & ~b;
endmodule

module testbench1();
    logic a, b, c;
    logic y;
    sillyfunction dut(a, b, c, y);
    initial begin
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench1);
    end
    initial begin
        a=0; b=0; c=0; #10;
        c=1; #10;
        b=1; c=0; #10;
    end
endmodule

