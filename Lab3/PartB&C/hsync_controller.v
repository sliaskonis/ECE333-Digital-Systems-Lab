`timescale 1ns/1ps

// hsync_controller: module used to control VGA_VSYNC signal
// using an FSM with 4 states that control the timing of the 
// signal
module hsync_controller(reset, clk, hsync, HPIXEL_counterEN);

input reset, clk;

output reg hsync;               // VGA_HSYNC
output reg HPIXEL_counterEN;    // Enable HPIXEL counter

reg [11:0] count;
reg [1:0] currentState, nextState;
reg resetCounter;

// Coding of the FSM's states
parameter [1:0] hsyncActive = 2'b00,
                backPorch   = 2'b01,
                displayTime = 2'b10,
                frontPorch  = 2'b11;

// Change state
always @(posedge clk or posedge reset) begin
    if (reset) currentState <= hsyncActive;
    else currentState <= nextState;
end

// 12-bit counter: used to control the timing of the HSYNC signal 
// by counting clock cycles that translate to the time that the 
// signal will be high or low
always @(posedge clk or posedge reset) begin
    if (reset) count <= 'b0;
    else if (resetCounter) count <= 12'b000000000001;
    else count <= count + 12'b000000000001;
end

// Control FSM's next state
// FSM type: Mealy Machine
always @(count or currentState) begin
    case(currentState)
    hsyncActive: begin                  // HSYNC pulse: 3.84 us
        if (count == 12'd384) begin
            nextState = backPorch;
            hsync = 1'b1;
            resetCounter = 1'b1;
            HPIXEL_counterEN = 1'b0;
        end
        else begin 
            nextState = currentState;
            hsync = 1'b0;
            resetCounter = 1'b0;
            HPIXEL_counterEN = 1'b0;
        end
    end
    backPorch: begin                    // Back Porch: 1.92 us
        if (count == 12'd192) begin
            nextState = displayTime;
            hsync = 1'b1;
            resetCounter = 1'b1;
            HPIXEL_counterEN = 1'b1;
        end
        else begin 
            nextState = currentState;
            hsync = 1'b1;
            resetCounter = 1'b0;
            HPIXEL_counterEN = 1'b0;
        end
    end
    displayTime: begin                  // Display time: 25.6 us
        if (count == 12'd2560) begin
            nextState = frontPorch;
            hsync = 1'b1;
            resetCounter = 1'b1;
            HPIXEL_counterEN = 1'b0;
        end
        else begin
            nextState = currentState;
            hsync = 1'b1;
            resetCounter = 1'b0;
            HPIXEL_counterEN = 1'b1;
        end
    end
    frontPorch: begin                   // Front porch: 0.64 us
        if (count == 12'd64) begin
            nextState = hsyncActive;
            hsync = 1'b0;
            resetCounter = 1'b1;
            HPIXEL_counterEN = 1'b0;
        end
        else begin 
            nextState = currentState;
            hsync = 1'b1;
            resetCounter = 1'b0;
            HPIXEL_counterEN = 1'b0;
        end
    end
    default: begin 
        hsync = 1'bx;
        resetCounter = 1'bx;
        HPIXEL_counterEN = 1'bx;
    end
    endcase
end

endmodule