//  Debounce circuit for handling unpredictable
//  bounce in the signal when a button is toggled
module debounce_circuit(clk, button_in, button_out);

input clk, button_in;
output button_out;
wire q1, q2, q2_bar, q0;

assign q2_bar = ~q2;
assign button_out = q1 & q2_bar;

dff d0(clk, button_in, q0);
dff d1(clk, q0, q1);
dff d2(clk, q1, q2);

endmodule


//D Flip Flop
module dff(clk, D, Q);

input clk, D;
output reg Q;

always @(posedge clk)
begin 
    Q <= D;
end

endmodule
