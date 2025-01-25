// UART Transmitter
module uart_transmitter(reset, clk, Tx_DATA, baud_select, Tx_WR, Tx_EN, TxD, Tx_BUSY);

input reset, clk;
input [7:0]Tx_DATA;
input [2:0]baud_select;
input Tx_EN;
input Tx_WR;

output TxD;
output Tx_BUSY;

wire [3:0] count;

// Instantiation of baud_controller responsible for providing the transmmiter with a given baud rate
baud_controller baud_controller_tx_inst(reset, clk, baud_select, Tx_sample_ENABLE);

// Instantiation of a 4-bit Counter
fourBitCounter fourBitCounter_inst(reset, clk, Tx_sample_ENABLE, count);

// Instantiation of dataCounterTx responsible driving the TxD according to the Tx_DAta (the data we want to transmit)
dataCounterTx dataCounterTx_inst(reset, clk, Tx_DATA, Tx_WR, Tx_EN, Tx_sample_ENABLE, count, parity, TxD, Tx_BUSY);

// Instantiation of checkPairty responsible for checking an 8 bit value for even parity
checkParity checkParity_tx_inst(Tx_DATA, parity);

endmodule