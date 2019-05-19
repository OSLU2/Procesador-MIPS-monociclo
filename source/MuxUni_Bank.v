`timescale 1ns /1ps
module MuxUni_Bank(
	input [4:0] inS_Inst,inD_Inst,
	input selUni,
	output reg[4:0] outBank
);
always @(*)
begin
	if(selUni == 1) outBank=inD_Inst;//Elige la direccion de registro
	else outBank=inS_Inst;//Elige la direccion del segundo registro
end
endmodule 