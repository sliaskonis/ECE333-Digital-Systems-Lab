//LED driver: Controlls all 4 anodes of the 7-Segment Display
//according to values of a 4-bit counter
module LEDdriver(count1, an3, an2, an1, an0);

input [3:0]count1;                          //Count1: output value of a 4-bit counter
output reg an3, an2, an1, an0;              //that gets decreased at each posedge clock

always @(count1)                            //Change anodes at the following states (using counter's values):     
begin                                       //an3 -> 1110
    case (count1)                           //an2 -> 1010
        4'b1111: begin                      //an1 -> 0110
            an3 = 1'b1;                     //an0 -> 0010
            an2 = 1'b1;                     //Set them back to one in all the states between the ones shown
            an1 = 1'b1;                     //above, so that they dont get overlapped while they are active (0)
            an0 = 1'b1;
            an2 = 1'b1;
            an1 = 1'b1;
            an0 = 1'b1;
        end
        4'b1110: begin 
            an3 = 1'b0;
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
            an2 = 1'b0;
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
            an1 = 1'b0;
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
            an0 = 1'b0;
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

endmodule