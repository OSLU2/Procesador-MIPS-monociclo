`timescale 1ns /1ps
module add4(
	input [31:0]in,
	output reg [31:0]out
);
always@(*)
begin
	out=in+4;
end
initial out=0;
endmodule 