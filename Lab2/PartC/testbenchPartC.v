`timescale 1ns/1ps
`define clock_period 10

module uart_receiver_tb;

reg clk, reset, Rx_EN, RxD;
reg [2:0] baud_select;
wire [7:0] Rx_DATA;

//Instantiation of uart_transmmiter module
uart_receiver uart_receiver_tb(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID);

initial
    begin

        //$dumpfile("tb_dumpfile.vcd");
        //$dumpvars(0, uart_receiver_tb);
  

        clk = 1'b0;
        baud_select = 3'b111;
        RxD = 1'b1;
        reset = 1'b1;
        Rx_EN = 1'b1;
        #10 reset = 1'b0;
        #8790 RxD=0;
        #8800 RxD=0;
        #8800 RxD=1;
        #8800 RxD=0;
        #8800 RxD=1;
        #8800 RxD=0;
        #8800 RxD=1;
        #8800 RxD=0;
        #8800 RxD=1;
        #8800 RxD=0;
        #8800 RxD=1;
        #(1000000*`clock_period);
    end

//Generate clock
always  
   #(`clock_period / 2) clk = ~clk; 

endmodule