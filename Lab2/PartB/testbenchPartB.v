`timescale 1ns/1ps
`define clock_period 10

module uart_transmmiter_tb;

reg clk, reset, Tx_WR, Tx_EN;
reg [2:0] baud_select;
reg [7:0] Tx_DATA;

//Instantiation of uart_transmmiter module
uart_transmitter uart_transmmiter_tb(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);

initial
    begin

       //$dumpfile("tb_dumpfile.vcd");
       //$dumpvars(0, uart_transmmiter_tb);
  

        clk = 1'b0;
        baud_select = 3'b111;
        Tx_DATA = 8'b10001001;
        #100 reset = 1'b1;
        #50 reset = 1'b0;
        Tx_EN = 1'b1;
        Tx_WR = 1'b1;
        #10 Tx_WR = 1'b0;
        #(10000000*`clock_period);
    end

//Generate clock
always  
   #(`clock_period / 2) clk = ~clk; 

endmodule