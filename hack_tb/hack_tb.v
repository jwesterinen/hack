// Force error when implicit net has no type.
`default_nettype none

module hack_tb;

    // Inputs
    reg clk = 1;
    reg reset = 0;
    reg [15:0] kbd = 0;

    // Output
    //wire [15:0] display [4];
    wire A;
    wire B;
    wire C;
    wire D;
    wire E;
    wire F;
    wire G;
    wire H;
    wire I;
    wire DP;
    wire CC1;
    wire CC2;
    wire CC3;
    wire CC4;
    wire led;
    wire usbpu;

    integer i;
    
    // Instantiate DUT (device under test)
    //hack computer(clk, reset, kbd, display[0], display[1], display[2], display[3], led, usbpu);
    hack computer(clk, reset, kbd, A, B, C, D, E, F, G, H, I, DP, CC1, CC2, CC3, CC4, led, usbpu);

    initial
        forever #1 clk = ~clk;

    // Main testbench code
    initial begin
//        $monitor($time, ": kbd = %h, display0 = %h, display1 = %h, display2 = %h, display3 = %h", 
//            kbd, display[0], display[1], display[2], display[3]);
        $monitor($time, ": kbd = %h, A=%b, B=%b, C=%b, D=%b, E=%b, F=%b, G=%b, H=%b, I=%b, DP=%b, CC1=%b, CC2=%b, CC3=%b, CC4=%b", 
            kbd, A, B, C, D, E, F, G, H, I, DP, CC1, CC2, CC3, CC4);
        $dumpfile("hack.vcd");
        $dumpvars(0, hack_tb);

        #2 reset <= 1;        
        #2 reset <= 0;
        
        for (i=0; i<30; i=i+1) begin
            //if (i % 6 == 0) begin
            //    if (kbd == 0) begin
            //        kbd <= i;
            //    end
            //    else begin                
            //        kbd <= 0;
            //    end
            //end
            #2;
        end
                
        #2 $finish;
    end

endmodule

