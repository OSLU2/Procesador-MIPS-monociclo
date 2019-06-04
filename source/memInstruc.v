`timescale 1ns /1ps
module memInstruc(
	input [31:0]index,
	output [31:0] outS
);
reg [31:0] result;
reg [7:0]celda[320:0];
assign outS=result;
always@(*)
begin
	result[31:24]=celda[index];
	result[23:16]=celda[index +1];
	result[15:8]=celda[index+2];
	result[7:0]=celda[index+3];
end
initial begin
	$readmemb("memInstru.mem",celda);
end
endmodule 
