// Check Parity: module used to check
// an 8-bit value for even parity
// Parity is set to 0 if number of 1s is even
// else is set to 1
module checkParity(data ,parity);

input [7:0] data;
output reg parity;                 // Parity bit: 1 if number of 1s is odd
                                   //             0 if number of 1s is even
reg temp[7:0];

//7 XOR gates  
always @(data)
begin
    temp[0] = data[0] ^ data[1];   
    temp[1] = temp[0] ^ data[2];
    temp[2] = temp[1] ^ data[3];
    temp[3] = temp[2] ^ data[4];
    temp[4] = temp[3] ^ data[5];
    temp[5] = temp[4] ^ data[6];
    parity = temp[5] ^ data[7];             
end

endmodule