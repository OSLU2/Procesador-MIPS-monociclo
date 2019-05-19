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
wire [31:0]MuxResul;
wire [5:0]op;
wire [31:0]Mux_sign_DR2;
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
	.MuxResul(MuxResul),
	.op(op),.Mux_sign_DR2(Mux_sign_DR2),
	.FlagZero(Zero),
	.addresNext(addresNext)
);
initial begin
	//Iniciar registros de prueba inicializando solo 5
	//registros en 0
	sel=0;
	EWIniciar=0;//poner en modo escritura
	dirIniciar=0;
	escribir=0;//r0=0
	#20;
	dirIniciar=1;
	escribir=0;//r1=0
	#20;
	dirIniciar=2;
	escribir=0;//r2=0
	#20;
	dirIniciar=3;
	escribir=0;//r3=0
	#20;
	dirIniciar=4;
	escribir=0;//r4=0
	#20;
	sel=1;
	#(40)clk=0;
	i=0;
	while(i<=24)
	begin
		#(40)clk=!clk;
		i=i+1;
	end
	$stop;
end
endmodule 