// Force error when implicit net has no type.
`default_nettype none

module alu_tb;

    // Inputs
    reg [15:0] x;
    reg [15:0] y;
    reg zx;
    reg nx;
    reg zy;
    reg ny;
    reg f;
    reg no;

    // Output
    wire [15:0] ALUoutput;
    wire isZero;
    wire isNeg;

    // Instantiate DUT (device under test)
    ALU alu_inst(x, y, zx, nx, zy, ny, f, no, ALUoutput, isZero, isNeg);

    // Main testbench code
    initial begin
        $monitor($time, "x = %x, y = %x, zx = %b, nx = %b, zy = %b, ny = %b, f = %b, no = %b, ALUoutput = %x, isZero = %b, isNeg = %b", 
            x, y, zx, nx, zy, ny, f, no, ALUoutput, isZero, isNeg);
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // 1: Compute 0
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 1; nx <= 0; zy <= 1; ny <= 0; f <= 1; no <= 0;

        // 2: Compute 1
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 1; nx <= 1; zy <= 1; ny <= 1; f <= 1; no <= 1;

        // 3: Compute -1
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 1; nx <= 1; zy <= 1; ny <= 0; f <= 1; no <= 0;

        // 4: Compute x
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 0; nx <= 0; zy <= 1; ny <= 1; f <= 0; no <= 0;

        // 5: Compute y
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 1; nx <= 1; zy <= 0; ny <= 0; f <= 0; no <= 0;

        // 6: Compute !x
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 0; nx <= 0; zy <= 1; ny <= 1; f <= 0; no <= 1;

        // 7: Compute !y
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 1; nx <= 1; zy <= 0; ny <= 0; f <= 0; no <= 1;

        // 8: Compute -x
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 0; nx <= 0; zy <= 1; ny <= 1; f <= 1; no <= 1;

        // 9: Compute -y
        #1 x <= 'b1010101010101010; y <= 'b0101010101010101; zx <= 1; nx <= 1; zy <= 0; ny <= 0; f <= 1; no <= 1;

        // 10: Compute x+1
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 0; nx <= 1; zy <= 1; ny <= 1; f <= 1; no <= 1;

        // 11: Compute y+1
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 1; nx <= 1; zy <= 0; ny <= 1; f <= 1; no <= 1;

        // 12: Compute x-1
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 0; nx <= 0; zy <= 1; ny <= 1; f <= 1; no <= 0;

        // 13: Compute y-1
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 1; nx <= 1; zy <= 0; ny <= 0; f <= 1; no <= 0;

        // 14: Compute x+y
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 0; nx <= 0; zy <= 0; ny <= 0; f <= 1; no <= 0;

        // 15: Compute x-y
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 0; nx <= 1; zy <= 0; ny <= 0; f <= 1; no <= 1;

        // 16: Compute y-x
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 0; nx <= 0; zy <= 0; ny <= 1; f <= 1; no <= 1;

        // 17: Compute x&y
        #1 x <= 'b0000000000001111; y <= 'b0000000011111000; zx <= 0; nx <= 0; zy <= 0; ny <= 0; f <= 0; no <= 0;

        // 18: Compute x|y
        #1 x <= 'b0000000000001111; y <= 'b0000000011110000; zx <= 0; nx <= 1; zy <= 0; ny <= 1; f <= 0; no <= 1;

        #1 $finish;
    end

endmodule

