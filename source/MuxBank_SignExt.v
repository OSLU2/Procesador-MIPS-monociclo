`timescale 1ns /1ps
module MuxBank_SignExt(
	input [31:0] inBank,inSignExt,
	input selUni,
	output reg [31:0] outS_ALU
);
always@(*)
begin
	if(selUni==1) outS_ALU=inSignExt;//Elegir guardar valor en memoria
	else outS_ALU=inBank;//Elegir guardar valor en  ALU
end
endmodule