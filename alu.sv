module alu(
    input  logic [31:0] a, b,
    input  logic [1:0]  ALUControl,
    output logic [31:0] Result,
    output logic [3:0]  ALUFlags
);
    logic [31:0] sum;
    logic cout, n, z, c, v;

    assign v =
        ~(ALUControl[0] ^ a[31] ^ b[31])
        & (a[31] ^ sum[31])
        & ~ALUControl[1];
    
    assign c = ~ALUControl[1] & cout;

    assign {cout, sum} =
        a
        + {1'b0, ALUControl[0] ? ~b : b}
        + ALUControl[0];

    always_comb begin
        case (ALUControl)
            2'b11: Result = a | b;
            2'b10: Result = a & b;
            default: Result = sum;
        endcase
    end

    assign n = Result[31];

    assign z = &(~Result);

    assign ALUFlags = {n, z, c, v};

endmodule
