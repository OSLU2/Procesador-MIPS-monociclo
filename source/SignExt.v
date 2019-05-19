`timescale 1ns /1ps
module SignExt(
	input [15:0]in,
	output reg[31:0]out
);
always@(*)
begin
	if(in[15]==1)
	begin
		out[31:16]=16'd65535;
		out[15:0]=in;
	end
	else
	begin
		out[31:16]=16'd0;
		out[15:0]=in;
	end
end
endmodule 