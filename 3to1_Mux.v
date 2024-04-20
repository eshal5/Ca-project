`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 12:56:53 PM
// Design Name: 
// Module Name: 3to1_Mux
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


module Mux_3(

    input[63:0] a,
    input[63:0] b,
    input[63:0] c,
    input [1:0] select,
    output reg [63:0] dataout
  );
  always @(*)
    begin
      case(select)
        2'b00: dataout = a;
        2'b01: dataout = b;
        2'b10: dataout = c;
      endcase
    end

endmodule
