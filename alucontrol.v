`timescale 1ns / 1ps



module alu_control
  (
   input [1:0]		alu_op,
   input [3:0]		Funct,
   output reg [3:0]	Operation
   );
   always @ (alu_op or Funct)
	 begin
		case(alu_op)
		  2'b00:
			begin
			   if(Funct[2:0]==001)
				 begin
					Operation=4'b1111;
				 end
			   else
				 begin
                    Operation = 4'b0010;
                 end
            end
		  2'b01: Operation = 4'b0110;
		  2'b10:
			begin
			   case(Funct)
				 4'b0000: Operation = 4'b0010;
				 4'b1000: Operation = 4'b0110;
				 4'b0111: Operation = 4'b0000;
				 4'b0110: Operation = 4'b0001;
			   endcase
			end
		endcase
	 end
endmodule