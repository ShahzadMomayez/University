`timescale 1ns/1ns
module ALU(input [7:0]A,B,input[2:0]F,output[7:0]W,output c,z);
	reg ff , cin;
	reg [7:0] sum , input_b , min_sign;
	assign #7 cin = F[1]&(~F[0]);
	assign #14.3 input_b =  F == 3'b000 ? B:
				F == 3'b001 ? (B<<<1):
				F == 3'b010 ? (~B):
				F == 3'b011 ? (B>>>1): 1'bx;
	CRA_8bit adder(.A(A) , .B(input_b) ,.cin(cin) ,.S(sum) , .Co(ff));
	assign #14 min_sign = sum[7] ? A:B;
	assign #14.8 W= F==3'b000 ? sum:
			F==3'b001 ? sum:
			F==3'b010 ? min_sign:
			F==3'b100 ? 8'b0:
			F==3'b011 ? sum:
			F==3'b101 ? A|B:
			F==3'b110 ? A&B:
			F==3'b111 ? B<<<1 : 1'bx;
	assign #7.6 z=~|W;
	assign #14.1 c= (~F[2]) & ff & (F[0]|(~F[1]));
endmodule

