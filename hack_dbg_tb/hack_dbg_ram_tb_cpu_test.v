// Force error when implicit net has no type.
`default_nettype none

module hack_ram_tb;

    // Inputs
    reg clk = 1;
    reg reset = 0;
    reg [15:0] kbd = 0;

    // Output
    wire [15:0] inM;
    wire [15:0] outM;
    wire [14:0] addressM;
    wire writeM;
    wire [15:0] display;
    wire led;
    wire usbpu;
    
    // debug signals
    wire [14:0] pc;
    wire [15:0] instruction;

    // Instantiate DUT (device under test)
    hack_ram cpu(clk, reset, kbd, display, pc, instruction, addressM, outM, writeM, inM);

    initial
        forever #1 clk = ~clk;

    // Main testbench code
    initial begin
        $monitor($time, ": pc = %d, instruction = %b, inM = %x, outM = %x, addressM = %x, writeM = %b", 
            pc, instruction, inM, outM, addressM, writeM);
        $dumpfile("hack_ram.vcd");
        $dumpvars(0, hack_ram_tb);
        
        // reset the CPU
        #2 reset = 1;

        // test computation
        
        // @2345
        #2 reset = 0;
        // D=A
        #2 
        // @1234
        #2 
        // M=0  ; write 0      
        #2 
        // M=1  ; write 1
        #2         
        // M=-1 ; write ffff
        #2         
        // M=D  ; write 2345        
        #2         
        // M=A  ; write 1234        
        #2         
        // M=!D ; write dcba        
        #2         
        // M=!A ; write edcb        
        #2         
        // M=-D ; write dcbb        
        #2         
        // M=-A ; write edcc      
        #2         
        // M=D+1 ; write 2346        
        #2         
        // M=A+1 ; write 1235        
        #2         
        // M=D-1 ; write 2344        
        #2         
        // M=A-1 ; write 1233        
        #2         
        // M=D+A ; write 3579        
        #2         
        // M=D-A ; write 1111        
        #2         
        // M=A-D ; write eeef     
        #2         
        // M=D&A ; write 0204        
        #2         
        // M=D|A ; write 3375     
        #2
        
        // M=A      ; write 1234
        #2
        // M=!M
        #2
        // M=-M
        #2
        // M=M+1
        #2
        // M=M-1
        #2
        // M=D+M
        #2
        // M=D-M
        #2
        // M=M-D
        #2
        // M=D&M
        #2
        // M=D|M
        #2
                
        /*
        // test destinations
        
        // @0005
        #2         
        // M=1  ; write 1 to 5
        #2         
        // D=0
        #2 
        // M=D  ; write 0 to 5
        #2        
        // MD=1 ; write 1 to 5
        #2        
        // M=D  ; write 1 to 5
        #2        
        // A=M
        #2 inM <= 'h3456;        
        // M=A  ; write 3456 to 3456
        #2        
        // AM=M ; write 4567 to 3456
        #2 inM <= 'h4567;        
        // M=A  ; write 4567 to 4567
        #2        
        // AD=M
        #2 inM <= 'h6789;        
        // M=D  ; write 6789 to 6789
        #2        
        // AMD=M ; write 7654 to 6789
        #2 inM <= 'h7654;        
        // M=A+1 ; write 7655 to 7654
        #2        
        // M=-D ; write 89ac to 7654
        #2        

        // test jumping
 
        // 002E: D=-1
        #2        
        // 002F: @33
        #2        
        // 0030: D;JLT
        #2        
        // 0031: @0
        //0000000000000000
        // 0032: 0;JMP
        //1110101010000111
        // 0033: @37
        #2        
        // 0034: D;JLE        
        #2        
        // 0035: @0
        //0000000000000000
        // 0036: 0;JMP
        //1110101010000111
        // 0037: D=0
        #2        
        // 0038: @3C
        #2        
        // 0039: D;JEQ
        #2        
        // 003A: @0
        //0000000000000000
        // 003B 0;JMP
        //1110101010000111
        // 003C: @40
        #2        
        // 003D: D;JGE
        #2        
        // 003E: @0
        //0000000000000000
        // 003F: 0;JMP
        //1110101010000111
        // 0040: @44
        #2        
        // 0041: D;JLE        
        #2        
        // 0042: @0
        //0000000000000000
        // 0043: 0;JMP
        //1110101010000111
        // 0044: D=1
        #2        
        // 0045: @49
        #2        
        // 0046: D;JGT
        #2        
        // 0047: @0
        //0000000000000000
        // 0048: 0;JMP
        //1110101010000111
        // 0049: @4D
        #2        
        // 004A: D;JGE
        #2        
        // 004B: @0
        //0000000000000000
        // 004C: 0;JMP
        //1110101010000111
        // 004D: @51
        #2        
        // 004E: D;JNE
        #2        
        // 004F: @0
        //0000000000000000
        // 0050: 0;JMP
        //1110101010000111
        // 0051: @55
        #2        
        // 0052: 0;JMP
        #2        
        // 0053: @0
        //0000000000000000
        // 0054: 0;JMP
        //1110101010000111
        // 0055: @7654
        #2        
        // 0056: M=A
        #2        
        */

           
        $finish;
    end

endmodule

