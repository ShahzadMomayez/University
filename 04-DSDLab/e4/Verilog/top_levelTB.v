`timescale 1 ns/ 1 ns
module top_levelTB();
	reg clk = 0;
	reg [4:0] vii;
	reg [15:0] vi;
	reg start , rst;
	reg [1:0] ui;
	wire wr_req , done;
	wire [20:0] wr_data;
	
	top_level TL(vii ,start , ui ,clk , rst , wr_req ,done ,wr_data);

	always #1 clk = ~clk;
	initial begin
		rst = 1'b1;
		#5 rst = 1'b0;
		#5 vii  = 5'b11100; ui = 2'b11; vi = 16'b1110000000000000;
		#5 start = 1'b1;
		#5 start = 1'b0;
		#3000 $stop;
	end

endmodule 
