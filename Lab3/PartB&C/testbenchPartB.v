`timescale 1ns/1ps
`define clock_period 10

module vgacontroller_tb;

reg clk, reset;

//Instantiation of uart_transmmiter module
vgacontroller vgacontroller_inst(reset, clk, VGA_RED, VGA_GREEN, VGA_BLUE, VGA_HSYNC, VGA_VSYNC);

initial
    begin

        //$dumpfile("tb_dumpfile.vcd");
        //$dumpvars(0, vgacontroller_tb);

        clk = 1'b0;
        reset = 1'b1;
        #200 reset = 1'b0;
        //#100000000 $finish;
    end

//Generate clock
always  
   #(`clock_period / 2) clk = ~clk; 

endmodule