`timescale 1ns/1ps
`define clock_period 10

module vram_tb;

reg clk, reset;
reg [13:0] address;
wire [2:0] pixelValue;
//Instantiation of VRAM module
vram vram_inst(reset, clk, address, pixelValue);


initial
    begin
        clk = 1'b0;
        #50 reset = 1'b1;
        #200 reset = 1'b0;
        address = 6144;
        #100000000 $finish;
    end

//Generate clock
always  
   #(`clock_period / 2) clk = ~clk; 

endmodule