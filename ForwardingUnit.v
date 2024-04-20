`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 12:30:42 PM
// Design Name: 
// Module Name: ForwardingUnit
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


module ForwardingUnit( input [4:0] IDEXrs1,input [4:0] IDEXrs2,input [4:0]EXMEMrd,//rdmem
input [4:0]MEMWBrd,
input MEMWB_regwrite,input EXMEM_regwrite,
output reg [1:0] ForwardA,ForwardB
 );
  
  always @(*)
    begin
    	if ( (EXMEMrd == IDEXrs1) & (EXMEM_regwrite != 0 & EXMEMrd !=0))
          begin
          	ForwardA = 2'b10;
          end
      	else
          begin 
            // Not condition for MEM hazard 
            if ((MEMWBrd== IDEXrs1) & (MEMWB_regwrite != 0 & MEMWBrd != 0) & ~((EXMEMrd == IDEXrs1) &(EXMEM_regwrite != 0 & EXMEMrd !=0)  )  )
              begin
                ForwardA = 2'b01;
              end
            else
              begin
                ForwardA = 2'b00;
              end
          end
      
        if ( (EXMEMrd == IDEXrs2) & (EXMEM_regwrite != 0 & EXMEMrd !=0))
          begin
          	ForwardB = 2'b10;
          end
      	else
          begin 
            // Not condition for MEM hazard 
            if ((MEMWBrd== IDEXrs2) & (MEMWB_regwrite != 0 & MEMWBrd != 0) & ~((EXMEMrd == IDEXrs2) &(EXMEM_regwrite != 0 & EXMEMrd !=0)  )  )
              begin
                ForwardB = 2'b01;
              end
            else
              begin
                ForwardB = 2'b00;
              end
          end
end
endmodule