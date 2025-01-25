// Universal Asynchronous Transmitter Receiver
module uart(reset, clk, data, baud_select, Tx_EN, Tx_WR, Rx_EN);

input reset, clk;
input [2:0] baud_select;
input [7:0] data;               // Data to get transmitter/received
input Tx_EN;                    // Transmitter activated
input Tx_WR;
input Rx_EN;                    // Receiver Activated

wire data_wire;                 // Wire connecting the two modules, allowing for serial transfer of data
wire [7:0] Rx_DATA;             // Data received


// Instantiation of the uart_transimitter module 
uart_transmitter uart_transmitter_inst(reset, clk, data, baud_select, Tx_WR, Tx_EN, data_wire, Tx_BUSY);

// Instantiation of the uart_receiver module 
uart_receiver uart_receiver_inst(reset, clk, Rx_DATA, baud_select, Rx_EN, data_wire, Rx_FERROR, Rx_PERROR, Rx_VALID);

endmodule