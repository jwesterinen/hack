module RAM #(
    parameter DATA_WIDTH = 16,
    parameter ADDR_WIDTH = 13,
    parameter MEM_DEPTH = 8192
) (
    input CLK,
    input [ADDR_WIDTH-1:0] address,
    input [DATA_WIDTH-1:0] dataIn,
    input load,
    output [DATA_WIDTH-1:0] dataOut
);
    reg [DATA_WIDTH-1:0] ram [0:MEM_DEPTH-1];

    always @(posedge CLK) begin
        if (load) begin
            ram[address] <= dataIn;
        end
    end
    
    assign dataOut = ram[address];
    
endmodule
