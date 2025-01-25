`timescale 1ns/1ps

// vsync_controller: module used to control VGA_VSYNC signal
// using an FSM with 4 states that control the timing of the
// signal
module vsync_controller(reset, clk, vsync, VPIXEL_counter_EN);

input reset, clk;

output reg vsync;               // VGA_VSYNC
output reg VPIXEL_counter_EN;   // Enable VPIXEL counter

reg [1:0] currentState, nextState;
reg [20:0] counter;
reg resetCounter;                

// Coding of the FSM's states
parameter [1:0] vsyncActive = 2'b00,
                backPorch   = 2'b01,
                activeVideo = 2'b10,
                frontPorch  = 2'b11;

// Change state
always @(posedge clk or posedge reset) begin
    if (reset) currentState <= vsyncActive;
    else currentState <= nextState;
end

// 21-bit counter: used to control the timing of the VSYNC signal
// by counting clock cycles that translate to the time that the 
// signal will be high or low
always @(posedge clk or posedge reset) begin
    if (reset) counter <= 'b0;
    else if (resetCounter) counter <= 21'b000000000000000000001;
    else counter <= counter + 21'b000000000000000000001;
end

// Control FSM's next state
// FSM type: Mealy Machine
always @(counter or currentState) begin
    case (currentState)
    vsyncActive: begin                  // VSYNC pulse: 64 us
        if (counter == 21'd6400) begin                  
            nextState = backPorch;
            vsync = 1'b1;
            resetCounter = 1'b1;
            VPIXEL_counter_EN = 1'b0;
        end
        else begin 
            nextState = currentState;
            vsync = 1'b0;
            resetCounter = 1'b0;
            VPIXEL_counter_EN = 1'b0;
        end
    end
    backPorch: begin                    // Back Porch: 928 us
        if (counter == 21'd92800) begin                 
            nextState = activeVideo;
            vsync = 1'b1;
            resetCounter = 1'b1;
            VPIXEL_counter_EN = 1'b1;
        end
        else begin
            nextState = currentState;
            vsync = 1'b1;
            resetCounter = 1'b0;
            VPIXEL_counter_EN = 1'b0;
        end
    end
    activeVideo: begin                  // Active Video: 15.36 ms
        if (counter == 21'd1536000) begin
            nextState = frontPorch;
            vsync = 1'b1;
            resetCounter = 1'b1;
            VPIXEL_counter_EN = 1'b0;
        end
        else begin
            nextState = currentState;
            vsync = 1'b1;
            resetCounter = 1'b0;
            VPIXEL_counter_EN = 1'b1;
        end
    end
    frontPorch: begin                   // Front Porch: 320 us
        if (counter == 21'd32000) begin
            nextState = vsyncActive;
            vsync = 1'b0;
            resetCounter = 1'b1;
            VPIXEL_counter_EN = 1'b0;
        end
        else begin
            nextState = currentState;
            vsync = 1'b1;
            resetCounter = 1'b0;
            VPIXEL_counter_EN = 1'b0;
        end
    end
    default: begin
        vsync = 1'bx;
        counter = 'bx;
    end
    endcase
end
endmodule