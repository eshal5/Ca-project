module instructionparser(
input [31:0] instruction , //32bit instruction
output [6:0] opcode, // 7 bitopcode
output [4:0] rd, //5 bit rd
output [2:0] func3, // 3 bitfunc3
output [4:0] rs1, //5 bit rs1
output [4:0] rs2, // 5 bit rs2
output [6:0] func7); //7 bit func7
assign opcode=instruction
[6:0];
assign rd=instruction
[11:7];
assign func3=instruction
[14:12];
assign rs1=instruction
[19:15];
assign rs2=instruction
[24:20];
assign
func7=instruction[31:25];
endmodule