//4-Bit Rotational Counter: Counters value 
//decreased by one at each posedge clock signal
module FourBitCounter(reset, clk, count1);

input clk, reset;
output reg [3:0]count1;
wire [3:0] countNext1;

assign countNext1 = count1 - 4'b0001;

always @(posedge clk or posedge reset) 
begin 

    if (reset)
        count1 <= 4'b1111;              //When Reset is set to 1 initialize counter to value 4'b1111
    else 
        count1 <= countNext1;           //Assign counter its next value             
        
end

endmodule

    