`timescale 1ns /1ps
module memInstruc(//memoria Asincrona
	input [31:0]index,
	output [31:0] outS
);
reg [31:0] result;
reg [7:0]celda[255:0];
assign outS=result;
always@(*)
begin
	result[31:24]=celda[index];
	result[23:16]=celda[index +1];
	result[15:8]=celda[index+2];
	result[7:0]=celda[index+3];
end
initial begin
	//1 addi r1,r0,20
	celda[0]=8'b00100000;
	celda[1]=8'b00000001;
	celda[2]=8'b00000000;
	celda[3]=8'b00010100;
	//2 ori r2,r1,1	
	celda[4]=8'b00110100;
	celda[5]=8'b00100010;
	celda[6]=8'b00000000;
	celda[7]=8'b00000001;
	//3 subi r0,r1,10
	celda[8]=8'b00100100;
	celda[9]=8'b00100000;
	celda[10]=8'b00000000;
	celda[11]=8'b00001010;
	//4 andi r3,r2,0
	celda[12]=8'b00110000;
	celda[13]=8'b01000011;
	celda[14]=8'b00000000;
	celda[15]=8'b00000000;
	//5 addi r4,r1,80
	celda[16]=8'b00100000;
	celda[17]=8'b00100100;
	celda[18]=8'b00000000;
	celda[19]=8'b01010000;
	//6 add r20,r1,r4 
	celda[20]=8'b00000000;
   celda[21]=8'b00100100;
	celda[22]=8'b10100000;
	celda[23]=8'b00000000;
	//7 sw r0,r20,50
	celda[24]=8'b10101110;
	celda[25]=8'b10000000;
	celda[26]=8'b00000000;
	celda[27]=8'b00110010;
	//8 lw r11,r20,50 
	celda[28]=8'b10001110;
	celda[29]=8'b10001011;
	celda[30]=8'b00000000;
	celda[31]=8'b00110010;
	//9 mul r6,r11,r0
	celda[32]=8'b00000001;
	celda[33]=8'b01100000;
	celda[34]=8'b00110000;
	celda[35]=8'b00001000;
	//10 slt r0,r1,r14
	celda[36]=8'b00000000;
	celda[37]=8'b00000001;
	celda[38]=8'b01110000;
	celda[39]=8'b00101010;
	//11 j $0
	celda[40]=8'b00001000;
	celda[41]=8'b00000000;
	celda[42]=8'b00000000;
	celda[43]=8'b00000000;
	//$readmemb("memInstru.mem",celda);
end
endmodule 
