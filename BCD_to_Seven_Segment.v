module BCD_to_Seven_Segment( 
    input [3:0] hundreds,   // 4-bit BCD input for hundreds place
    input [3:0] tens,       // 4-bit BCD input for tens place
    input [3:0] ones,       // 4-bit BCD input for ones place
    output reg [6:0] seg_hundreds, // 7-segment display output for hundreds place
    output reg [6:0] seg_tens,     // 7-segment display output for tens place
    output reg [6:0] seg_ones      // 7-segment display output for ones place
);

    // Combinational logic for BCD to 7-segment decoding for hundreds, tens, and ones
    always @(*) begin
        // Decode hundreds place
        case (hundreds)
            4'b0000: seg_hundreds = 7'b1000000; // 0
            4'b0001: seg_hundreds = 7'b1111001; // 1
            4'b0010: seg_hundreds = 7'b0100100; // 2
            4'b0011: seg_hundreds = 7'b0110000; // 3
            4'b0100: seg_hundreds = 7'b0011001; // 4
            4'b0101: seg_hundreds = 7'b0010010; // 5
            4'b0110: seg_hundreds = 7'b0000010; // 6
            4'b0111: seg_hundreds = 7'b1111000; // 7
            4'b1000: seg_hundreds = 7'b0000000; // 8
            4'b1001: seg_hundreds = 7'b0010000; // 9
            default: seg_hundreds = 7'b1111111; // Invalid input (turn off all segments)
        endcase

        // Decode tens place
        case (tens)
            4'b0000: seg_tens = 7'b1000000; // 0
            4'b0001: seg_tens = 7'b1111001; // 1
            4'b0010: seg_tens = 7'b0100100; // 2
            4'b0011: seg_tens = 7'b0110000; // 3
            4'b0100: seg_tens = 7'b0011001; // 4
            4'b0101: seg_tens = 7'b0010010; // 5
            4'b0110: seg_tens = 7'b0000010; // 6
            4'b0111: seg_tens = 7'b1111000; // 7
            4'b1000: seg_tens = 7'b0000000; // 8
            4'b1001: seg_tens = 7'b0010000; // 9
            default: seg_tens = 7'b1111111; // Invalid input (turn off all segments)
        endcase

        // Decode ones place
        case (ones)
            4'b0000: seg_ones = 7'b1000000; // 0
            4'b0001: seg_ones = 7'b1111001; // 1
            4'b0010: seg_ones = 7'b0100100; // 2
            4'b0011: seg_ones = 7'b0110000; // 3
            4'b0100: seg_ones = 7'b0011001; // 4
            4'b0101: seg_ones = 7'b0010010; // 5
            4'b0110: seg_ones = 7'b0000010; // 6
            4'b0111: seg_ones = 7'b1111000; // 7
            4'b1000: seg_ones = 7'b0000000; // 8
            4'b1001: seg_ones = 7'b0010000; // 9
            default: seg_ones = 7'b1111111; // Invalid input (turn off all segments)
        endcase
    end

endmodule