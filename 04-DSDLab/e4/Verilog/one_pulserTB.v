`timescale 1 ns/ 1 ns
module one_pulserTB();
	reg clk = 0;
	reg clkPB, rst;
	wire SP;
	
	one_pulser op(clkPB,clk,rst,SP);

	always #1 clk = ~clk;
	initial begin
		rst = 1'b1;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#5 rst = 1'b0;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#5 clkPB = 1'b1;
		#5 clkPB = 1'b0;
		#30 $stop;
	end

endmodule 
