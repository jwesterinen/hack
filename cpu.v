/**
 * The Hack CPU (Central Processing unit), consisting of an ALU,
 * two registers named A and D, and a program counter named PC.
 * The CPU is designed to fetch and execute instructions written in 
 * the Hack machine language. In particular, functions as follows:
 * Executes the inputted instruction according to the Hack machine 
 * language specification. The D and A in the language specification
 * refer to CPU-resident registers, while M refers to the external
 * memory location addressed by A, i.e. to Memory[A]. The inM input 
 * holds the value of this location. If the current instruction needs 
 * to write a value to M, the value is placed in outM, the address 
 * of the target location is placed in the addressM output, and the 
 * writeM control bit is asserted. (When writeM==0, any value may 
 * appear in outM). The outM and writeM outputs are combinational: 
 * they are affected instantaneously by the execution of the current 
 * instruction. The addressM and pc outputs are clocked: although they 
 * are affected by the execution of the current instruction, they commit 
 * to their new values only in the next time step. If reset==1 then the 
 * CPU jumps to address 0 (i.e. pc is set to 0 in next time step) rather 
 * than to the address resulting from executing the current instruction. 
 */

// commented out for the test bench but is needed by a top-level compilation
`include "alu.v"

module CPU (
    input CLK,
    input [15:0] inM,           // value from data memory
    input [15:0] instruction,   // instruction for execution
    input reset,                // re-start the current program (1) or continue execution (0)

    output [15:0] outM,         // value to write to data memory
    output writeM,              // data memory write enable 
    output [14:0] addressM,     // data memory address
    output [14:0] pc            // address of next instruction in instruction memory
);    

    reg [15:0] A;               // A register
    reg [15:0] D;               // D register
    reg [14:0] PC = 0;          // PC register
    wire [15:0] AM;             // second input to ALU either A-reg or value from data memory 
    wire [15:0] ALUoutput;      // results of the ALU computation (based on "a" and "c" instruction fields)
    wire isZero;                // from the ALU signifying the result is zero
    wire isNeg;                 // from the ALU signifying the result is negative (2's compliment)
    wire jumpNeg;         
    wire jumpZero;
    wire jumpPos;
    wire jump;                  // flag signaling that the PC needs to be loaded from the A-reg
    
    ALU alu(D, AM, instruction[11], instruction[10], instruction[9], instruction[8], 
        instruction[7], instruction[6], ALUoutput, isZero, isNeg);
    
    always @(posedge CLK) begin
    
        // instruction decoding -- pretty simple since there are only 2 opcodes        
        //   - A-instruction (op code 0)
        if (instruction[15] == 0) begin
            // load A with the instruction
            A <= instruction;
        end        
        //   - C-instruction (op code 1)
        else begin
            // load A with the ALU output if the "d1" bit in the instruction is set
            if (instruction[5]) begin
                A <= ALUoutput;
            end
            // load D with the ALU output if the "d2" bit in the instruction is set
            if (instruction[4]) begin
                D <= ALUoutput;
            end    
        end

        // the PC is set as follows:
        //   - set to 0 on reset 
        //   - set to the destination address in A reg on a jump
        //   - incremented if there is no jump
        if (reset) begin
            PC <= 0;
        end
        else if (jump) begin
            PC <= A;
        end
        else begin
            PC++;
        end
    end
    
    // instruction decoding
    //  - set the second input to the ALU based on the "a" bit in the instruction
    assign AM = (instruction[12] == 0) ? A : inM;
    
    // jump logic
    assign jumpNeg  = isNeg & instruction[2];
    assign jumpZero = isZero & instruction[1];
    assign jumpPos  = (~isZero & ~isNeg) & instruction[0];
    assign jump     = instruction[15] & (jumpNeg | jumpZero | jumpPos);
    
    // CPU outputs
    assign outM = ALUoutput;
    assign writeM = instruction[15] & instruction[3];
    assign addressM = A[14:0];
    assign pc = PC;

endmodule

