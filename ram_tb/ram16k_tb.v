// Force error when implicit net has no type.
`default_nettype none

module ram16k_tb;

    // Inputs
    reg clk = 1;
    reg [14:0] address = 0;
    reg [15:0] in = 0;
    reg load = 0;

    // Output
    wire [15:0] out;

    // Instantiate DUT (device under test)
    RAM16K ram(clk, address, in, load, out);

    initial
        forever #1 clk = ~clk;

    // Main testbench code
    initial begin
        $monitor($time, ": address = %x, in = %x, load = %b, out = %x", address, in, load, out);
        $dumpfile("ram16k.vcd");
        $dumpvars(0, ram16k_tb);

        // write values to the ram
        #2 address <= 'h0000; in <= 'h0000; load <= 1;
        #2 address <= 'h0001; in <= 'h1111; load <= 1;
        #2 address <= 'h0002; in <= 'h2222; load <= 1;
        #2 address <= 'h0003; in <= 'h3333; load <= 1;
        #2 address <= 'h0004; in <= 'h4444; load <= 1;
        #2 address <= 'h0005; in <= 'h5555; load <= 1;
        #2 address <= 'h0006; in <= 'h6666; load <= 1;
        #2 address <= 'h0007; in <= 'h7777; load <= 1;
        #2 address <= 'h0008; in <= 'h8888; load <= 1;
        #2 address <= 'h0009; in <= 'h9999; load <= 1;
        
        // read back values
        #2 address <= 'h0000; in <= 'hffff; load <= 0;
        #2 address <= 'h0001; in <= 'hffff; load <= 0;
        #2 address <= 'h0002; in <= 'hffff; load <= 0;
        #2 address <= 'h0003; in <= 'hffff; load <= 0;
        #2 address <= 'h0004; in <= 'hffff; load <= 0;
        #2 address <= 'h0005; in <= 'hffff; load <= 0;
        #2 address <= 'h0006; in <= 'hffff; load <= 0;
        #2 address <= 'h0007; in <= 'hffff; load <= 0;
        #2 address <= 'h0008; in <= 'hffff; load <= 0;
        #2 address <= 'h0009; in <= 'hffff; load <= 0;
        
        #2 address <= 'h0000; in <= 'h5555; load <= 1;
        #2 address <= 'h0000; in <= 'hffff; load <= 0;
        
        // address 16K + 1
        #2 address <= 'h4000; in <= 'hffff; load <= 0;
        

        $finish;
    end

endmodule

