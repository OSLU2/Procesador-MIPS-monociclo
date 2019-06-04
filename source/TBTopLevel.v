`timescale 1ns /1ps
module TBTopLevel;
reg  [7:0]i;
reg clk;
reg [31:0]escribir;//recibiria los valores de entrada
reg [4:0]dirIniciar;
reg EWIniciar;
reg sel;
wire [31:0]DR1,DR2;
wire [31:0]AluResul;
wire [5:0]op;
wire [5:0]funt;
wire Zero;
wire [31:0]addresNext;
TopLevel inst_top(
	.clk(clk),
	.escribir(escribir),
	.dirIniciar(dirIniciar),
	.EWIniciar(EWIniciar),
	.sel(sel),
	.DR1(DR1),.DR2(DR2),
	.AluResul(AluResul),
	.op(op),
	.funt(funt),
	.FlagZero(Zero),
	.addresNext(addresNext)
);
initial begin
	//Iniciamos el banco de registros en cero
	sel=0;
	EWIniciar=0;//poner en modo escritura
	for(i=0;i<32;i=i+1)
	begin
		dirIniciar=i;
		escribir=0;
		#20;
	end
	//iniciamos las instrucciones
	sel=1;
	#(40)clk=0;
	i=0;
	while(i<=178)
	begin
		#(80)clk=!clk;
		i=i+1;
	end
	$stop;
end
endmodule 