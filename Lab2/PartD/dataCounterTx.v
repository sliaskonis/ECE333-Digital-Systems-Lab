// DataCounterTx: module used to transfer data
module dataCounterTx(reset, clk, Tx_DATA, Tx_WR, Tx_EN, Tx_sample_ENABLE, count, parity, TxD, Tx_BUSY);

input reset, clk;
input [7:0] Tx_DATA;
input Tx_EN;                // Enable transmitter
input Tx_WR;                // Write data in register
input Tx_sample_ENABLE;
input [3:0] count;
input parity;

output reg TxD;
output reg Tx_BUSY;         // Transmitter busy

reg [3:0] currentState, nextState;
reg [7:0] Tx_DATA_mem;

//Coding of FSM's states
parameter [3:0] idleState  = 4'b0000,
                startBit   = 4'b0001,
                eighthBit  = 4'b0010,
                seventhBit = 4'b0011,
                sixthBit   = 4'b0100,
                fifthBit   = 4'b0101,
                fourthBit  = 4'b0110,
                thirdBit   = 4'b0111,
                secondBit  = 4'b1000,
                firstBit   = 4'b1001,
                parityBit  = 4'b1010,
                stopBit    = 4'b1011;

// Initialize memory with the data that will 
// get transimmited
always @(posedge clk or posedge reset) begin
    if (reset) Tx_DATA_mem <= 'b0;                          // Initialize data to zero
    else if (Tx_WR && !Tx_BUSY)                             // Write in the memory only when Tx_WR is active AND
        Tx_DATA_mem <= Tx_DATA;                             // Tx_BUSY is set to low, meaning that the transmitter is
end                                                         // is not busy 

// Control FSM states
always @(posedge clk or posedge reset) begin
    if (reset) currentState <= idleState;                   // Set fsm to idle state when reset is activated
    else if (count == 4'b1111 && Tx_sample_ENABLE) begin    // Change state after 16 Tx_sample_enable cycles
        currentState <= nextState;
    end
end

// Control FSM's next state and outputs
always @(Tx_EN or currentState) begin
    nextState = currentState;
    case(currentState)
    idleState: begin
        TxD = 1'b1;
        Tx_BUSY = 1'b0;
        if (Tx_EN) nextState = startBit;
    end
    startBit: begin
        TxD = 1'b0;                                // Start Bit
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = eighthBit;
    end
    eighthBit: begin
        TxD = Tx_DATA_mem[0];                      // Bit 7
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = seventhBit;
    end
    seventhBit: begin
        TxD = Tx_DATA_mem[1];                      // Bit 6
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = sixthBit;
    end
    sixthBit: begin
        TxD = Tx_DATA_mem[2];                      // Bit 5
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = fifthBit;
    end
    fifthBit: begin
        TxD = Tx_DATA_mem[3];                      // Bit 4
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = fourthBit;
    end
    fourthBit: begin
        TxD = Tx_DATA_mem[4];                      // Bit 3
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = thirdBit;
    end
    thirdBit: begin
        TxD = Tx_DATA_mem[5];                      // Bit 2
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = secondBit;
    end
    secondBit: begin
        TxD = Tx_DATA_mem[6];                      // Bit 1
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = firstBit;
    end
    firstBit: begin
        TxD = Tx_DATA_mem[7];                      // Bit 0
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = parityBit;
    end
    parityBit: begin
        TxD = parity;                              // Parity Bit
        Tx_BUSY = 1'b1;                            
        if (Tx_EN) nextState = stopBit;
    end
    stopBit: begin
        TxD = 1'b1;                                // Stop bit
        Tx_BUSY = 1'b1;
        if (Tx_EN) nextState = idleState;
    end
    default: begin
        TxD = 1'bx;
        Tx_BUSY = 1'b0;
        nextState = currentState;
    end 
    endcase
end

endmodule