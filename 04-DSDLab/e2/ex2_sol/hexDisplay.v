
module Binary_To_7Segment (Din,r_Hex_Encoding);
 input wire [3:0]Din;
  output reg [6:0] r_Hex_Encoding;
   
  always @(Din)
    begin
      case (Din)
        4'b0000 : r_Hex_Encoding = 7'b1000000;
        4'b0001 : r_Hex_Encoding = 7'b1111001;
        4'b0010 : r_Hex_Encoding = 7'b0100100;
        4'b0011 : r_Hex_Encoding = 7'b0110000;
        4'b0100 : r_Hex_Encoding = 7'b0011001;          
        4'b0101 : r_Hex_Encoding = 7'b0010110;
        4'b0110 : r_Hex_Encoding = 7'b0000010;
        4'b0111 : r_Hex_Encoding = 7'b1111000;
        4'b1000 : r_Hex_Encoding = 7'b0000000;
        4'b1001 : r_Hex_Encoding = 7'b0010000;
        4'b1010 : r_Hex_Encoding = 7'b0001000;
        4'b1011 : r_Hex_Encoding = 7'b0000011;
        4'b1100 : r_Hex_Encoding = 7'b1000110;
        4'b1101 : r_Hex_Encoding = 7'b0100001;
        4'b1110 : r_Hex_Encoding = 7'b0000110;
        4'b1111 : r_Hex_Encoding = 7'b0001110;
      endcase
    end

  
 
endmodule