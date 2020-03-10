// Force error when implicit net has no type.
`default_nettype none

module memory_tb;

    // Inputs
    reg clk = 1;
    reg [14:0] address = 0;
    reg [15:0] in = 0;
    reg load = 0;
    reg [15:0] kbd = 0;

    // Output
    wire [15:0] out;
    wire [15:0] display0;
    wire [15:0] display1;
    wire [15:0] display2;
    wire [15:0] display3;

    // Instantiate DUT (device under test)
    memory m(clk, address, in, load, kbd, out, display0, display1, display2, display3);

    initial
        forever #1 clk = ~clk;

    // Main testbench code
    initial begin
        $monitor($time, ": address = %x, in = %x, load = %b, kbd = %x, dsp0 = %x, dsp1 = %x, dsp2 = %x, dsp3 = %x, out = %x",   
            address, in, load, kbd, display0, display1, display2, display3, out);
        $dumpfile("memory.vcd");
        $dumpvars(0, memory_tb);

/*
        // write values to the ram
        #2 address <= 'h0000; in <= 'h0000; load <= 1; kbd <= 'h2340;
        #2 address <= 'h0001; in <= 'h1111; load <= 1; kbd <= 'h2341;
        #2 address <= 'h0002; in <= 'h2222; load <= 1; kbd <= 'h2342;
        #2 address <= 'h0003; in <= 'h3333; load <= 1; kbd <= 'h2343;
        #2 address <= 'h0004; in <= 'h4444; load <= 1; kbd <= 'h2344;
        #2 address <= 'h0005; in <= 'h5555; load <= 1; kbd <= 'h2345;
        #2 address <= 'h0006; in <= 'h6666; load <= 1; kbd <= 'h2346;
        #2 address <= 'h0007; in <= 'h7777; load <= 1; kbd <= 'h2347;
        #2 address <= 'h0008; in <= 'h8888; load <= 1; kbd <= 'h2348;
        #2 address <= 'h0009; in <= 'h9999; load <= 1; kbd <= 'h2349;
        
        // read back values from ram
        #2 address <= 'h0000; in <= 'hffff; load <= 0; kbd <= 'h2350;
        #2 address <= 'h0001; in <= 'hffff; load <= 0; kbd <= 'h2351;
        #2 address <= 'h0002; in <= 'hffff; load <= 0; kbd <= 'h2352;
        #2 address <= 'h0003; in <= 'hffff; load <= 0; kbd <= 'h2353;
        #2 address <= 'h0004; in <= 'hffff; load <= 0; kbd <= 'h2354;
        #2 address <= 'h0005; in <= 'hffff; load <= 0; kbd <= 'h2355;
        #2 address <= 'h0006; in <= 'hffff; load <= 0; kbd <= 'h2356;
        #2 address <= 'h0007; in <= 'hffff; load <= 0; kbd <= 'h2357;
        #2 address <= 'h0008; in <= 'hffff; load <= 0; kbd <= 'h2358;
        #2 address <= 'h0009; in <= 'hffff; load <= 0; kbd <= 'h2359;
        
        // reload address 0
        #2 address <= 'h0000; in <= 'h5555; load <= 1; kbd <= 'h2360;
        #2 address <= 'h0000; in <= 'hffff; load <= 0; kbd <= 'h2361;
*/
        // write to the display
        #2 address <= 'h4000; in <= 'h4567; load <= 1; kbd <= 'h2370;
        #2 address <= 'h4000; in <= 'hffff; load <= 0; kbd <= 'h2371;
        #2 address <= 'h4001; in <= 'h4568; load <= 1; kbd <= 'h2372;
        #2 address <= 'h4001; in <= 'hffff; load <= 0; kbd <= 'h2373;
        #2 address <= 'h4002; in <= 'h4569; load <= 1; kbd <= 'h2374;
        #2 address <= 'h4002; in <= 'hffff; load <= 0; kbd <= 'h2375;
        #2 address <= 'h4003; in <= 'h456a; load <= 1; kbd <= 'h2376;
        #2 address <= 'h4003; in <= 'hffff; load <= 0; kbd <= 'h2377;

        // read back values from the display
        #2 address <= 'h4000; in <= 'hffff; load <= 0; kbd <= 'h2380;
        #2 address <= 'h4001; in <= 'hffff; load <= 0; kbd <= 'h2382;
        #2 address <= 'h4002; in <= 'hffff; load <= 0; kbd <= 'h2384;
        #2 address <= 'h4003; in <= 'hffff; load <= 0; kbd <= 'h2386;
/*        
        // read from the kbd
        #2 address <= 'h6000; in <= 'hffff; load <= 0; kbd <= 'h2380;
        #2 address <= 'h6000; in <= 'hffff; load <= 0; kbd <= 'h2381;
        #2 address <= 'h6000; in <= 'hffff; load <= 0; kbd <= 'h2382;
*/        
        $finish;
    end

endmodule

