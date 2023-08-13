`timescale 1ns/1ns
module Adder8_TB ();
	reg [7:0]a , b;
	assign a = 8'd5;
 	assign b = 8'd3;
	reg cin;
	assign cin = 0;
	wire co;
	wire [7:0] s;
	CRA_8bit adder (.A(a) , .B(b) ,.cin(cin) , .S(s) , .Co(co));
	initial begin
		#60 a = a+1;
		b = b+1;
		#60 ;
		b = b - 2;
		#60;
		a = a - 2;
		#60;
	end
endmodule
		
	
