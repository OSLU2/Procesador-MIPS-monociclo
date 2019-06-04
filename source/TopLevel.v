`timescale 1ns /1ps
module TopLevel(
	input clk,
	input [31:0]escribir,//recibiria los valores de entrada
	input [4:0]dirIniciar,
	input EWIniciar,
	input sel,
	output [31:0]DR1,DR2,
	output [31:0]AluResul,
	output [5:0]op,funt,
	output FlagZero,
	output [31:0]addresNext
);
//unidad de control a otros modulos
wire Ctrl_Bank;
wire [3:0] Ctrl_AluCtrl;
wire Ctrl_MemEW;
wire Ctrl_MemER;
wire Ctrl_MuxMem_ALU;
wire Ctrl_MuxAddr;
wire Ctrl_MuxSign_Bank;
wire Ctrl_And;
wire Ctrl_MuxPC2;
//conexiones de Banco a otros modulos
wire[31:0] DR1_A;
wire[31:0] DR2_MuxALU;
//ALU_Ctrl a ALU
wire [3:0] AluCtrl_ALU;
//ALU a otros dispositivos
wire [31:0]ALU_Mux;
wire ZeroALU_And;
//Memoria a MuxDest
wire [31:0]Mem_Mux;
//MuxMem_ALU a Bank
wire [31:0]MuxMem_ALU_Bank;
//MuxAddr a bank
wire [4:0]MuxAddr_Bank;
//MuxDR2Bank o sign a alu
wire [31:0]MuxALU_DR2Bank_Sign; 
//Extension de signo a Mux ALU
wire [31:0]outSign_MuxALU; 
//memInstruc a otros modulos
wire [31:0] instr;
//add4 a PC
wire [31:0] add4_PC;
//PC a memInstr y add4
wire [31:0] PC_memInstr,PC_Add4;
//add2bits a otros dispositivos
wire [31:0] add2_MuxPC;
//MuxPC a MuxPC2
wire [31:0] MuxPC1_muxPC2;
//MuxPC2 a PC
wire [31:0] MuxPC2_PC;
//registros para elegir entre muestra o funcion controlada por UC
reg EWR;
reg [31:0]RWBank; 
reg [4:0]AW;
assign op=instr[31:26];
assign DR1=DR1_A;
assign ResulInstr=instr;
assign PC_Add4=PC_memInstr;
assign FlagZero=ZeroALU_And;
assign AluResul=ALU_Mux;
assign addresNext=MuxPC2_PC;
assign funt=instr[5:0];
assign DR2=DR2_MuxALU;
always @(*)
begin
	if(sel==1)
	begin
		RWBank=MuxMem_ALU_Bank;
		AW=MuxAddr_Bank;
		EWR=Ctrl_Bank;
	end
	else
	begin
		RWBank=escribir;
		AW=dirIniciar;
		EWR=EWIniciar;
	end
end
//ciclo fetch
PC inst_PC(
	.dir(MuxPC2_PC),
	.clk(clk),
	.dirOut(PC_memInstr)
);
add4 inst_add4(
	.in(PC_Add4),
	.out(add4_PC)
);
memInstruc inst_memInstr(
	.index(PC_memInstr),
	.outS(instr)
);
//nuevas funciones 
MuxPC inst_MuxPC(
	.inAdd4(add4_PC),
	.inAdd2bits(add2_MuxPC),
	.zero(ZeroALU_And),.branch(Ctrl_And),
	.outMuxPC2(MuxPC1_muxPC2)
);	
MuxPC_2 inst_MuxPC2(//para type j
	.inAdd4(add4_PC[31:28]),
	.inMuxPC(MuxPC1_muxPC2),
	.inInstru(instr[25:0]),
	.selCtrl(Ctrl_MuxPC2),
	.outPC(MuxPC2_PC)					//hacer salida para ver funcion en TB
);
add2bits inst_add2(
	.inAdd(add4_PC),
	.in2bits(outSign_MuxALU),
	.out(add2_MuxPC)
);
//datapath
BancoRegis inst_bank(
	.AR1(instr[25:21]),
	.AR2(instr[20:16]),
	.AW(AW),
	.dateW(RWBank),
	.EWR(EWR),
	.DR1(DR1_A),.DR2(DR2_MuxALU)
);
SignExt instSignExt(
	.in(instr[15:0]),
	.out(outSign_MuxALU)
);
ALU inst_ALU(
	.in_A(DR1_A),
	.in_B(MuxALU_DR2Bank_Sign),
	.in_sel(AluCtrl_ALU),
	.o_S(ALU_Mux),
	.Zero(ZeroALU_And)
);
memoriaRAM inst_Mem(
	.dato(DR2_MuxALU),
	.index(ALU_Mux),
	.WE(Ctrl_MemEW),
	.RE(Ctrl_MemER),
	.outS(Mem_Mux)
);
MuxMEm_ALU inst_MuxMem_ALU(
	.inMem(Mem_Mux),
	.inALU(ALU_Mux),
	.selMux(Ctrl_MuxMem_ALU),
	.outBanReg(MuxMem_ALU_Bank)
);
ALU_Control inst_AluCtrl(
	.inControl(Ctrl_AluCtrl),
	.inFunct(instr[5:0]),
	.outAlu(AluCtrl_ALU)
);
MuxUni_Bank inst_MuxUni_Bank(
	.inS_Inst(instr[20:16]),
	.inD_Inst(instr[15:11]),
	.selUni(Ctrl_MuxAddr),
	.outBank(MuxAddr_Bank)
);
MuxBank_SignExt inst_MuxBank_Sign(
	.inBank(DR2_MuxALU),
	.inSignExt(outSign_MuxALU),
	.selUni(Ctrl_MuxSign_Bank),
	.outS_ALU(MuxALU_DR2Bank_Sign)
);
UnidadControl inst_UniCtrl(
	.op(instr[31:26]),
	.enW_Bank(Ctrl_Bank),
	.enW_Mem(Ctrl_MemEW),
	.enR_Mem(Ctrl_MemER),
	.selMuxMem_ALU(Ctrl_MuxMem_ALU),
	.selMuxAddr(Ctrl_MuxAddr),
	.selMuxSign_Bank(Ctrl_MuxSign_Bank),
	.selControl(Ctrl_AluCtrl),
	.branch(Ctrl_And),
	.selMuxPC2(Ctrl_MuxPC2)
);
endmodule 