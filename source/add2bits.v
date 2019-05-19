`timescale 1ns /1ps
module add2bits(
	input [31:0]inAdd,in2bits,
	output reg [31:0]out
);
always@(*)
begin
	out=inAdd+(in2bits <<2);
end
initial out=0;
endmodule 