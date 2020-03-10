//`include "rom4k.v"
//`include "cpu.v"

module hack_no_ram (
    input CLK,              // 16MHz clock
    input RST,              // reset button
    input [15:0] inM,       // data from memory
    output [15:0] outM,     // data to memory
    output [14:0] addressM, // memory address
    output writeM,          // memory write enable
    
    output [14:0] pc_d,
    output [15:0] instruction_d
);

    wire [14:0] pc;
    wire [15:0] instruction;
    
    ROM4K rom(pc, instruction);
    CPU cpu(CLK, inM, instruction, RST, outM, writeM, addressM, pc);
    
    // connect the internal signals to the debug signals
    assign pc_d = pc;
    assign instruction_d = instruction;
    
endmodule
