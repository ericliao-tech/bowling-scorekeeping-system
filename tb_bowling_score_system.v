module tb_bowling_score_system;

    reg clk;
    reg reset;
    reg [3:0] N;
    reg upd;
    reg LF;
    wire [9:0] score;
    wire done;
    wire FT;
    wire NF;
    wire AD;
    wire APD;

    // Instantiate the bowling_score_system module
    bowling_score_system uut (
        .clk(clk),
        .reset(reset),
        .N(N),
        .APD(APD),
        .upd(upd),
        .LF(LF),
        .score(score),
        .done(done),
        .FT(FT),
        .NF(NF),
        .AD(AD)
    );

    // Instantiate the APD_logic module
    APD_logic apd_logic_inst (
        .N(N),
        .FT(FT),
        .APD(APD)
    );

    // Generate clock signal
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_bowling_score_system.vcd");
        $dumpvars(0, tb_bowling_score_system);

        // Initialize inputs
        clk = 0;
        reset = 1;
        N = 0;
        upd = 0;
        LF = 0;
        #10;

        // Release reset
        reset = 0;

        // Test Case 1: Frame 1 - Strike
        upd = 1; N = 10; #10; upd = 0; #10;

        // Test Case 2: Frame 2 - Spare (4 + 6)
        upd = 1; N = 4; #10; upd = 0; #10;
        upd = 1; N = 6; #10; upd = 0; #10;

        // Test Case 3: Frame 3 - Normal (3 + 4)
        upd = 1; N = 3; #10; upd = 0; #10;
        upd = 1; N = 4; #10; upd = 0; #10;

        // Test Case 4: Frame 4 - Strike
        upd = 1; N = 10; #10; upd = 0; #10;

        // Test Case 5: Frame 5 - Normal (5 + 2)
        upd = 1; N = 5; #10; upd = 0; #10;
        upd = 1; N = 2; #10; upd = 0; #10;

        // Test Case 6: Frame 6 - Spare (6 + 4)
        upd = 1; N = 6; #10; upd = 0; #10;
        upd = 1; N = 4; #10; upd = 0; #10;

        // Test Case 7: Frame 7 - Strike
        upd = 1; N = 10; #10; upd = 0; #10;

        // Test Case 8: Frame 8 - Strike
        upd = 1; N = 10; #10; upd = 0; #10;

        // Test Case 9: Frame 9 - Normal (2 + 7)
        upd = 1; N = 2; #10; upd = 0; #10;
        upd = 1; N = 7; #10; upd = 0; #10;

        // Test Case 10: Frame 10 - Strike + Bonus Throws
        upd = 1; N = 10; #10; upd = 0; #10;
        upd = 1; N = 10; #10; upd = 0; #10;
        upd = 1; N = 10; #10; upd = 0; #10;

        // Finish simulation
        #50;
        $finish;
    end

endmodule

module APD_logic(
    input [3:0] N, // 當前投球擊倒的球瓶數
    input FT,
    output APD                       // 全部擊倒信號
);

    // 當 N 等於 10（全部球瓶數）時，apd 置為 1，否則為 0
    assign APD = (N == 4'd10) ? 1'b1 : 1'b0;

endmodule
