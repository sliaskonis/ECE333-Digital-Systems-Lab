`timescale 1ns/1ps
`define clock_period 10

module baud_controller_tb;

reg clk, reset;
reg [2:0]baud_select;
integer i;

//Instantiation of baud_controller module
baud_controller baud_controller_test(reset, clk, baud_select, sample_ENABLE);

initial
    begin

        //$dumpfile("tb_dumpfile.vcd");
        //$dumpvars(0, baud_controller_tb);
  

        clk = 1'b0;
        baud_select = 3'b111;
        #100 reset = 1'b1;
        #50 reset = 1'b0;
        #(100*`clock_period);
        $finish;
    end


//Generate clock
always  
   #(`clock_period / 2) clk = ~clk; 

endmodule