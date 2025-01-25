// Data counter: module resposible for reading the data received 
// 
module dataCounter (reset, clk, Rx_sample_ENABLE, Rx_EN, RxD, parity, Rx_FERROR, Rx_PERROR, Rx_VALID, shiftEnable);

input reset, clk;
input Rx_sample_ENABLE;
input Rx_EN;
input RxD;
input parity;

output reg Rx_FERROR;               // Framing ERROR
output reg Rx_PERROR;               // Parity ERROR
output reg Rx_VALID;                // Rx_DATA is valid
output reg shiftEnable;             // Shift data sampled into a register

reg [3:0] count, currentState, nextState;
reg countEnable, countAligned;

wire counterEN;
wire [3:0] countNext;

// Coding of the FSM's states
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

assign countNext = count + 4'b0001;

// Controll FSM's current state
always @(posedge clk or posedge reset) begin 
    if (reset) currentState <= idleState;
    else if (Rx_sample_ENABLE)
        currentState <= nextState;
end

// Counter enable
assign counterEN = Rx_sample_ENABLE && countEnable;

// 4-bit Counter
// Controll counter's values
always @(posedge clk or posedge reset) begin
    if (reset) count <= 4'b0000;                                                // When reset is activated initialize counter to zero 
    else if (countAligned && Rx_sample_ENABLE) count <= 4'b0000;                // When countAligned is set to 1, set counter back to zero 
    else if (counterEN) count <= countNext;                                     // Increase counter by 1 when counterEN is set to one
end

// Controll FSM's next state and outputs
always @(Rx_EN or RxD or count or currentState) begin
    nextState = currentState;
    shiftEnable = 1'b0;
    countAligned = 1'b0;
    Rx_FERROR    = 1'b0;
    Rx_PERROR    = 1'b0;
    case(currentState)
    idleState: begin
        Rx_FERROR    = 1'b0;
        Rx_PERROR    = 1'b0;
        countAligned = 1'b0;
        countEnable  = 1'b0;
        if (Rx_VALID) Rx_VALID = 1'b1;                                          // If Rx_VALID is 1 then keep it 1 until the next start bit arrives
        if (RxD == 1'b0 && Rx_EN) begin
            nextState   = startBit;
            Rx_VALID = 1'b0;
            countEnable = 1'b1;                                                 // Start the counter 
        end
    end
    startBit: begin 
        if (RxD) begin
            nextState = idleState;
            Rx_FERROR = 1'b1;
        end
        else if (count == 4'b0111 && Rx_EN) begin
            nextState    = eighthBit;
            countAligned = 1'b1;                                                // Set counter back to 0 and align sampling at
        end                                                                     // at the middle of the start bit
    end
    eighthBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable  = 1'b1;
            nextState    = seventhBit;
        end
    end
    seventhBit: begin 
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = sixthBit;
        end
    end
    sixthBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = fifthBit;
        end
    end
    fifthBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = fourthBit;
        end
    end
    fourthBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = thirdBit;
        end
    end
    thirdBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = secondBit;
        end
    end
    secondBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = firstBit;
        end
    end
    firstBit: begin
        if (count == 4'b1111 && Rx_EN) begin
            shiftEnable = 1'b1;
            nextState   = parityBit;
        end
    end
    parityBit: begin
        if (count == 4'b1111 && Rx_EN && parity == RxD) nextState = stopBit;
        else if (count == 4'b1111 && Rx_EN && parity != RxD) begin
            Rx_PERROR = 1'b1;                                       // If parity != parity sampled -> PERROR
            nextState = idleState;
        end
    end
    stopBit: begin
        if (count == 4'b1111 && Rx_EN && RxD == 1'b1) begin
            Rx_VALID  = 1'b1;
            nextState = idleState;
        end
        else if (count == 4'b1111 && Rx_EN && !RxD) begin
            Rx_FERROR = 1'b1;                                       // If stop bit = 0 -> FERROR
            nextState = idleState;
        end
    end
    default: begin
        Rx_FERROR    = 1'b0;
        Rx_PERROR    = 1'b0;
        Rx_VALID     = 1'bx;
        shiftEnable  = 1'bx;
        countAligned = 1'bx;
    end
    endcase
end

endmodule