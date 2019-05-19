`timescale 1ns /1ps
module ALU_Control(
	input [3:0]inControl,
	input [5:0] inFunct,
	output reg[3:0] outAlu
);
always @(*)
begin
	case(inControl)
		4'd0:outAlu=0;//addi
		4'd1:outAlu=1;//subi
		4'd2:outAlu=4;//andi
		4'd3:outAlu=5;//ori
		4'd4:outAlu=6;//xori
		4'd5:outAlu=7;//slti
		
		4'd8://si inControl=8 hacer funciones de inFunct
		begin
			case(inFunct)
				6'd0:outAlu=0;//add
				6'd2:outAlu=1;//sub
				6'd8:outAlu=2;//mult
				6'b011010:outAlu=3;//div
				6'd4:outAlu=4;//and
				6'd5:outAlu=5;//or
				6'd6:outAlu=6;//xor
				6'b101010:outAlu=7;//slt
				6'd7:outAlu=8;//mod
				default:outAlu=0;
			endcase
		end
		default:outAlu=0;
	endcase		
end
endmodule 