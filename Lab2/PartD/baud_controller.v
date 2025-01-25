// Baud Controller: module used for providing the right sampling signal 
// according to a chosen baud rate

module baud_controller(reset, clk, baud_select, sample_ENABLE);

input reset, clk;
input [2:0]baud_select;                     // Signal used to choose the correct baud rate
output reg sample_ENABLE;                   // Sampling signal 
reg [14:0]count;
wire [14:0]countNext;

assign countNext = count + 15'b000000000000001;

// 15-bit counter with asynchronus reset.
// Counter's highest value is controlled by baud_select.
// Whenever counter reaches it's highest value count is then 
// set to 0 and sample enable to 1 for one clock period providing
// us with the baud rate chosen from baud_select
always @(posedge clk or posedge reset)
begin
    if (reset) begin                                            // Initialize count and sample_enable
        count <= 'b0;                                           // to 0 when reset signal is activated
        sample_ENABLE <= 1'b0;
    end
    else begin
        case(baud_select)                                       // Control counter according to baud_select
            3'b000: begin                                       
                if (count == 15'b101000101100001) begin         // Each if-else statement in each case checks if count
                    count <= 'b0;                               // has reached its highest value. If yes it resets counter
                    sample_ENABLE <= 1'b1;                      // else it assigns counter its next value
                end
                else begin 
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b001: begin
                if (count == 15'b001010001011000) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b010: begin
                if (count == 15'b000010100010110) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b011: begin
                if (count == 15'b000001010001011) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin 
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b100: begin 
                if (count == 15'b000000101000110) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b101: begin
                if (count == 15'b000000010100011) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin 
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b110: begin
                if (count == 15'b000000001101101) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end
            end
            3'b111: begin 
                if (count == 15'b000000000110110) begin
                    count <= 'b0;
                    sample_ENABLE <= 1'b1;
                end
                else begin
                    count <= countNext;
                    sample_ENABLE <= 1'b0;
                end 
            end
        endcase 
    end
end

endmodule
