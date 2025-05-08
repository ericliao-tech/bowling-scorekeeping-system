module binary_to_bcd_decoder ( 
    input [9:0] binary_input,   // 10-bit binary input
    output reg [3:0] hundreds,  // 4-bit BCD value for hundreds place
    output reg [3:0] tens,      // 4-bit BCD value for tens place
    output reg [3:0] ones       // 4-bit BCD value for ones place
);

    reg [11:0] binary_input_12bits;  // 12-bit extended binary input
    reg [23:0] shift_register;       // 24-bit shift register for Double Dabble
    integer i;

    always @(*) begin
        // Step 1: Extend binary_input to 12 bits by adding two leading zeros
        binary_input_12bits = {2'b00, binary_input};

        // Step 2: Initialize the shift register
        shift_register = {12'b0, binary_input_12bits}; // 12-bit BCD portion initialized to 0

        // Step 3: Perform Double Dabble algorithm
        for (i = 0; i < 12; i = i + 1) begin
            // If hundreds place in BCD >= 5, add 3
            if (shift_register[23:20] >= 5)
                shift_register[23:20] = shift_register[23:20] + 3;
            // If tens place in BCD >= 5, add 3
            if (shift_register[19:16] >= 5)
                shift_register[19:16] = shift_register[19:16] + 3;
            // If ones place in BCD >= 5, add 3
            if (shift_register[15:12] >= 5)
                shift_register[15:12] = shift_register[15:12] + 3;

            // Shift left by 1 bit to prepare for the next iteration
            shift_register = shift_register << 1;
        end

        // Step 4: Assign results to hundreds, tens, and ones
        hundreds = shift_register[23:20];
        tens = shift_register[19:16];
        ones = shift_register[15:12];
    end
endmodule


