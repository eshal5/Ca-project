`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 11:52:21 AM
// Design Name: 
// Module Name: IF_ID
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IF_ID(
input stall,
input clk,
input reset,
input [63:0] pc_out,
input [31:0] instruction,
output reg [63:0] pc_out_reg,
output reg [31:0] instruction_reg);

always @(posedge clk) begin
    if (reset == 1'b1) begin
        pc_out_reg = 0;
        instruction_reg = 0;
        end
    else if (stall==1'b0|| stall===1'bx) begin
        pc_out_reg = pc_out;
        instruction_reg = instruction;
        end
end


endmodule