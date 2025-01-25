`timescale 1ns/1ps

// Hpixel_counter: module that controls the horizontal value of a pixel.
// The output of this module is then used to indicate the address of a
// pixel in the video RAM (VRAM).
// Pixel address will be given from {VPIXEL, HPIXEL}
module hpixel_counter(reset, clk, HPIXEL_counterEN, HPIXEL);

input reset, clk;
input HPIXEL_counterEN;         // Enable signal to start the counter

output reg [6:0] HPIXEL;        // HPIXEL value

reg [4:0] counter;
reg nextPixel;                  // nextPixel: used to increase the HPIXEL value
reg resetCount;

// Count 200ns, time in which we send each pixel. 
// Send the same pixel 5 times for 40ns each time,
// scaling the resolution from 128x96 to 640x480 (128x5 = 640)
always @(posedge clk or posedge reset) begin
    if (reset) counter <= 'b0;
    else if(resetCount) counter <= 'b0;
    else if (HPIXEL_counterEN) counter <= counter + 5'b00001; 
end

always @(counter or HPIXEL_counterEN) begin
    if (counter == 5'd19) begin                          // When counter counts 20 clock cycles:
        nextPixel = 1'b1;                                // 1. Activate enable signal for next pixel's address
        resetCount = 'b1;                                // 2. Reset the counter 
    end
    else  begin
        nextPixel = 1'b0;
        resetCount = 1'b0;
    end
end

// Pixel Counter
// HPIXEL values: 0-127
always @(posedge clk or posedge reset) begin
    if (reset) HPIXEL <= 'b0;                               
    else if (nextPixel) HPIXEL <= HPIXEL + 7'b0000001;      // Get the next pixel's address (0-127)
    else if (!HPIXEL_counterEN) HPIXEL <= 'b0;              // Once all the pixels have appeared, set HPIXEL
end                                                         // back to 0 for the next row


endmodule