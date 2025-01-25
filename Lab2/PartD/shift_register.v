// Shift Register: module to )right) shift data into an 8-bit register
module shiftRegister (reset, clk, shiftEnable, data, Rx_sample_ENABLE, tempOut);

input reset, clk, shiftEnable, data, Rx_sample_ENABLE;

output reg [7:0] tempOut;                       // Temp register in which data will get shifted

always @(posedge clk or posedge reset) begin
    if (reset) tempOut <= 'b0;                  // Initialize tempOut to zero
    else if (shiftEnable && Rx_sample_ENABLE)
        tempOut <= {data, tempOut[7:1]};        // Shift the data one place to the right when shiftEnable is set to high
end

endmodule