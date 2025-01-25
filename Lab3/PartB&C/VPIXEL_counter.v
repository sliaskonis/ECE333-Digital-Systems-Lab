`timescale 1ns/1ps

// Vpixel_counter: module that controls the vertical value of a pixel.
// The output of this module is then used to indicate the address of 
// a pixel in the video RAM (VRAM).
// Pixel address will be given from {VPIXEL, HPIXEL}
module vpixel_counter(reset, clk, VPIXEL_counter_EN, VPIXEL);

input reset, clk;
input VPIXEL_counter_EN;        // Enable signal to start the counter

output reg [6:0] VPIXEL;        // VPIXEL value

reg [13:0] counter;
reg nextFrame;                  // nextFrame: used to increase VPIXEL value
reg resetCounter;

// Count 160.000ns, time in which we change the frame
// Send the same frame 5 times for 32000ns each time,
// scaling the resolution from 128x96 to 640:480 (96x5 = 480)
always @(posedge clk or posedge reset) begin
    if (reset) counter <= 'b0;
    else if (resetCounter) counter <= 'b0;
    else if (VPIXEL_counter_EN) counter <= counter + 14'd1;
end

always @(counter or VPIXEL_counter_EN) begin
    if (counter == 14'd15999) begin             // When counter counts 16000 clock cycles:
        nextFrame = 1'b1;                       // 1. Activate enable signal for next VPIXEL value (next row)
        resetCounter = 1'b1;                    // 2. Reset the counter
    end
    else begin
        nextFrame = 1'b0;
        resetCounter = 1'b0;
    end
end

// Pixel Counter
// VPIXEL values: 0-95
always @(posedge clk or posedge reset) begin
    if (reset) VPIXEL <= 'b0;
    else if (nextFrame) VPIXEL <= VPIXEL + 7'd1;
    else if (!VPIXEL_counter_EN) VPIXEL <= 'b0;
end

endmodule 