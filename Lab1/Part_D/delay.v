// Delay module: used to create a delay signal. A delay signal is set to 1
// after a 23-Bit counter reaches it's maximus value, meaning that 2^23 * clock_period 
// seconds have passed
module delay (clk, reset, delay);

input clk, reset;
output reg delay;
reg [22:0]counter;
wire [22:0]counterNext;

assign counterNext = counter + 23'b00000000000000000000001;     //Increase counter by 1

always @(posedge clk or posedge reset)                 
begin
    if(reset)                                                       
    begin                                               
        counter <= 23'b00000000000000000000000;                //When reset is activated set counter's
        delay <= 1'b0;                                         //value and delay to 0
    end
    else if (counter == 23'b11111111111111111111111)                                      
    begin                              
        counter <= 23'b00000000000000000000000;                //Set counter's value back to 0
        delay <= 1'b1;                                         //Set delay to 1 when counter reaches maximum value
    end
    else
    begin
        counter <= counterNext;                               //Increase counter's value by 1
        delay <= 1'b0;                                        //Set delay to 0
    end
end

endmodule