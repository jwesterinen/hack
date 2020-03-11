`include "ram.v"
`include "keyboard.v"
`include "display.v"
`include "prescaler.v"
`include "ioports.v"

module memory (
    input  CLK,
    input  [14:0] address,
    input  [15:0] dataIn,
    input  load,
    output [15:0] dataOut,

    // keypad connections
    output COL1,        // keypad column 1
    output COL2,        // keypad column 2
    output COL3,        // keypad column 3
    output COL4,        // keypad column 4
    input  ROW1,        // keypad row 1
    input  ROW2,        // keypad row 2
    input  ROW3,        // keypad row 3
    input  ROW4,        // keypad row 4
    
    // display connections
    output A,           // segments A-I on the output device
    output B,
    output C,
    output D,
    output E,
    output F,
    output G,
    output H,
    output I,
    output DP,          // decimal point segment on the output device
    output CC1,         // common cathodes for the 4 displays
    output CC2,
    output CC3,
    output CC4,
    
    // I/O ports
    output LED,         // on-board LED
    output gpioOutEn,   // set to 1 to write to the gpio pin  
    output gpioOutSig,  // data written to gpio pin
    input  gpioInSig    // data read from gpio pin
);
    wire ramLoad;       // decoded load signals for the members of the memory map
    wire displayLoad;
    wire ledLoad;
    wire gpioLoad;
    wire gpioDir;       // rd/wr signal for the GPIO pin
    wire [15:0] ramData;        // individual data buses for the members of the memory map
    wire [15:0] displayData;
    wire [15:0] keyboardData;
    wire [15:0] gpioData;

    RAM #(.MEM_DEPTH(8192)) ram8k(CLK, address[12:0], dataIn, ramLoad, ramData);
    display screen(CLK, address[1:0], dataIn, displayLoad, A, B, C, D, E, F, G, H, I, DP, CC1, CC2, CC3, CC4, displayData);
    keyboard kbd(CLK, COL1, COL2, COL3, COL4, ROW1, ROW2, ROW3, ROW4, keyboardData);
    ioports gpio(CLK, dataIn[0], ledLoad, gpioDir, gpioLoad, LED, gpioOutEn, gpioOutSig, gpioInSig, gpioData[0]);

    // write to RAM for address < 0x4000
    assign ramLoad = (address < 16'h4000) ? load : 0;
    
    // write to display at address 0x4000-0x4003
    assign displayLoad = (address >= 16'h4000 && address <= 16'h4003) ? load : 0;
    
    // write LED data at address 0x7000                     
    assign ledLoad = (address == 16'h7000) ? load : 0;
    
    // write GPIO data at address 0x7001                     
    assign gpioLoad = (address == 16'h7001) ? load : 0;
    
    // write GPIO direction at address 0x7002 (0=in, 1=out)                    
    assign gpioDir = (address == 16'h7002) ? load : 0;
    
    // read memory map elements as follows:
    //   RAM:       address 0x0000-0x1fff
    //   display:   address 0x4000-0x5fff
    //   keyboard:  address 0x6000
    //   GPIO:      address 0x7001 
    assign dataOut = (address >= 16'h0000 && address < 16'h2000) ? ramData :
                     (address >= 16'h4000 && address <= 16'h4003) ? displayData :
                     (address == 16'h6000) ? keyboardData : 
                     (address == 16'h7001) ? gpioData : 0;
           
endmodule
