// WriteData: module to write data to memory
module writeData(reset, clk, Rx_VALID, tempOut, Rx_DATA);

input reset, clk;
input Rx_VALID;
input [7:0] tempOut;

output reg [7:0] Rx_DATA;

// Write data to register
always @(posedge clk or posedge reset) begin
    if (reset) Rx_DATA <= 'b0;                      // When reset is activated initialize data reg to zero
    else if (Rx_VALID) Rx_DATA <= tempOut;          // When Rx_VALID/Enable is set to 1 write data in the register
end


endmodule