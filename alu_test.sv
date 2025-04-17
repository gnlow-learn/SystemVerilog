module alu_test;

    logic [31:0] a, b;
    logic [1:0] ALUControl;
    logic [31:0] Result;
    logic [3:0] ALUFlags;

    // ALU 인스턴스
    alu uut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .Result(Result),
        .ALUFlags(ALUFlags)
    );

    // 테스트 벤치 시작
    initial begin
        // Test 1: ADD
        a = 32'h00000007; b = 32'h00000001; ALUControl = 2'b00;
        #10;
        $display("Test 1: ADD");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 0, C: 0, V: 0)
        assert(ALUFlags == 4'b0000) else $fatal(1, "Test 1 failed");

        // Test 2: AND
        a = 32'h00000001; b = 32'h00000001; ALUControl = 2'b10;
        #10;
        $display("Test 2: AND");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 0, C: 0, V: 0)
        assert(ALUFlags == 4'b0000) else $fatal(1, "Test 2 failed");

        // Test 3: OR
        a = 32'h00000003; b = 32'h00000004; ALUControl = 2'b11;
        #10;
        $display("Test 3: OR");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 0, C: 0, V: 0)
        assert(ALUFlags == 4'b0000) else $fatal(1, "Test 3 failed");

        // Test 4: SUB (no overflow, no carry)
        a = 32'h00000010; b = 32'h00000005; ALUControl = 2'b01;
        #10;
        $display("Test 4: SUB");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 0, C: 1, V: 0)
        assert(ALUFlags == 4'b0010) else $fatal(1, "Test 4 failed");

        // Test 5: SUB (overflow)
        a = 32'h80000000; b = 32'h00000001; ALUControl = 2'b01;  // Overflow expected
        #10;
        $display("Test 5: SUB with Overflow");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 0, C: 1, V: 1)
        assert(ALUFlags == 4'b0011) else $fatal(1, "Test 5 failed");

        // Test 6: SUB (negative result)
        a = 32'h00000001; b = 32'h00000002; ALUControl = 2'b01;  // Negative result
        #10;
        $display("Test 6: SUB with Negative Result");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 1, Z: 0, C: 0, V: 0)
        assert(ALUFlags == 4'b1000) else $fatal(1, "Test 6 failed");

        // Test 7: SUB (zero result)
        a = 32'h00000002; b = 32'h00000002; ALUControl = 2'b01;  // Zero result
        #10;
        $display("Test 7: SUB with Zero Result");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 1, C: 1, V: 0)
        assert(ALUFlags == 4'b0110) else $fatal(1, "Test 7 failed");

        // Test 8: ADD (carry)
        a = 32'hffffffff; b = 32'h00000001; ALUControl = 2'b00;  // Carry expected
        #10;
        $display("Test 8: ADD with Carry");
        $display("At time %0t, Result = %h, ALUFlags = %b", $time, Result, ALUFlags);
        // Check NZCV (N: 0, Z: 1, C: 1, V: 0)
        assert(ALUFlags == 4'b0110) else $fatal(1, "Test 8 failed");

        $finish;
    end

endmodule
