//Shift message module: used to control char's value that will get displayed at each anode
//The digits displayed are gonna get shifted one place to the left
//each time the button is pressed
module shift_message(reset, clk, shift_button, count1, char);

input clk, reset, shift_button;
input [3:0]count1;
output reg [3:0]char;
reg [3:0]count2;
reg [3:0]address;
reg [3:0]message[0:15];
wire [3:0]countNext2;

assign countNext2 = count2 + 1;

/*4-Bit counter with shift_button as enable*/
always @(posedge clk or posedge reset)
begin
    if (reset)                                  //1. Set counter back to zero 
        count2 <= 4'b0000;                      //when reset is activated
    else  if (shift_button)                     //2. Increase counter's value by 1 when button is pressed
        count2 <= countNext2;
end

/*Control address pointing at the part of the message that gets displayed*/
always @(count1)
begin
    case(count1)
    4'b1111: address = count2 + 4'b0000;        //Change address's value two steps before
    4'b1110: address = count2 + 4'b0000;        //each anode (an3-0) gets activated. Address
    4'b1101: address = count2 + 4'b0000;        //is used to assign a value at char which needs
    4'b1100: address = count2 + 4'b0001;        //to be ready before an anode is activated.  
    4'b1011: address = count2 + 4'b0001;  
    4'b1010: address = count2 + 4'b0001;  
    4'b1001: address = count2 + 4'b0001;  
    4'b1000: address = count2 + 4'b0010;    
    4'b0111: address = count2 + 4'b0010;
    4'b0110: address = count2 + 4'b0010;
    4'b0101: address = count2 + 4'b0010;
    4'b0100: address = count2 + 4'b0011;    
    4'b0011: address = count2 + 4'b0011;
    4'b0010: address = count2 + 4'b0011;
    4'b0001: address = count2 + 4'b0011;
    4'b0000: address = count2 + 4'b0000;    
    default: address = address + 4'b0000;
    endcase
end

always @(address)
begin
    char = message[address];                    //Use address to assign the value that will get decoded to char
end

//Initialize memory with the message "123456789abcdef" once reset is activated
always @(*)
begin
    if (reset)
        message[0] = 4'b0000;
        message[1] = 4'b0001;
        message[2] = 4'b0010;
        message[3] = 4'b0011;
        message[4] = 4'b0100;
        message[5] = 4'b0101;
        message[6] = 4'b0110;
        message[7] = 4'b0111;
        message[8] = 4'b1000;
        message[9] = 4'b1001;
        message[10] = 4'b1010;
        message[11] = 4'b1011;
        message[12] = 4'b1100;
        message[13] = 4'b1101;
        message[14] = 4'b1110;
        message[15] = 4'b1111;
end
endmodule