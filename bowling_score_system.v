module bowling_score_system(
    input clk,
    input reset,                // 重置信號
    input [3:0] N,              // 擊倒球瓶數量
    input APD,                  // 擊倒所有球瓶，會是以下兩種情況Strike 或 Spare。
    input upd,
    input LF,                   // 更新信號
    output reg [9:0] score,
    output reg done,
    output reg FT,
    output reg NF,
    output reg AD
);
// 狀態定義
  localparam normal = 2'b00;
  localparam extra_frame = 2'b01;
  localparam over = 2'b11;

    reg [1:0] state;            // 當前狀態
    reg [1:0] score_type;            // 追縱特定情況, score_type= 0:strike, score_type= 1:spare, score_type= 2:一般加法

    reg [3:0] frame_counter;            // 當前局數
    reg [3:0] previous_pins_number;       // 儲存上一顆球(任意局第一球)的球數, 可用於判斷spare

    reg [1:0] bonus_throws;      // 因為strike、spare 而獲得的額外投球次數。
    reg [1:0] bonus_strike_count;    // 用來處理因為連續strike 所產生的, 額外(或假的第11局)加分機制(一球或兩球)。
  
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= normal;
        frame_counter <= 4'd0;//追蹤局數
        bonus_throws <= 2'd0;
        done <= 0;
        score <= 10'd0;
        previous_pins_number <= 4'd0;
        bonus_strike_count <= 2'd0;
        FT <= 0;//當 FT = 0 表示正在進行該局的第一投, 當 FT = 1 表示正在進行該局的第二投。
        AD <= 0;
        NF <= 0;
    end 
    else if (upd) begin
        AD <= 1;
        case (state)
            normal: begin//1~10
                if (APD &&!FT) begin
                    score_type <= 0;//strike
                    
                    //檢查之前是否有未處理的額外得分（來自之前的 Strike 或 Spare）
                    if(bonus_throws > 0) begin

                        // 檢查有無連續的 strike
                        if(bonus_strike_count >0) begin
                            score <= score + 10 + 20;
                            bonus_strike_count <= bonus_throws -1;
                        end
                        else begin
                            bonus_strike_count <= bonus_throws-1;
                            score <= score + 10 + 10;
                        end
                    end else begin
                        // 在這局之前, 沒有額外加分
                        score <= score + 10;
                    end

                    // 剛剛打出strike, 設定bonus=2
                    bonus_throws <= 2;
                    previous_pins_number <= 0;
                    if (frame_counter == 4'd9) begin
                        state <= extra_frame;//額外局, 第11局
                    end else begin
                        state <= normal;
                        frame_counter <= frame_counter + 1;
                        NF <= 1;
                        FT <= 0;
                    end
                end 
                else if (N + previous_pins_number == 10) begin //是spare, N(此刻被擊倒的), previous_pins_number(上一次被擊倒的)
                    score_type <= 1;//代表是spare
                    if(bonus_throws > 0)begin
                        score <= score + N*2;//本局+之前需要的加分
                    end else begin
                        score <= score + N;
                    end
                   
                    bonus_throws <= 1;
                    if (frame_counter == 4'd9) begin
                        state <= extra_frame;//額外局
                    end else begin
                        state <= normal;//一般局
                        frame_counter <= frame_counter + 1;
                        NF <= 1;
                        previous_pins_number <= 0;
                        FT <= 0;
                    end
                end 
                else begin
                    score_type <= 2;//代表不是spike也不是spare
                    if(!FT) begin
                        previous_pins_number <= N;
                    end
                    else begin//second throw have been done, turn on to the next frame
                        previous_pins_number <= 0;
                    end

                    if (bonus_throws > 0) begin
                        if(bonus_strike_count > 0) begin
                            score <= score + N * 3;//一次為本次投球的得分, 兩次為連續stirke造成的bonus
                            bonus_throws <= bonus_throws - 1;
                            bonus_strike_count <= 0;
                        end
                        else begin
                            score <= score + N * 2;
                            bonus_throws <= bonus_throws - 1;
                        end
                    end else begin
                        score <= score + N;
                    end

                    //第 10 局, second throw
                    //在不是第 10 局, 且second throw丟完後，進入下一局
                    if (frame_counter == 4'd9 && FT) begin
                        state <= over;//設定程結束
                        done <= 1;
                    end else if(FT) begin
                        state <= normal;
                        frame_counter <= frame_counter + 1;
                        NF <= 1;
                    end
                    FT <= ~FT;//被取反, 第一投和第二投之間切換訊號表示
                end
            end
            extra_frame: begin//after frame 9(begin with o)
                if (bonus_throws > 0) begin
                    if(bonus_strike_count > 0) begin
                        score <= score + N * 2;//two strike
                        bonus_throws <= bonus_throws - 1;
                        bonus_strike_count <= 0;
                    end
                    else begin
                        score <= score + N;
                        bonus_throws <= bonus_throws - 1;
                    end
                end 
                else begin
                    state <= over;
                end
                
            end
            over: begin//Over
                done <= 1;
            end

        endcase
    end
    else begin
        AD <= 0;
    end
end
endmodule