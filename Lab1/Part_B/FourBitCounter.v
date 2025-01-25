`timescale 1ns/1ps

//4-Bit Rotational Counter: Counters value 
//decreased by one at each posedge clock signal
module FourBitCounter(reset, clk, count);

input clk, reset;
output reg [3:0]count;
wire [3:0] countNext;                       //countNext -> counter's next value

assign countNext = count - 4'b0001;

//Control counter's value
always @(posedge clk or posedge reset) 
begin 

    if (reset)
        count <= 4'b1111;                   //When Reset is set to 1 initialize counter to value 4'b1111
    else 
        count <= countNext;                 //Assign counter its next value            
        
end

endmodule