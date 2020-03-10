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
    hack_dbg computer(clk, reset, kbd, display, pc, instruction, addressM, outM, writeM, inM);

    initial
        forever #1 clk = ~clk;

    // Main testbench code
    initial begin
        //$monitor($time, ": pc = %3d, instr = %b, inM = %x, outM = %x, addressM = %x, writeM = %b, kbd = %x, display = %x", 
        //    pc, instruction, inM, outM, addressM, writeM, kbd, display);
        $monitor($time, ": pc = %3d, instr = %b, inM = %x, outM = %x, addressM = %x, writeM = %b", 
            pc, instruction, inM, outM, addressM, writeM,);
        $dumpfile("hack_dbg.vcd");
        $dumpvars(0, hack_ram_tb);
        
        #2 reset <= 1;
        
        #2 reset <= 0; kbd <= 'h5678;
        #2 
        #2 
        #2 
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2 
        #2 
        #2 
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        #2         
        
        /*
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
        #2
                
        
        #2         
        #2         
        #2 
        #2        
        #2        
        #2        
        #2 inM <= 'h3456;        
        #2        
        #2 inM <= 'h4567;        
        #2        
        #2 inM <= 'h6789;        
        #2        
        #2 inM <= 'h7654;        
        #2        
        #2        

 
        #2        
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        //0000000000000000
        //1110101010000111
        #2        
        #2        
        */

           
        $finish;
    end

endmodule

