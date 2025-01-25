`timescale 1ns/1ps
//LED Decoder: 4-bit LED decoder used to decode each digit to 
//8 signals controlling each segment of the display (+ the decimal point)
module LEDdecoder(char, LED);

input [3:0] char;
output reg [7:0] LED;

always @(char)
begin
    case (char)        //CA, CB, CC, CD, CE, CF, CG, DP
        4'b0000: LED = 8'b00000011;
        4'b0001: LED = 8'b10011111;
        4'b0010: LED = 8'b00100101;
        4'b0011: LED = 8'b00001101;
        4'b0100: LED = 8'b10011001;
        4'b0101: LED = 8'b01001001;
        4'b0110: LED = 8'b01000001;
        4'b0111: LED = 8'b00011111;
        4'b1000: LED = 8'b00000001;
        4'b1001: LED = 8'b00001001;
        4'b1010: LED = 8'b00010001;
        4'b1011: LED = 8'b11000001;
        4'b1100: LED = 8'b01100011;
        4'b1101: LED = 8'b10000101;
        4'b1110: LED = 8'b01100001;
        4'b1111: LED = 8'b01110001;
        default: LED = 8'bx;
    endcase
end


endmodule
