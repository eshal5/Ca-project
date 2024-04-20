
module ID_EX(
input clk,
input reset,
input  [63:0] pc_out,readdata1,readdata2, imm,
input  [4:0] rs1, rs2, rd,
input  [3:0] funct,
input  branch, memread, memtoreg, memwrite, regwrite, alusrc,
input  [1:0] aluop,
output reg [63:0]pc_out_reg,readdata1_reg,readdata2_reg, imm_reg,
output reg [4:0] rs1_reg, rs2_reg, rd_reg,
output reg [3:0] funct_reg,
output reg branch_reg, memread_reg, memtoreg_reg, memwrite_reg, regwrite_reg, alusrc_reg,
output reg [1:0] aluop_reg
    );
    
always @(posedge clk) begin
    if (reset == 1'b1)begin
        pc_out_reg = 0;
        readdata1_reg = 0;
        readdata2_reg = 0;
        imm_reg = 0;
        rs1_reg = 0;
        rs2_reg = 0;
        rd_reg = 0;
        funct_reg = 0;
        branch_reg = 0;
        memread_reg = 0;
        memtoreg_reg = 0;
        memwrite_reg = 0;
        regwrite_reg = 0;
        alusrc_reg = 0;
        aluop_reg = 0;
        end
    else begin
         pc_out_reg = pc_out;
        readdata1_reg = readdata1;
        readdata2_reg = readdata2;
        imm_reg = imm;
        rs1_reg = rs1;
        rs2_reg = rs2;
        rd_reg = rd;
        funct_reg = funct;
        branch_reg = branch;
        memread_reg = memread;
        memtoreg_reg = memtoreg;
        memwrite_reg = memwrite;
        regwrite_reg = regwrite;
        alusrc_reg = alusrc;
        aluop_reg = aluop;
        end
        
    end
endmodule