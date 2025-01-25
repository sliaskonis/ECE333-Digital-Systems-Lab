`timescale 1ns/1ps
`define clock_period 10

module uart_tb;

reg clk, reset, Tx_WR, Tx_EN, Rx_EN;
reg [2:0] baud_select;
reg [7:0] data;

//Instantiation of uart module
uart uart_inst(reset, clk, data, baud_select, Tx_EN, Tx_WR, Rx_EN);

initial
    begin

        //$dumpfile("tb_dumpfile.vcd");
        //$dumpvars(0, uart_tb);

        clk = 1'b0;
        reset = 1'b1;
        baud_select = 3'b111;
        #10 reset = 1'b0;
        data = 8'b10001001;
        Tx_WR = 1'b1;
        #10 Tx_WR = 1'b0;
        Tx_EN = 1'b1;
        Rx_EN = 1'b1;
        wait(uart_tb.uart_inst.uart_transmitter_inst.Tx_BUSY == 1'b0 && uart_tb.uart_inst.uart_receiver_inst.Rx_VALID)
            data = 8'b11001100;
            Tx_WR = 1'b1;
            #11 Tx_WR = 1'b0;
        wait(uart_tb.uart_inst.uart_transmitter_inst.Tx_BUSY == 1'b1)
        wait(uart_tb.uart_inst.uart_transmitter_inst.Tx_BUSY == 1'b0 && uart_tb.uart_inst.uart_receiver_inst.Rx_VALID)
            data = 8'b01010101;
            Tx_WR = 1'b1;
            #11 Tx_WR = 1'b0;
        wait(uart_tb.uart_inst.uart_transmitter_inst.Tx_BUSY == 1'b1)
        wait(uart_tb.uart_inst.uart_transmitter_inst.Tx_BUSY == 1'b0 && uart_tb.uart_inst.uart_receiver_inst.Rx_VALID)
            data = 8'b10101010;
            Tx_WR = 1'b1;
            #11 Tx_WR = 1'b0;
    end

//Generate clock
always  
   #(`clock_period / 2) clk = ~clk; 

endmodule