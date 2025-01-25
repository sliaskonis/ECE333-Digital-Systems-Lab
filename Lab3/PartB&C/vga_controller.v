`timescale 1ns/1ps
// VGA Driver
module vgacontroller(reset, clk, VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC);

input reset, clk;

output VGA_RED, VGA_GREEN, VGA_BLUE;
output VGA_HSYNC, VGA_VSYNC;

wire [6:0] HPIXEL;
wire [6:0] VPIXEL;
wire [2:0] pixelValue;
wire HPIXEL_counter_EN;
wire VPIXEL_counter_EN;
wire vsync_ENABLE;
wire [13:0]pixelAdress;

assign VGA_RED   = pixelValue[2];
assign VGA_GREEN = pixelValue[1];
assign VGA_BLUE  = pixelValue[0];

assign pixelAdress = {VPIXEL, HPIXEL};

// Instantiation of hsync_controller
hsync_controller hsync_controller_inst(reset, clk, VGA_HSYNC, HPIXEL_counter_EN);

// Instantiation of hpicel_counter
hpixel_counter hpixel_counter_inst(reset, clk, HPIXEL_counter_EN, HPIXEL);

// Instantiation of vsync_controller
vsync_controller vsync_controller_inst(reset, clk, VGA_VSYNC, VPIXEL_counter_EN);

// Instantiation vpixel_counter
vpixel_counter vpixel_counter_inst(reset, clk, VPIXEL_counter_EN, VPIXEL);

// Instantiation of vram
vram vram_inst(reset, clk, pixelAdress, pixelValue);
endmodule