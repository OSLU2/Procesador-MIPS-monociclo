`timescale 1ns /1ps
module MuxPC_2(//incluir shift left //para type J
	input [3:0] inAdd4,
	input [31:0] inMuxPC,
	input [25:0] inInstru,
	input selCtrl,
	output reg[31:0] outPC
);
wire [31:0] shiftLeft;
wire [31:0] resul;
assign resul[31:28]=inAdd4;
assign resul[27:0]=0;
assign shiftLeft=((32'd0+inInstru)<<2)+(resul+32'd0);

always @(*)
begin
	if(selCtrl == 1) outPC=shiftLeft;//Elige instr 25:0 con recorrido a la izq con bits de sumador4bits
	else outPC=inMuxPC;//Elige multiplexor PC1
end
endmodule 