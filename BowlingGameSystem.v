module BowlingGameSystem(
    input clk,
    input reset,
    input upd,                 // 更新信號
    input LF,                  // 最後一局標誌（未使用，可保留）
    input [3:0] N,             // 擊倒球瓶數量
    output [6:0] seg_hundreds, // 百位數的七段顯示器輸出
    output [6:0] seg_tens,     // 十位數的七段顯示器輸出
    output [6:0] seg_ones,     // 個位數的七段顯示器輸出
    output done,               // 遊戲結束標誌
    output [9:0] score         // *** 新增的輸出端口 ***
);

    // 內部連線訊號
    wire APD;                  // 全倒信號
    wire [3:0] hundreds, tens, ones; // BCD 輸出
    wire FT;                   // 從 bowling_score_system 獲取的 FT 信號
    wire NF;                   // 從 bowling_score_system 獲取的 NF 信號
    wire AD;                   // 從 bowling_score_system 獲取的 AD 信號

    // APD_logic 模組實例化
    APD_logic apd_inst (
        .N(N),
        .FT(FT),
        .APD(APD)
    );

    // bowling_score_system 模組實例化
    bowling_score_system score_system_inst (
        .score(score),
        .done(done),
        .FT(FT),
        .NF(NF),
        .AD(AD),
        .clk(clk),
        .reset(reset),
        .N(N),
        .APD(APD),
        .upd(upd),
        .LF(LF)
    );

    // binary_to_bcd_decoder 模組實例化
    binary_to_bcd_decoder bcd_decoder_inst (
        .binary_input(score),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones)
    );

    // BCD_to_Seven_Segment 模組實例化
    BCD_to_Seven_Segment seven_segment_inst (
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones),
        .seg_hundreds(seg_hundreds),
        .seg_tens(seg_tens),
        .seg_ones(seg_ones)
    );

endmodule
