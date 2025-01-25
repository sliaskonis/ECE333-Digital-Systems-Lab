`timescale 1ns/1ps
`define clock_period 10 

//Part D - Testbench
module FourDigitLEDdriver_tb;
reg clk, reset;                     //Input signals

///Instantiation of top level module
FourDigitLEDdriver FourDigitLEDdriver_test(reset, clk, an3, an2, an1, an0,
a, b, c, d, e, f, g, dp);

initial 
    begin
        clk = 1'b0;                 //Start the clock
        reset = 1'b1;               //Initialize circuit
        #100 reset = 1'b0;
    end

always  
   #(`clock_period / 2) clk = ~clk; //Generate clock

endmodule
