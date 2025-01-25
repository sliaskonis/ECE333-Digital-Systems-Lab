`timescale 1ns/1ps
`define clock_period 10 

module FourDigitLEDdriver_tb;
reg clk, reset, shift_button;                  //Input signals

//Instantiation of top module
FourDigitLEDdriver FourDigitLEDdriver_test(reset, clk, shift_button, an3, an2, an1, an0,
a, b, c, d, e, f, g, dp);

initial 
    begin
        clk = 1'b0;                             //Start clock
        reset = 1'b1;                           //Initialize circuit
        #100 reset = 1'b0;
        shift_button = 1'b0;                    //Keep the button on and off for 3000 time units
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
        #3000;
        shift_button = 1'b1;
        #3000;
        shift_button = 1'b0;
    end

always  
   #(`clock_period / 2) clk = ~clk; 

endmodule
