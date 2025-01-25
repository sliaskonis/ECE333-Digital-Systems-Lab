`timescale 1ns/1ps
`define clock_period 10 

///Part B - Testbench
module FourDigitLEDdriver_tb;
reg clk, reset;                 //Input signals

//Instantiation of top module
FourDigitLEDdriver FourDigitLEDdriver_test(reset, clk, an3, an2, an1, an0,
a, b, c, d, e, f, g, dp);

initial 
    begin
        clk = 1'b0;
        #100reset = 1'b1;
        #100 reset = 1'b0;
        $monitor("Anodes values: an3 = %b, an2 = %b, an1 = %b, an0 = %b\n", an3, an2, an1, an0);
    end

always  
   #(`clock_period / 2) clk = ~clk; 

endmodule
