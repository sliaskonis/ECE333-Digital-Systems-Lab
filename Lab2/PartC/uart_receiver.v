// UART Receiver
module uart_receiver(reset, clk, Rx_DATA, baud_select, Rx_EN, RxD, Rx_FERROR, Rx_PERROR, Rx_VALID);

input reset, clk;
input [2:0] baud_select;
input Rx_EN;
input RxD;

output [7:0] Rx_DATA;
output Rx_FERROR;                       // Framing error
output Rx_PERROR;                       // Parity error    
output Rx_VALID;                        // Rx_Data is valid

wire [7:0] tempOut;
wire shiftEnable;
wire parity;                            
wire RxD_sync;                          // Synced RxD input

// Instantiation of baud_controller responsible for providing the transmmiter with a given baud rate
baud_controller baud_controller_rx_inst(reset, clk, baud_select, Rx_sample_ENABLE);

// Instantiation of syncInput responsible for providing the receiver with a synchronous RxD input
syncInput syncInput_rx_inst(clk, RxD, RxD_sync);

// Instantiation of dataCounter responsible for samping the data received  
dataCounter dataCounter_rx_inst(reset, clk, Rx_sample_ENABLE, Rx_EN, RxD_sync, parity, Rx_FERROR, Rx_PERROR, Rx_VALID, shiftEnable);

// Instantiation of shiftRegister responsible for shifting each bit received by one place to the right 
shiftRegister shiftRegister_rx_inst(reset, clk, shiftEnable, RxD_sync, Rx_sample_ENABLE, tempOut);

// Instantiation of checkPairty responsible for checking an 8 bit value for even parity
checkParity checkParity_rx_inst(tempOut, parity);

// Instantiation of writeData 
writeData writeData_inst(reset, clk, Rx_VALID, tempOut, Rx_DATA);

endmodule