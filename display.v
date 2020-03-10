`include "dl4509.v"

module display (
    input CLK,
    input [1:0] address,
    input [15:0] dataIn,
    input load,
    output A,
    output B,
    output C,
    output D,
    output E,
    output F,
    output G,
    output H,
    output I,
    output DP,
    output CC1,
    output CC2,
    output CC3,
    output CC4,
    output [15:0] dataOut
);
    // frame buffer -- 0 (LS), 1, 2, 3 (MS), 4 (DPs)
    reg [15:0] framebuf [5];

    // 4 x 7-segment display
    dl4509 display(CLK, framebuf[3][4:0], framebuf[2][4:0], framebuf[1][4:0], framebuf[0][4:0], framebuf[4][3:0], A, B, C, D, E, F, G, H, I, DP, CC1, CC2, CC3, CC4);
    
    always @(posedge CLK) begin
        if (load) begin
            framebuf[address] <= dataIn;
        end
    end
    
    assign dataOut = framebuf[address];
    
endmodule
