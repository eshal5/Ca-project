`timescale 1ns / 1ps

module ALU_64_bit
(
input [63:0]a, b,
input [3:0] ALUOp,
output reg [63:0] Result,
output reg ZERO
);

//assign ZERO = (Result == 0);
always @ (ALUOp, a, b)
begin
case (ALUOp)
4'b0000: Result = a & b;
4'b0001: Result = a | b;
4'b0010: Result = a + b;
4'b0110: Result = a - b;
4'b1100: Result = ~(a | b);
default: Result = 0;
endcase
if (Result == 0)
        ZERO = 1;
      else
        ZERO = 0;
end
endmodule
