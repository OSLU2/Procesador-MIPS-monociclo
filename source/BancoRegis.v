`timescale 1ns /1ps
module BancoRegis(
	input [4:0] AR1,AR2,//direcciones de lectura
	input [4:0] AW,	//direccion de escritura
	input [31:0] dateW,
	input EWR,
	output reg [31:0] DR1,DR2
);
reg [31:0]celda[31:0];

always @(*)
begin
	if (EWR==0)	//opcion de escritura
	begin		
		celda[AW]=dateW;
	end
	DR1=celda[AR1];
	DR2=celda[AR2];
end
endmodule 