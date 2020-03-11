module ioports (
    input  CLK,             // 16MHz clock
    input  dataIn,          // system data input bus
    input  ledLoad,         // load signal for the LED
    input  gpioDir,         // direction (in/out) of the GPIO pin
    input  gpioLoad,        // load signal for the GPIO pion
    output LED,             // on-board LED
    output gpioOutEn,       // set to 1 to write to the gpio pin  
    output gpioOutSig,      // data written to gpio pin
    input  gpioInSig,       // data read from gpio pin
    output dataOut          // system data output bus
);
    reg ledDataBuf;         // latch for the on-board LED data
    reg gpioDirBuf;         // latch for the GPIO pin direction (0=in, 1=out)
    reg gpioDataBuf;        // latch for the GPIO output data

    always @(posedge CLK) begin
        if (ledLoad) begin
            ledDataBuf <= dataIn;
        end
        if (gpioDir) begin
            gpioDirBuf <= dataIn;
        end
        if (gpioLoad) begin
            gpioDataBuf <= dataIn;
        end
    end
    
    assign LED = ledDataBuf;
    assign gpioOutEn = gpioDirBuf;
    assign gpioOutSig = gpioDataBuf;
    assign dataOut = gpioInSig;
    
endmodule
