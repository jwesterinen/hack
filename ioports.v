module ioports (
    input CLK,
    input dataIn,
    input ledLoad,
    input gpioDir,
    input gpioLoad,
    output LED,
    //inout GPIO,
    input GPIO,
    output dataOut
);
    // FIXME: iverilog has a bug that prevents the use of inout ports 
    // I/O port buffers
    reg ledDataBuf;         // latch for the on-board LED data
    //reg gpioDirBuf;         // latch for the GPIO pin direction (0=in, 1=out)
    //reg gpioDataBuf;        // latch for the GPIO output data

    always @(posedge CLK) begin
        if (ledLoad) begin
            ledDataBuf <= dataIn;
        end
        /*
        if (gpioDir) begin
            gpioDirBuf <= dataIn;
        end
        if (gpioLoad) begin
            gpioDataBuf <= dataIn;
        end
        */
    end
    
    assign LED = ledDataBuf;
    //assign GPIO = (gpioDirBuf == 1) ? gpioDataBuf : 1'bz;  // let GPIO float to read the external signal
    assign dataOut = GPIO;
    
endmodule
