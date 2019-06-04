`timescale 1ns /1ps
module memoriaRAM(
	input [31:0] dato,index,
	input WE,RE,
	output reg [31:0] outS
);
reg [31:0]celda[1023:0];
always@(index)
begin
	if(WE && !RE)//opcion de escritura
	begin
		celda[index]=dato;
	end 
	if(RE && !WE)			//opcion de lectura
	begin
		outS=celda[index];
	end
end
endmodule 