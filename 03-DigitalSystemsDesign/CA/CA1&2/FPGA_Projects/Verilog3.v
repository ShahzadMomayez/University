`timescale 1ns/1ns
module Q3Nand(input a , b , c , output w);
	supply1 Vdd;
	supply0 Gnd;
	wire y;
	wire x;
	pmos #(5,6,7) P1(w,Vdd,a) , P2(w,Vdd,b) , P3(w,Vdd,c);
	nmos #(3,4,5) N1(y,Gnd,b) , N2(x,y,a) , N3(w,x,c);
endmodule