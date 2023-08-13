
`timescale 1ns/1ns
module L2TB();
	wire [6:0] r_Hex_Encoding;
	reg clk=0,rst=0,clkPB=0,serIn=0;
	wire clkEn,Co,cnt_reset,load,serOut,serOutValid;
	wire [3:0] Count;
	always #20 clk=~clk;
	//counter C(clk,cnt_reset,clkEn,load,Co,Count);
	//Sequence_Detector SD(clk,rst,clkEn,serIn,Co,serOut,serOutValid,load,cnt_reset);
	//one_pulser P(clk,rst,clkPB,clkEn);
	//Binary_To_7Segment ss(Count,r_Hex_Encoding);
	top t(clk,rst,clkPB,serIn , r_Hex_Encoding,serOut,serOutValid);
	initial begin
		rst=1;
		#100;
		rst=0;
		serIn=1;
		#100
		clkPB=1;
		#100
		clkPB=0;
		#100
		clkPB=1;
		#100
		serIn=0;
		#100
		clkPB=0;
		#100
		clkPB=1;
		#100
		clkPB=0;
		#100
		serIn=1;
		#100
		clkPB=1;
		#100
		serIn=0;
		#100
		clkPB=0;
		#100
		clkPB=1;
		#100
		serIn=1;
		#100
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		serIn=0;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		serIn=1;
		#100
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		serIn=0;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100;
		clkPB=0;
		#100
		clkPB=1;
		#100
		$stop;
		
	end

endmodule