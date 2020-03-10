// Force error when implicit net has no type.
`default_nettype none

module cpu_tb;

    // Inputs
    reg clk = 1;
    reg [15:0] inM = 0;
    reg [15:0] instruction = 0;
    reg reset = 0;

    // Output
    wire [15:0] outM;
    wire writeM;
    wire [14:0] addressM;
    wire [14:0] pc;

    // Instantiate DUT (device under test)
    CPU cpu_inst(clk, inM, instruction, reset, outM, writeM, addressM, pc);

    initial
        forever #1 clk = ~clk;

    // Main testbench code
    initial begin
        $monitor($time, ": input = %x, instruction = %b, output = %x, addr = %x, WR = %b, PC = %x", 
            inM, instruction, outM, addressM, writeM, pc);
        $dumpfile("cpu.vcd");
        $dumpvars(0, cpu_tb);

        // reset
        #2 reset <= 1;


        // test computation
        
        // @2345
        #2 instruction <= 'b0_010_0011_0100_0101; reset <= 0;
        // D=A
        #2 inM <= 'h2345; instruction <= 'b111_0_110000_010_000;
        // @1234
        #2 instruction <= 'b0_001_0010_0011_0100;
        
        // M=0  ; write 0      
        #2 instruction <= 'b111_0_101010_001_000;
        
        // M=1  ; write 1
        #2 instruction <= 'b111_0_111111_001_000;
        
        // M=-1 ; write ffff
        #2 instruction <= 'b111_0_111010_001_000;
        
        // M=D  ; write 2345        
        #2 instruction <= 'b111_0_001100_001_000;
        
        // M=A  ; write 1234        
        #2 instruction <= 'b111_0_110000_001_000;
        
        // M=!D ; write dcba        
        #2 instruction <= 'b111_0_001101_001_000;
        
        // M=!A ; write edcb        
        #2 instruction <= 'b111_0_110001_001_000;
        
        // M=-D ; write dcbb        
        #2 instruction <= 'b111_0_001111_001_000;
        
        // M=-A ; write edcc      
        #2 instruction <= 'b111_0_110011_001_000;
        
        // M=D+1 ; write 2346        
        #2 instruction <= 'b111_0_011111_001_000;
        
        // M=A+1 ; write 1235        
        #2 instruction <= 'b111_0_110111_001_000;
        
        // M=D-1 ; write 2344        
        #2 instruction <= 'b111_0_001110_001_000;
        
        // M=A-1 ; write 1233        
        #2 instruction <= 'b111_0_110010_001_000;
        
        // M=D+A ; write 3579        
        #2 instruction <= 'b111_0_000010_001_000;
        
        // M=D-A ; write 1111        
        #2 instruction <= 'b111_0_010011_001_000;
        
        // M=A-D ; write eeef     
        #2 instruction <= 'b111_0_000111_001_000;
        
        // M=D&A ; write 0204        
        #2 instruction <= 'b111_0_000000_001_000;
        
        // M=D|A ; write 3375     
        #2 instruction <= 'b111_0_010101_001_000;
        
        // M=M  ; write 0000        
        #2 inM <= 'h0000; instruction <= 'b111_1_110000_001_000;
        
        // M=!M ; write ffff      
        #2 inM <= 'h0000; instruction <= 'b111_1_110001_001_000;

        // M=-M ; write ffff        
        #2 inM <= 'h0001; instruction <= 'b111_1_110011_001_000;

        // M=M+1 ; write 2        
        #2 inM <= 'h0001; instruction <= 'b111_1_110111_001_000;

        // M=M-1 ; write 1        
        #2 inM <= 'h0002; instruction <= 'b111_1_110010_001_000;

        // M=D+M ; write 2346    
        #2 inM <= 'h0001; instruction <= 'b111_1_000010_001_000;

        // M=D-M ; write 1111
        #2 inM <= 'h1234; instruction <= 'b111_1_010011_001_000;

        // M=M-D ; write 1        
        #2 inM <= 'h2346; instruction <= 'b111_1_000111_001_000;

        // M=D&M ; write 2300     
        #2 inM <= 'h2300; instruction <= 'b111_1_000000_001_000;

        // M=D|M ; write 7777     
        #2 inM <= 'h5432; instruction <= 'b111_1_010101_001_000;

                
        // test destinations
        
        // @0005
        #2 instruction <= 'b0_000_0000_0000_0101;
        
        // M=1  ; write 1 to 5
        #2 instruction <= 'b111_0_111111_001_000;
        
        // D=0
        #2 instruction <= 'b111_0_101010_010_000;
        // M=D  ; write 0 to 5
        #2 instruction <= 'b111_0_001100_001_000;
        
        // MD=1 ; write 1 to 5
        #2 instruction <= 'b111_0_111111_011_000;        
        // M=D  ; write 1 to 5
        #2 instruction <= 'b111_0_001100_001_000;
        
        // A=M
        #2 inM <= 'h3456; instruction <= 'b111_1_110000_100_000;        
        // M=A  ; write 3456 to 3456
        #2 instruction <= 'b111_0_110000_001_000;
        
        // AM=M ; write 4567 to 3456
        #2 inM <= 'h4567; instruction <= 'b111_1_110000_101_000;
        
        // M=A  ; write 4567 to 4567
        #2 instruction <= 'b111_0_110000_001_000;
        
        // AD=M
        #2 inM <= 'h6789; instruction <= 'b111_1_110000_110_000;        
        // M=D  ; write 6789 to 6789
        #2 instruction <= 'b111_0_001100_001_000;
        
        // AMD=M ; write 7654 to 6789
        #2 inM <= 'h7654; instruction <= 'b111_1_110000_111_000;
        
        // M=A+1 ; write 7655 to 7654
        #2 instruction <= 'b111_0_110111_001_000;
        
        // M=-D ; write 89ac to 7654
        #2 instruction <= 'b111_0_001111_001_000;
        

        // test jumping
 
        // D=-1
        #2 inM <= 'h0000; instruction <= 'b111_0_111010_010_000;
        
        // @100
        #2 instruction <= 'b0_000_0001_0000_0000;
        // D;JLT
        #2 instruction <= 'b111_0_001100_000_100;
        
        // @200 ; PC=100
        #2 instruction <= 'b0_000_0010_0000_0000;
        // D;JLE        
        #2 instruction <= 'b111_0_001100_000_110;

        // D=0  ; PC=200
        #2 instruction <= 'b111_0_101010_010_000;

        // @300
        #2 instruction <= 'b0_000_0011_0000_0000;
        // D;JEQ
        #2 instruction <= 'b111_0_001100_000_010;
        
        // @400 ; PC=300
        #2 instruction <= 'b0_000_0100_0000_0000;
        // D;JGE
        #2 instruction <= 'b111_0_001100_000_011;
        
        // @500 ; PC=400
        #2 instruction <= 'b0_000_0101_0000_0000;
        // D;JLE        
        #2 instruction <= 'b111_0_001100_000_110;

        // D=1 ; PC=500
        #2 instruction <= 'b111_0_111111_010_000;
        
        // @600
        #2 instruction <= 'b0_000_0110_0000_0000;        
        // D;JGT
        #2 instruction <= 'b111_0_001100_000_001;
        
        // @700 ; PC=600
        #2 instruction <= 'b0_000_0111_0000_0000;        
        // D;JGE
        #2 instruction <= 'b111_0_001100_000_011;
        
        // @800 ; PC=700
        #2 instruction <= 'b0_000_1000_0000_0000;        
        // D;JNE
        #2 instruction <= 'b111_0_001100_000_101;
        
        // @900 ; PC=800
        #2 instruction <= 'b0_000_1001_0000_0000;
        // 0;JMP
        #2 instruction <= 'b111_0_101010_000_111;
        // @1000 ; PC=900
        #2 instruction <= 'b0_001_0000_0000_0000;
           
        $finish;
    end

endmodule

