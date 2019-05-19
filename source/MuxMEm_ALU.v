`timescale 1ns /1ps
module MuxMEm_ALU(
	input [31:0] inMem,inALU,
	input selMux,
	output reg [31:0] outBanReg
);
always@(*)
begin
	if(selMux==0) outBanReg=inMem;//Elegir guardar valor en memoria
	else outBanReg=inALU;//Elegir guardar valor en  ALU
end
endmodule 