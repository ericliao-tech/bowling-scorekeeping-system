module tb_BowlingGameSystem;

    reg clk;
    reg reset;
    reg upd;
    reg LF;
    reg [3:0] N;
    wire [6:0] seg_hundreds;
    wire [6:0] seg_tens;
    wire [6:0] seg_ones;
    wire done;
    wire [9:0] score;
    wire FT;    // 从待测模块获取 FT 信号

    // 实例化待测模块
    BowlingGameSystem uut (
        .clk(clk),
        .reset(reset),
        .upd(upd),
        .LF(LF),
        .N(N),
        .seg_hundreds(seg_hundreds),
        .seg_tens(seg_tens),
        .seg_ones(seg_ones),
        .done(done),
        .score(score)
    );

    // 时钟生成器
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 时钟周期为 10 个时间单位
    end

    // 测试序列
    initial begin
        // 初始化
        reset = 1;
        upd = 0;
        LF = 0;
        N = 0;
        #20;
        reset = 0;

        // 等待一段时间，确保系统稳定
        #10;

        // 按照您提供的测试用例依次输入

        // Test Case 1: Frame 1 - Strike
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;

        // Test Case 2: Frame 2 - Spare (4 + 6)
        upd = 1; N = 4; #10; upd = 0; N = 0; #10;
        upd = 1; N = 6; #10; upd = 0; N = 0; #10;

        // Test Case 3: Frame 3 - Normal (3 + 4)
        upd = 1; N = 3; #10; upd = 0; N = 0; #10;
        upd = 1; N = 4; #10; upd = 0; N = 0; #10;

        // Test Case 4: Frame 4 - Strike
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;

        // Test Case 5: Frame 5 - Normal (5 + 2)
        upd = 1; N = 5; #10; upd = 0; N = 0; #10;
        upd = 1; N = 2; #10; upd = 0; N = 0; #10;

        // Test Case 6: Frame 6 - Spare (6 + 4)
        upd = 1; N = 6; #10; upd = 0; N = 0; #10;
        upd = 1; N = 4; #10; upd = 0; N = 0; #10;

        // Test Case 7: Frame 7 - Strike
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;

        // Test Case 8: Frame 8 - Strike
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;

        // Test Case 9: Frame 9 - Normal (2 + 7)
        upd = 1; N = 2; #10; upd = 0; N = 0; #10;
        upd = 1; N = 7; #10; upd = 0; N = 0; #10;

        // Test Case 10: Frame 10 - Strike + Bonus Throws
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;
        // Bonus Throws
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;
        upd = 1; N = 10; #10; upd = 0; N = 0; #10;

        // 测试结束
        #100;
        $finish;
    end

    // 监视输出
    initial begin
        $monitor("Time=%0t, Frame=%0d, N=%0d, Score=%0d, done=%b", 
                 $time, uut.score_system_inst.frame_counter + 1, N, score, done);
    end

endmodule
