`timescale 1ns / 1ps

module MEM_WB(
input clk,reset,
  input [63:0] read_data,
  input [63:0] aluresult, 
  input [4:0]rd, 
  input memtoreg, regwrite, 
  output reg [63:0] readdata_reg,
  output reg [63:0] aluresult_reg,
  output reg [4:0] rd_reg,
  output reg memtoreg_reg, regwrite_reg
);
  
  always @(posedge clk)
    begin
      if (reset == 1'b1)
        begin
          readdata_reg = 63'b0;
          aluresult_reg = 63'b0;
          rd_reg = 5'b0;
          memtoreg_reg = 1'b0;
          regwrite_reg = 1'b0;
          
        end
      else
        begin
         readdata_reg = read_data;
          aluresult_reg = aluresult;
          rd_reg = rd;
          memtoreg_reg = memtoreg;
          regwrite_reg = regwrite;
        end
    end
endmodule