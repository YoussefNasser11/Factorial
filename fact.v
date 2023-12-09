module fact #(parameter W=32) (
	input clk,    // Clock
	input rst, // Clock Enable
	input [W-1:0]N , // Asynchronous reset active low
	output [2*W -1:0]A, output   done
);

wire [1:0] wb , wa;
wire z_out;
data_bus #(W )  D1(N , clk , rst , wa , wb , z_out , A );
 fsm  F1(z_out,clk,rst, wa,wb, done);
endmodule : fact