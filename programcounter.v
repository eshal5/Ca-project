`timescale 1ns / 1ps

module prog_counter
(
input clk,reset,
input [63:0] pc_reg,

output reg [63:0] pc_temp,
input [63:0] PC_In,
output reg [63:0] PC_Out

);

initial begin
PC_Out=64'd0;
pc_temp=64'd0;
end
always @ (posedge clk or posedge reset)
begin
if (reset) begin
PC_Out=64'd0;
pc_temp=64'd0;
end


else if (PC_In===64'bx) begin
PC_Out=pc_reg+64'd4; 
pc_temp=pc_reg+64'd4 
; end
else begin
PC_Out=PC_In;end
end

endmodule