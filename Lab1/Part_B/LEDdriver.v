`timescale 1ns/1ps

//LED driver: Controlls all 4 anodes of the 7-Segment Display
//according to values of a 4-bit counter 
module LEDdriver(count, an3, an2, an1, an0, char);

input [3:0]count;
output reg [3:0]char;                              //Count1: output of 4-bit counter that
output reg an3, an2, an1, an0;                  //gets increased at each posedge clock

always @(count)                                //Change anodes at the following states (using counter's values):
begin                                           //an3 -> 1110
    case (count)                               //an2 -> 1010
        4'b1111: begin                          //an1 -> 0110
            an3 = 1'b1;                         //an0 -> 0010
            an2 = 1'b1;                         //Set them back to one in all the states between the ones above
            an1 = 1'b1;                         //so that they dont get overlapped while they are at 0
            an0 = 1'b1;
        end
        4'b1110: begin 
            an3 = 1'b0;                         //an3
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1101: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1100: begin 
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1011: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1010: begin
            an3 = 1'b1;
            an2 = 1'b0;                         //an2
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1001: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1000: begin 
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end 
        4'b0111: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b0110: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b0;                         //an1 
            an0 = 1'b1;
        end 
        4'b0101: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b0100: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b0011: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b0010: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b0;                          //an0
        end
        4'b001: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b0000: begin
            an3 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        default: begin
            an3 = 1'bx;
            an2 = 1'bx;
            an1 = 1'bx;
            an0 = 1'bx;
        end
    endcase
end

//Display message "0123" constantly on the display
//Feed the message to char two steps before the anode
//that will display it is set to 0
always @(count)
begin 
    case(count)
        4'b1111: char = 4'b0000;
        4'b1110: char = 4'b0000;
        4'b1101: char = 4'b0000;
        4'b1100: char = 4'b0001;
        4'b1011: char = 4'b0001;
        4'b1010: char = 4'b0001;
        4'b1001: char = 4'b0001;
        4'b1000: char = 4'b0010;
        4'b0111: char = 4'b0010;
        4'b0110: char = 4'b0010;
        4'b0101: char = 4'b0010;
        4'b0100: char = 4'b0011;
        4'b0011: char = 4'b0011;
        4'b0010: char = 4'b0011;
        4'b0001: char = 4'b0011;
        4'b0000: char = 4'b0000;
        default: char = 4'bx;
    endcase
end
endmodule