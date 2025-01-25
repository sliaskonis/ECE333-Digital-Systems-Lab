// Sync an input signal with the clock using two flip-flops
module syncInput(clk ,signal, signalSync);

input clk, signal;

output reg signalSync;          // Synced signal

reg signalPrime;

always @(posedge clk) begin
    signalPrime <= signal;
    signalSync <= signalPrime;
end

endmodule