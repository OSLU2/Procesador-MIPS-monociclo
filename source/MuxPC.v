`timescale 1ns /1ps
module MuxPC(
	input [31:0] inAdd4,inAdd2bits,
	input zero,branch,
	output reg[31:0] outMuxPC2
);
wire sel;
assign sel=zero&branch;
always @(*)
begin
	if(sel == 1) outMuxPC2=inAdd2bits;//Elige el sumador de sign + sumador4bits
	else outMuxPC2=inAdd4;//Elige solo sumador4bits 
end
endmodule 