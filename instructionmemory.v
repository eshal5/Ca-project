`timescale 1ns / 1ps

module Instruction_Memory
(
input [63:0] Inst_Address,
output reg [31:0] Instruction
);
reg [7:0] inst_mem [119:0];
initial
begin
{inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00000AB3;
      {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00800B13;
      {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h000009B3;
      {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h0169c463;
      {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'h06000c63;	
      {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'hfff98a13;
      {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h040a4c63;
      {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h014a00b3;
      {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h014a02b3;
      {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h001282b3;	
      {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h001282b3;
      {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h001282b3;
      {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h005a82b3;
      {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h0002B303;
      {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h0082B383;
      {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h02734a63;
      {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'h014a0433;
      {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'h014a06b3;
      {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h00d40433;
      {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h00d40433;
      {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'h00d40433;
      {inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'h01540433;
      {inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} =32'h00043483;
      {inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]}=32'h00843603;
      {inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]}=32'h00c43023; //
      {inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]}=32'h00943423; //
      {inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]}=32'hfffa0a13;
      {inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]}=32'hfa0006e3;
     {inst_mem[115], inst_mem[114], inst_mem[113], inst_mem[112]}= 32'h00198993;
      {inst_mem[119], inst_mem[118], inst_mem[117], inst_mem[116]}=32'hf8000ce3;
end
always @(Inst_Address)
begin
Instruction[7:0] = inst_mem[Inst_Address+0];
      Instruction[15:8] = inst_mem[Inst_Address+1];
      Instruction[23:16] = inst_mem[Inst_Address+2];
      Instruction[31:24] = inst_mem[Inst_Address+3];
end
endmodule
