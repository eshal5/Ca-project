//`timescale 1ns / 1ps

//module RISC_V_Processor(
//input clk,
//input reset,
//output wire [63:0] pc_out,
//output wire [63:0] adder1_out,
//output wire [63:0] adder2_out,
//output wire [63:0] pc_in,
//output wire zero,
//output wire [31:0] instruction,
//output wire [6:0] opcode,
//output wire [4:0] rd,
//output wire [2:0] funct3,
//output wire [4:0] rs1,
//output wire [4:0] rs2,
//output wire [6:0] funct7,
//output wire [63:0]writedata,

//output wire [63:0]readdata1,
//output wire [63:0]readdata2,
//output wire branch, memread, memtoreg, memwrite, alusrc, regwrite,
//output wire [1:0] aluop,
//output wire [63:0] immdata,
//output wire [63:0] mux2out,
//output wire [3:0] operation,
//output wire [63:0] aluout,
//output wire [63:0] datamemoryreaddata,
//output wire [63:0] element1,
//  output wire [63:0] element2,
//  output wire [63:0] element3,
//  output wire [63:0] element4,
//  output wire [63:0] element5,
//  output wire [63:0] element6,
//  output wire [63:0] element7,
//  output wire [63:0] element8
//    );

//wire addermuxselect;
//wire branch_finale;
//wire [3:0] funct;    
    
//wire [63:0] IFIDpc_out;
//wire [31:0] IFIDinst;

//wire [63:0]IDEXpc_out,IDEXreaddata1,IDEXreaddata2, IDEXimmdata;
//wire [4:0] IDEXrs1, IDEXrs2, IDEXrd;
////wire [2:0] idexfunct3;
//wire IDEXbranch, IDEXmemread, IDEXmemtoreg, IDEXmemwrite, IDEXregwrite, IDEXalusrc;
//wire [1:0] IDEXaluop;

//wire [63:0] EXMEMadderout;
//wire EXMEMzero;
// wire [63:0]   EXMEMaluout;
//  wire [63:0]  EXMEMwritedataout;
//  wire [4:0]  EXMEMrd;
//  wire  EXMEMbranch, EXMEMmemread, EXMEMmemtoreg, EXMEMmemwrite, EXMEMregwrite;
  
//wire [63:0] MEMWBreaddataout, MEMWBaluout;
//wire [4:0] MEMWBrd; 
//wire MEMWBmemtoreg, MEMWBregwrite;

//wire [1:0] forwarda, forwardb;

//wire [63:0] muxA_out, muxB_out;
    
//wire [3:0] IDEXfunct;

//prog_counter pc(clk, reset, pc_in,pc_out);
//Instruction_Memory im(pc_out, instruction);

//Adder a1(pc_out, 64'd4, adder1_out);

//IF_ID ifid(clk, reset, pc_out, instruction, IFIDpc_out, IFIDinst);

//instructionparser ip(IFIDinst, opcode, rd, funct3, rs1, rs2, funct7);
//control_unit cu(opcode, branch, memread, memtoreg, memwrite, alusrc, regwrite, aluop);
//register_file rf(writedata, rs1, rs2, MEMWBrd, MEMWBregwrite, clk, reset, readdata1, readdata2);
//imm_gen imm_gen(IFIDinst, immdata);

//ID_EX idex( clk, reset,  IFIDpc_out,readdata1,readdata2, immdata,   rs1, rs2, rd,
//                {IFIDinst[30],IFIDinst[14:12] },  branch, memread, memtoreg, memwrite, regwrite, alusrc, 
//               aluop,  IDEXpc_out,IDEXreaddata1,IDEXreaddata2, IDEXimmdata,  
//               IDEXrs1, IDEXrs2, IDEXrd,   IDEXfunct,   IDEXbranch, IDEXmemread, 
//               IDEXmemtoreg, IDEXmemwrite, IDEXregwrite, IDEXalusrc,   IDEXaluop);


////assign funct = {ifidinst[30], ifidinst[14:12]};

//Adder a2(IDEXpc_out, IDEXimmdata*2, adder2_out);

//Mux_3 mm(IDEXreaddata1, writedata, EXMEMaluout, forwarda, muxA_out);

//Mux_3 mn(IDEXreaddata2, writedata, EXMEMaluout, forwardb, muxB_out);

//Mux m2(muxB_out, IDEXimmdata, IDEXalusrc, mux2out);

//ALU_64_bit alu(muxA_out, mux2out, operation, aluout, zero);
//alu_control alu_c(IDEXaluop, IDEXfunct, operation);


//EX_MEM exmem( clk,reset,
//   adder2_out, 
//    aluout, 
//   zero,
//   muxB_out,
//   IDEXrd, 
//   IDEXbranch,IDEXmemread, IDEXmemtoreg, IDEXmemwrite, IDEXregwrite,
//   addermuxselect,
//     EXMEMadderout,
//    EXMEMzero,
//     EXMEMaluout,
//     EXMEMwritedataout,
//     EXMEMrd,
//    EXMEMbranch, EXMEMmemread, EXMEMmemtoreg, EXMEMmemwrite, EXMEMregwrite,
//    branch_finale);

//Data_Memory dm(EXMEMaluout, EXMEMwritedataout, clk, EXMEMmemwrite, EXMEMmemread, datamemoryreaddata,element1,element2,element3,element4,element5,element6,element7,element8);
//Mux m1(adder1_out, EXMEMadderout,(EXMEMbranch&&branch_finale) , pc_in);

