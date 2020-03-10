/******************************************************************************
*
*   DL-4509 Common cathode four 9-segment display with decimal point
*  
*   Pin Description:
* 
*             A                                 DL-4509
*          -------           ----------------------------------------------
*         |   |   |         |           ---    ---    ---    ---           |
*       F |   | H | B       |          | | |  | | |  | | |  | | |          |
*         |   |   |         |           ---    ---    ---    ---           |
*           ----- G         |          | | |  | | |  | | |  | | |          |
*         |   |   |         |           --- .  --- .  --- .  --- .         |
*       E |   | I | C       |            4      3      2      1            |
*         |   |   |          ----------------------------------------------
*           -----   .         |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
*             D     DP        1  2  3  4  5  6  7  8  9  NC 10 11 12 13 14
*                                                 pins
*        pin  1 - segment F
*        pin  2 - segment H
*        pin  3 - segment D
*        pin  4 - segment E
*        pin  5 - DP
*        pin  6 - CC4
*        pin  7 - CC3
*        pin  8 - CC2
*        pin  9 - CC1
*        pin 10 - segment A
*        pin 11 - segment G
*        pin 12 - segment B
*        pin 13 - segment C
*        pin 14 - segment I
*
*   Character codes:
*       0x00-0x0F : '0'-'F'
*       0x10      : '-'
*       0x11      : '+'
*       0x12      : <all off>
*
******************************************************************************/

module dl4509 (
    input CLK,              // 16MHz clock
    input [4:0] value4,     // hextet 4 (MS)
    input [4:0] value3,     // hextet 3
    input [4:0] value2,     // hextet 2
    input [4:0] value1,     // hextet 1 (LS)
    input [3:0] dps,        // decimal points 4,3,2,1 respectively
    output A,               // segment A
    output B,               // segment B
    output C,               // segment C
    output D,               // segment D
    output E,               // segment E
    output F,               // segment F
    output G,               // segment G
    output H,               // segment H
    output I,               // segment I
    output DP,              // decimal point
    output CC1,             // enable display 1 (LS)
    output CC2,             // enable display 2
    output CC3,             // enable display 3
    output CC4              // enable display 4 (MS)
);

    // display patterns for hex numerals
    //                           _+-FEDCBA9876543210
    wire [18:0] pattern_A =  19'b0001101011111101101;
    wire [18:0] pattern_B =  19'b0000010011110011111;
    wire [18:0] pattern_C =  19'b0000010111111111011;
    wire [18:0] pattern_D =  19'b0000111100101101101;
    wire [18:0] pattern_E =  19'b0001111110101000101;
    wire [18:0] pattern_F =  19'b0001101111101110001;
    wire [18:0] pattern_G =  19'b0111110111101111100;
    wire [18:0] pattern_H =  19'b0100000000000000000;
    wire [18:0] pattern_I =  19'b0100000000000000000;

    // scale the input clock to ~2ms
    wire CLK_2MS;
    prescaler #(.N(15)) ps2(CLK, CLK_2MS);
    
    // current display
    reg [1:0] state = 0;
    reg [4:0] index;
    reg dp;
        
    // display the correct hextet during each state
    always @(posedge CLK_2MS) begin
    //always @(posedge CLK) begin
        state++;
        case (state)
            0:          // display 1
            begin
                index <= value1;
                dp <= dps[0];
            end
            1:          // display 2
            begin
                index <= value2;
                dp <= dps[1];
            end
            2:          // display 3
            begin
                index <= value3;
                dp <= dps[2];
            end
            3:          // display 4
            begin
                index <= value4;
                dp <= dps[3];
            end
        endcase
    end
    
    // light up the segments according to the pattern
    assign A = pattern_A[index];
    assign B = pattern_B[index];
    assign C = pattern_C[index];
    assign D = pattern_D[index];
    assign E = pattern_E[index];
    assign F = pattern_F[index];
    assign G = pattern_G[index];
    assign H = pattern_H[index];
    assign I = pattern_I[index];
    assign DP = dp;
    
    // display enablers, e.g. common cathodes
    assign CC1 = ~(state == 0);
    assign CC2 = ~(state == 1);
    assign CC3 = ~(state == 2);
    assign CC4 = ~(state == 3);
    
endmodule
