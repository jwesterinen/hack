//`include "rom4k.v"
//`include "cpu.v"
//`include "memory.v"
//`include "ram16k.v"

module hack_dbg (
    input CLK,                      // 16MHz clock
    input RST,                      // reset button
    input [15:0] KBD,               // keyboard value
    output [15:0] DISPLAY,          // display value
    output [14:0] pc_d,             // PC
    output [15:0] instruction_d,    // instruction from ROM
    output [14:0] addressM_d,       // memory address
    output [15:0] outM_d,           // data to memory
    output writeM_d,                // memory write enable
    output [15:0] inM_d             // data from memory
    
);
    // module interconnections
    wire [14:0] pc;
    wire [15:0] instruction;
    wire [14:0] addressM;
    wire [15:0] outM;
    wire writeM;
    wire [15:0] inM;

    ROM4K rom(pc, instruction);
    CPU cpu(CLK, inM, instruction, RST, outM, writeM, addressM, pc);
    memory mem(CLK, addressM, outM, writeM, KBD, inM, DISPLAY);
    
    // connect the internal signals to the debug signals
    assign pc_d = pc;
    assign instruction_d = instruction;
    assign addressM_d = addressM;
    assign outM_d = outM;
    assign writeM_d = writeM; 
    assign inM_d = inM;
    
endmodule
