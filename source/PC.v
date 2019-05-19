`timescale 1ns /1ps
module PC(
	input [31:0] dir,
	input clk,
	output reg [31:0]dirOut
);
always@(posedge clk)
begin
	dirOut=dir;
end
//initial dirOut=0;
endmodule 