//MEM_WB memwb(clk, reset, datamemoryreaddata, EXMEMaluout, EXMEMrd, EXMEMmemtoreg, EXMEMregwrite, 
//                            MEMWBreaddataout, MEMWBaluout, MEMWBrd, MEMWBmemtoreg, MEMWBregwrite);

//Mux m3(MEMWBaluout, MEMWBreaddataout, MEMWBmemtoreg, writedata);

//ForwardingUnit fu(idexrs1, idexrs2, exmemrd, memwbrd, memwbregwrite, exmemregwrite, forwarda, forwardb);

//branch bu(IDEXfunct[2:0], IDEXreaddata1, mux2out, addermuxselect);
//endmodule
`timescale 1ns / 1ps

module RISC_V_Processor(
input clk,
input reset,
output wire [63:0] pc_out,
output wire [63:0] pc_in,
output wire [4:0] id_rs1,
output wire [4:0] id_rs2,
 output wire [4:0] id_rd,
 output wire [63:0] ex_alu1in,ex_alu2in,ex_aluresult,
 output wire [1:0] forwarda, output wire [1:0] forwardb

    );
    //if
    wire [63:0] element1;
 wire [63:0] element2;
  wire [63:0] element3;
   wire [63:0] element4;
  wire [63:0] element5;
  wire [63:0] element6;
   wire [63:0] element7;
  wire [63:0] element8;
    wire [63:0] pc_temp;
    wire [63:0] if_adder4;
    //ifid
   reg [63:0] ifid_pcout;
   wire [31:0] if_inst;
reg [31:0] ifid_inst;
   //id
      wire [6:0] id_opcode;
 //wire [4:0] id_rd;
 wire [2:0] id_funct3;
// wire [4:0] id_rs1;
// wire [4:0] id_rs2;
 wire [6:0] id_funct7;
 wire id_branch, id_memread, id_memtoreg, id_memwrite, id_alusrc, id_regwrit;
wire [1:0] id_aluop;
    wire [63:0] id_readdata1,id_readdata2,id_immdata;
   
   //ex
   wire [63:0] ex_adderimm,ex_muxB;
  
  wire [3:0] ex_operation;
  wire ex_zero,ex_branchfinale;
 
 

    //idex
     reg [63:0] idex_pcout,idex_readdata1,idex_readdata2, idex_immdata;
     reg [4:0] idex_rs1, idex_rs2, idex_rd;
     reg [3:0] idex_funct;
     reg   idex_branch, idex_memread, idex_memtoreg, idex_memwrite, idex_regwrite, idex_alusrc;
     reg [1:0]idex_aluop;
    //exmem
    reg [63:0] exmem_adderimm, exmem_aluresult,exmem_writedataout;
    reg exmem_branch,exmem_branchfinale,exmem_regwrite,exmem_zero,exmem_memread, exmem_memtoreg, exmem_memwrite;
    reg [4:0] exmem_rd;
    //mem
    wire [63:0] datamemreaddata;
    //memwb
    reg [4:0] memwb_rd;
   reg memwb_regwrite,memwb_memtoreg;
reg [63:0] memwb_readdataout, memwb_aluresult;
  //wb
  wire [63:0] mem_writedata;
  reg [63:0] pc_reg;

  //ifstage
    Mux m1(if_adder4,exmem_adderimm,(exmem_branch && exmem_branchfinale) , pc_in);
  


    prog_counter pc(clk, reset,pc_reg,pc_temp, pc_in,pc_out);
    always@(*) begin
    pc_reg<=pc_temp;end
    Instruction_Memory im(pc_out, if_inst);
    Adder a1(pc_out, 64'd4, if_adder4);
    always @(posedge clk) begin
    if (reset == 1'b1) begin
        ifid_pcout <= 64'd0;
        ifid_inst <= 64'd0;
        end
    else  begin
       ifid_pcout <= pc_out;
        ifid_inst <= if_inst;
        end
end
   //IF_ID ifid(stall,clk, reset, pc_out,if_inst, ifid_pcout, ifid_inst);
  //id stage

  instructionparser ip(ifid_inst, id_opcode, id_rd, id_funct3, id_rs1, id_rs2, id_funct7);
  
control_unit cu(id_opcode, id_branch, id_memread, id_memtoreg, id_memwrite, id_alusrc, id_regwrite, id_aluop);
register_file rf(mem_writedata, id_rs1, id_rs2, memwb_rd, memwb_regwrite, clk, reset, id_readdata1, id_readdata2);
imm_gen imm_gen(ifid_inst, id_immdata);

//ID_EX idex( clk, reset,  ifid_pcout,id_readdata1,id_readdata2, id_immdata,   id_rs1, id_rs2, id_rd,
//                {ifid_inst[30],ifid_inst[14:12] },  id_branch, id_memread, id_memtoreg, id_memwrite, id_regwrite, id_alusrc, 
//               id_aluop,  idex_pcout,idex_readdata1,idex_readdata2, idex_immdata,  
//               idex_rs1, idex_rs2, idex_rd,   idex_funct,   idex_branch, idex_memread, 
//               idex_memtoreg, idex_memwrite, idex_regwrite, idex_alusrc,   idex_aluop);
always @(posedge clk) begin
    if (reset == 1'b1)begin
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
      if (reset == 1'b1)
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


//MEM_WB memwb(clk, reset, datamemreaddata, exmem_aluresult, exmem_rd, exmem_memtoreg, exmem_regwrite, 
//                            memwb_readdataout, memwb_aluresult, memwb_rd, memwb_memtoreg, memwb_regwrite);
always @(posedge clk)
    begin
      if (reset == 1'b1)
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