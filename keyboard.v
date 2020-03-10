`include "keypad.v"

module keyboard (
    input CLK,
    output COL1,    // keypad column 1
    output COL2,    // keypad column 2
    output COL3,    // keypad column 3
    output COL4,    // keypad column 4
    input ROW1,     // keypad row 1
    input ROW2,     // keypad row 2
    input ROW3,     // keypad row 3
    input ROW4,     // keypad row 4
    output [15:0] keyboardData
);
    reg [4:0] keycode;

    // 4x4 keypad
    keypad k(CLK, {ROW4,ROW3,ROW2,ROW1}, {COL1,COL4,COL3,COL2}, keycode);
    
    assign keyboardData[15:5] = 0;
    assign keyboardData[4:0] = keycode;
    
endmodule

