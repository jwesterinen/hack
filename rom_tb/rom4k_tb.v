// Force error when implicit net has no type.
`default_nettype none

module rom4k_tb;

    // Inputs
    reg [14:0] address = 0;

    // Output
    wire [15:0] data;

    // Instantiate DUT (device under test)
    ROM4K ram(address, data);

    // Main testbench code
    initial begin
        $monitor($time, ": address = %x, data = %b", address, data);
        $dumpfile("rom4k.vcd");
        $dumpvars(0, rom4k_tb);

        // write values to the ram
        #1 address <= 'h0000;
        #1 address <= 'h0001;
        #1 address <= 'h0002;
        #1 address <= 'h0003;
        #1 address <= 'h0004;
        #1 address <= 'h0005;
        #1 address <= 'h0006;
        #1 address <= 'h0007;
        #1 address <= 'h0008;
        #1 address <= 'h0009;
        #1 address <= 'h000A;
        #1 address <= 'h000B;
        #1 address <= 'h000C;
        #1 address <= 'h000D;
        #1 address <= 'h000E;
        #1 address <= 'h000F;
        #1 address <= 'h0010;

        $finish;
    end

endmodule

