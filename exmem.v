`timescale 1ns / 1ps

module EX_MEM(
  input clk,reset,
  input [63:0] adderout, 
  input [63:0] aluresult,//64bit alu output
  input zero,//64bit alu output
  input [63:0] forwardbmuxout, 
  input [4:0] rd, 
  input branchin,memreadin, memtoregin, memwritein, regwritein,branch_finale,
  
  output reg [63:0] adderout_reg,
  output reg zero_out,
  output reg [63:0] aluresult_reg,
  output reg [63:0] forwardbmuxout_reg,
  output reg [4:0] rd_reg,
  output reg branch_reg, memread_reg, memtoreg_reg, memwrite_reg, regwrite_reg,branch_finale_reg);
  
  always @(posedge clk)
    begin
      if (reset == 1'b1)
        begin
          adderout_reg = 64'b0;
          zero_out = 1'b0;
          aluresult_reg = 63'b0;
          forwardbmuxout_reg = 64'b0;
          rd_reg = 5'b0;
          branch_reg = 1'b0;
          memread_reg = 1'b0;
          memtoreg_reg =1'b0;
          memwrite_reg = 1'b0;
          regwrite_reg = 1'b0;
          branch_finale_reg=1'b0;
        end
      else
        begin
          adderout_reg = adderout;
          zero_out =zero ;
          aluresult_reg = aluresult;
          forwardbmuxout_reg = forwardbmuxout;
          rd_reg = rd;
          branch_reg = branchin;
          memread_reg = memreadin;
          memtoreg_reg =memtoregin;
          memwrite_reg = memwritein;
          regwrite_reg = regwritein;
          branch_finale_reg=branch_finale;
        end
    end
endmodule