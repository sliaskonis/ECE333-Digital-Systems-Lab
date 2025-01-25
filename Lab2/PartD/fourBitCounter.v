// 4-Bit Counter: a 4-bit counter with enable signal
module fourBitCounter(reset, clk, enable, count);

input reset, clk, enable;

output reg [3:0] count;

wire [3:0] countNext;

assign countNext = count + 4'b0001;

// Control counter's value
always @(posedge clk or posedge reset) begin
    if (reset) count <= 4'b0000;                    // When reset is activate set counter to zero
    else if (enable) count <= countNext;            // Else when enable is set to high assign counter
end                                                 // its next value

endmodule