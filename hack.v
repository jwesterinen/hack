/**
 * The HACK computer, including CPU, ROM and RAM.
 * When reset is 0, the program stored in the computer's ROM executes.
 * When reset is 1, the execution of the program restarts. 
 * Thus, to start a program's execution, reset must be pushed "up" (1)
 * and "down" (0). From this point onward the user is at the mercy of 
 * the software. In particular, depending on the program's code, the 
 * screen may show some output and the user may be able to interact 
 * with the computer via the keyboard.
 */

`include "rom.v"
`include "cpu.v"
`include "memory.v"

module hack (
    input CLK,          // 16MHz clock
    input RST,          // reset button
    output A,           // segment A
    output B,           // segment B
    output C,           // segment C
    output D,           // segment D
    output E,           // segment E
    output F,           // segment F
    output G,           // segment G
    output H,           // segment H
    output I,           // segment I
    output DP,          // decimal point
    output CC1,         // enable display 1 (LS)
    output CC2,         // enable display 2
    output CC3,         // enable display 3
    output CC4,         // enable display 4 (MS)
    output COL1,        // keypad column 1
    output COL2,        // keypad column 2
    output COL3,        // keypad column 3
    output COL4,        // keypad column 4
    input ROW1,         // keypad row 1
    input ROW2,         // keypad row 2
    input ROW3,         // keypad row 3
    input ROW4,         // keypad row 4
    output LED,         // LED
    //inout GPIO,         // I/O data pin
    input GPIO,         // I/O data pin
    output USBPU        // USB pull-up resistor
);
    // module interconnections
    wire [14:0] pc;
    wire [15:0] instruction;
    wire [14:0] addressM;
    wire [15:0] outM;
    wire writeM;
    wire [15:0] inM;
    
    ROM #(.ROM_DEPTH(8192)) rom8k(pc, instruction);
    CPU cpu(CLK, inM, instruction, RST, outM, writeM, addressM, pc);
    memory mem(CLK, addressM, outM, writeM, inM, 
        COL1, COL2, COL3, COL4, ROW1, ROW2, ROW3, ROW4,
        A, B, C, D, E, F, G, H, I, DP, CC1, CC2, CC3, CC4,
        LED, GPIO
    );

    // TEST: switch connected to GPIO
    //assign GPIO = RST;
        
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;
    
endmodule
