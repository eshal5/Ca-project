`timescale 1ns / 1ps

module RISC_V_Processor(
input clk,
input reset,
output wire wire_stall,
output reg stall,
output reg flush,
output reg exmem_branch,exmem_branchfinale,
output wire [63:0] ex_alu2in,
  output wire [63:0] pc_temp,
output wire [63:0] pc_out,
output reg [63:0] pc_in, //wire
 
output wire [31:0] if_inst,
output reg [31:0] ifid_inst,
output reg   idex_branch, idex_memread, idex_memtoreg, idex_memwrite, idex_regwrite, idex_alusrc,
 output wire [1:0] forwarda, output wire [1:0] forwardb,
output wire [63:0] element1,
  output wire [63:0] element2,
  output wire [63:0] element3,
  output wire [63:0] element4,
  output wire [63:0] element5,
  output wire [63:0] element6,
  output wire [63:0] element7,
  output wire [63:0] element8
    );
    //if
   // reg stall;
    wire [63:0] if_adder4;
    //ifid
   reg [63:0] ifid_pcout;
   
   //id
      wire [6:0] id_opcode;
 wire [4:0] id_rd;
 wire [2:0] id_funct3;
 wire [4:0] id_rs1;
 wire [4:0] id_rs2;
 wire [6:0] id_funct7;
 wire  id_branch, id_memread, id_memtoreg, id_memwrite, id_alusrc, id_regwrite;
wire [1:0] id_aluop;
    wire [63:0] id_readdata1,id_readdata2,id_immdata;
   
   //ex
   wire [63:0] ex_adderimm,ex_alu1in,ex_muxB;
  
  wire [3:0] ex_operation;
  wire ex_zero,ex_branchfinale;
  wire [63:0] ex_aluresult;
 

    //idex
     reg [63:0] idex_pcout,idex_readdata1,idex_readdata2, idex_immdata;
     reg [4:0] idex_rs1, idex_rs2, idex_rd;
     reg [3:0] idex_funct;
    // reg   idex_branch, idex_memread, idex_memtoreg, idex_memwrite, idex_regwrite, idex_alusrc;
     reg [1:0]idex_aluop;
    //exmem
    reg [63:0] exmem_adderimm, exmem_aluresult,exmem_writedataout;
    reg exmem_regwrite,exmem_zero,exmem_memread, exmem_memtoreg, exmem_memwrite;
    reg [4:0] exmem_rd;
    //mem
    wire [63:0] datamemreaddata;
    //memwb
    reg [4:0] memwb_rd;
   reg memwb_regwrite,memwb_memtoreg;
reg [63:0] memwb_readdataout, memwb_aluresult;
  //wb
//  wire [63:0] mem_writedata;
  reg [63:0] pc_reg;
   wire [63:0] mem_writedata;
  //ifstage
  
 
  //  Mux m1(if_adder4,exmem_adderimm,(exmem_branch && exmem_branchfinale) , pc_in);
always@(*)begin
if (stall==1'b0) begin
if ((exmem_branch && exmem_branchfinale)==1'b0)
pc_in = if_adder4;
else if ((exmem_branch && exmem_branchfinale)==1'b1)
pc_in = exmem_adderimm;
end
end
    prog_counter pc(clk, reset,pc_reg,pc_temp, pc_in,pc_out,stall);
//    always@(*) begin
//    pc_reg<=pc_temp;end
    Instruction_Memory im(pc_out, if_inst);
    Adder a1(pc_out, 64'd4, if_adder4);
    always @(posedge clk) begin
    if (reset == 1'b1 || flush==1'b1) begin
        ifid_pcout <= 0;
        ifid_inst <= 0;
        end
     else if (stall==1'b1)begin
     end
    else if (stall==1'b0|| stall===1'bx) begin
       ifid_pcout <= pc_out;
        ifid_inst <= if_inst;
        end
end
   //IF_ID ifid(stall,clk, reset, pc_out,if_inst, ifid_pcout, ifid_inst);
   
  //id stage

  instructionparser ip(ifid_inst, id_opcode, id_rd, id_funct3, id_rs1, id_rs2, id_funct7);
  Hazard_Detection hd(id_rs1, id_rs2, idex_rd,
    idex_memread, wire_stall // IFID_Write, PC_Write, IDEX_MuxOut,
    );
   
      always@(*) begin
 stall=wire_stall;end
//HAZARDD
//always @(posedge clk) begin
//    if (idex_memread && (idex_rd == id_rs1 || idex_rd == id_rs2)) begin
//        stall = 1; // IDEX_MuxOut = 1; IFID_Write = 0; PC_Write = 0; 
       
//    end
//    else begin
//        stall = 0; // IDEX_MuxOut = 0; IFID_Write = 1; PC_Write = 1; 
//    end
//end
control_unit cu(id_opcode,stall, id_branch, id_memread, id_memtoreg, id_memwrite, id_alusrc, id_regwrite, id_aluop);

register_file rf(mem_writedata, id_rs1, id_rs2, memwb_rd, memwb_regwrite, clk, reset, id_readdata1, id_readdata2);
imm_gen imm_gen(ifid_inst, id_immdata);

//ID_EX idex( clk, reset,  ifid_pcout,id_readdata1,id_readdata2, id_immdata,   id_rs1, id_rs2, id_rd,
//                {ifid_inst[30],ifid_inst[14:12] },  id_branch, id_memread, id_memtoreg, id_memwrite, id_regwrite, id_alusrc, 
//               id_aluop,  idex_pcout,idex_readdata1,idex_readdata2, idex_immdata,  
//               idex_rs1, idex_rs2, idex_rd,   idex_funct,   idex_branch, idex_memread, 
//               idex_memtoreg, idex_memwrite, idex_regwrite, idex_alusrc,   idex_aluop);
always @(posedge clk) begin
    if (reset == 1'b1 ||flush==1'b1  )begin
        idex_pcout <= 0;
        idex_readdata1 <= 0;
        idex_readdata2 <= 0;
         idex_immdata <= 0;
        idex_rs1 <= 0;
        idex_rs2 <= 0;
        idex_rd <= 0;
        idex_funct <= 0;
        idex_branch <= 0;
        idex_memread <= 0;
        idex_memtoreg <= 0;
        idex_memwrite <= 0;
        idex_regwrite <= 0;
        idex_alusrc <= 0;
        idex_aluop <= 0;
        end
    else if (stall==1'b1) begin
    idex_pcout <= ifid_pcout;
        idex_readdata1 <= id_readdata1;
        idex_readdata2 <= id_readdata2;
        idex_immdata <= id_immdata;
        idex_rs1 <= id_rs1;
        idex_rs2 <= id_rs2;
        idex_rd <= id_rd;
        idex_funct <= {ifid_inst[30],ifid_inst[14:12] };
        idex_branch <= 0;
        idex_memread <= 0;
        idex_memtoreg <= 0;
        idex_memwrite <= 0;
        idex_regwrite<= 0;
        idex_alusrc <= 0;
        idex_aluop <= 0;
    end
    else begin
         idex_pcout <= ifid_pcout;
        idex_readdata1 <= id_readdata1;
        idex_readdata2 <= id_readdata2;
        idex_immdata <= id_immdata;
        idex_rs1 <= id_rs1;
        idex_rs2 <= id_rs2;
        idex_rd <= id_rd;
        idex_funct <= {ifid_inst[30],ifid_inst[14:12] };
        idex_branch <= id_branch;
        idex_memread <= id_memread;
        idex_memtoreg <= id_memtoreg;
        idex_memwrite <= id_memwrite;
        idex_regwrite<= id_regwrite;
        idex_alusrc <= id_alusrc;
        idex_aluop <= id_aluop;
        end
        
    end

//ex
Adder a2(idex_pcout, idex_immdata*2, ex_adderimm);
ForwardingUnit fu(idex_rs1, idex_rs2, exmem_rd, memwb_rd, memwb_regwrite, exmem_regwrite, forwarda, forwardb);

Mux_3 mm(idex_readdata1, mem_writedata, exmem_aluresult, forwarda, ex_alu1in);

Mux_3 mn(idex_readdata2, mem_writedata, exmem_aluresult, forwardb, ex_muxB);

Mux m2(ex_muxB, idex_immdata, idex_alusrc, ex_alu2in);
alu_control alu_c(idex_aluop, idex_funct, ex_operation);
ALU_64_bit alu(ex_alu1in, ex_alu2in, ex_operation, ex_aluresult, ex_zero);
branch bu(idex_funct[2:0], ex_alu1in, ex_alu2in, ex_branchfinale);
  
  //branch bu({ifid_inst[30],ifid_inst[14:12] }, id_readdata1, idreaddata2, id_branchfinale);

  

//EX_MEM exmem( clk,reset,
//   ex_adderimm,  ex_aluresult, ex_zero,ex_muxB,idex_rd, idex_branch,idex_memread, 
//   idex_memtoreg, idex_memwrite, idex_regwrite,ex_branchfinale,
//     exmem_adderimm,
//    exmem_zero,exmem_aluresult,
//     exmem_writedataout,
//     exmem_rd,
//    exmem_branch, exmem_memread, exmem_memtoreg, exmem_memwrite, exmem_regwrite,
//    exmem_branchfinale);
    always @(posedge clk)
    begin
      if (reset == 1'b1 ||flush==1'b1 )
        begin
          exmem_adderimm <= 64'b0;
          exmem_zero <= 1'b0;
          exmem_aluresult <= 63'b0;
          exmem_writedataout<= 64'b0;
          exmem_rd <= 5'b0;
          exmem_branch <= 1'b0;
          exmem_memread <= 1'b0;
          exmem_memtoreg <=1'b0;
          exmem_memwrite <= 1'b0;
          exmem_regwrite <= 1'b0;
          exmem_branchfinale<=1'b0;
         
        end
      else
        begin
         exmem_adderimm <= ex_adderimm;
          exmem_zero <= ex_zero;
          exmem_aluresult <= ex_aluresult;
          exmem_writedataout<= ex_muxB;
          exmem_rd <= idex_rd;
          exmem_branch <= idex_branch;
          exmem_memread <= idex_memread;
          exmem_memtoreg <=idex_memtoreg;
          exmem_memwrite <= idex_memwrite;
          exmem_regwrite <= idex_regwrite;
          exmem_branchfinale<=ex_branchfinale;
          
        end
    end
//mem

Data_Memory dm(exmem_aluresult, exmem_writedataout, clk, exmem_memwrite, exmem_memread, datamemreaddata,element1,element2,element3,element4,element5,element6,element7,element8);

always @(*)
    begin
      if (exmem_branch == 1'b1 && exmem_branchfinale==1'b1)
        flush = 1'b1;
      else
        flush = 1'b0;
    end
//MEM_WB memwb(clk, reset, datamemreaddata, exmem_aluresult, exmem_rd, exmem_memtoreg, exmem_regwrite, 
//                            memwb_readdataout, memwb_aluresult, memwb_rd, memwb_memtoreg, memwb_regwrite);
always @(posedge clk)
    begin
      if (reset == 1'b1 )
        begin
          memwb_readdataout <= 63'b0;
          memwb_aluresult <= 63'b0;
          memwb_rd <= 5'b0;
          memwb_memtoreg <= 1'b0;
          memwb_regwrite <= 1'b0;
          
        end
      else
        begin
          memwb_readdataout <= datamemreaddata;
          memwb_aluresult <=  exmem_aluresult;
          memwb_rd <= exmem_rd;
          memwb_memtoreg <= exmem_memtoreg;
          memwb_regwrite <=  exmem_regwrite;
        end
    end

Mux m3(memwb_aluresult, memwb_readdataout, memwb_memtoreg, mem_writedata);
      
endmodule