`timescale 1ns /1ps
module UnidadControl(
	input [5:0] op,
	output reg enW_Bank,enW_Mem,
	output reg enR_Mem,selMuxMem_ALU,
	output reg selMuxAddr,
	output reg selMuxSign_Bank,
	output reg [3:0]selControl,
	output reg branch,
	output reg selMuxPC2
);
always@(*)
begin
	case(op)
		0://tipo R
		begin
			selControl=4'b1000;//ALUControl reconoce funct
			enW_Bank=0;
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=0;//Elige banco 
			selMuxAddr=1;//Elige direccion destino
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;// elige secuencia ciclo de instrucciones
		end
		//Type J
		6'd2://J jump
		begin
			selControl=0;//no importa
			enW_Bank=1; //lectura
			selMuxMem_ALU=1;//no importa
			selMuxSign_Bank=1;//no importa
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=1;//Elige 25:0 de instruccion
		end
		//Type I
		6'd4://beq
		begin
			selControl=1;//restar si son iguales resul=0
			enW_Bank=1; //lectura
			selMuxMem_ALU=1;//no importa
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=1;//funcion de beq
			selMuxPC2=0;
		end
		6'd8://addi 
		begin
			selControl=0;//sumar
			enW_Bank=0;//escribir
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		6'd10: //slti
		begin
			selControl=4'd5;//slt
			enW_Bank=0;//escribir
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		6'd9:		//subi
		begin
			selControl=1;//restar
			enW_Bank=0;//escribir
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		6'd12: //andi
		begin
			selControl=4'd2;//and
			enW_Bank=0;//escribir
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		6'd13: //ori
		begin
			selControl=4'd3;//or
			enW_Bank=0;//escribir
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		6'd14://xori
		begin
			selControl=4'd4;//xor
			enW_Bank=0;//escribir
			selMuxMem_ALU=1;//Elige  ALU
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		6'b100011: //lw
		begin
			selControl=4'd0;//sumar
			enW_Bank=0;//escribir
			selMuxMem_ALU=0;//Elige  memoria
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=0;
			enR_Mem=1;//cargar a banco datos
			branch=0;
			selMuxPC2=0;
		end
		6'b101011://sw
		begin
			selControl=4'd0;//sumar
			enW_Bank=1;//escribir
			selMuxMem_ALU=1;  
			selMuxSign_Bank=1;//Elige extension de signo 
			selMuxAddr=0;//Elige segunda direccion
			enW_Mem=1;//guardar en memoria
			enR_Mem=0;
			branch=0;
			selMuxPC2=0;
		end
		default:selControl=4'b1111;
	endcase
end
endmodule 