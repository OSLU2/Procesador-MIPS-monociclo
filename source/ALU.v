`timescale 1ns /1ps
module ALU
(
	input [31:0]in_A,in_B,
	input [3:0]in_sel,
	output [31:0]o_S,
	output reg Zero
);

reg [31:0] o_resul;
assign o_S =o_resul;  // aqui se enviara el valor de la funcion elegida

always @ (*)
begin	
case(in_sel)
	4'b0000:o_resul= in_A+in_B; // suma
	4'b0001:o_resul= in_A-in_B; // resta
	4'b0010:o_resul= in_A*in_B; // multiplicacion
	4'b0011:o_resul= in_A/in_B; // division
	4'b0100:o_resul= in_A&in_B; // and
	4'b0101:o_resul= in_A|in_B; // or
	4'b0110:o_resul= in_A^in_B; // xor
	4'b0111:
	begin
		if(in_A<in_B)//Set on less than
		begin
			o_resul=1;
		end
		else o_resul=0;
	end
	4'b1000:o_resul= in_A%in_B;//mod
	default: o_resul= 0; 
endcase
end
always@(o_resul) begin
	if(o_resul==0)Zero=1;
	else Zero=0;
end
endmodule 