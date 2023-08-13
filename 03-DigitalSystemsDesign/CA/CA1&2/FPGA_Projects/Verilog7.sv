`timescale 1ns/1ns
module Q7Compretor(input a1 , a2, a3,a4,b1,b2,b3,b4 ,output w);
	wire yq,y2,y3,y4;
	assign #54 y1 = ~a1 ? ~b1:b1;
	assign #54 y2 = ~a2 ? ~b2:b2;
	assign #54 y3 = ~a3 ? ~b3:b3;
	assign #54 y4 = ~a4 ? ~b4:b4;
	assign #22 w = y1&y2&y3&y4; 
endmodule
	
