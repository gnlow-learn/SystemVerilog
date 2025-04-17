module helloworld;
    initial begin
        $display("Hello, World!");
    end
endmodule

module example(
    input   logic a, b, c,
    output  logic y
);
    assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
endmodule
