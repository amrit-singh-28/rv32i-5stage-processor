`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 12:08:14
// Design Name: 
// Module Name: branch_handling_unit
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


module branch_handling_unit(
input wire [2:0] funct3,
input wire branch,
input wire jump,
input wire alu_zero,
input wire alu_result_lsb,
output reg branch_taken,
output wire flush
    );
    
always @(*) begin
if (!branch) begin
branch_taken = 1'b0;  
end
else begin
case (funct3)
3'b000: branch_taken = alu_zero;          
3'b001: branch_taken = ~alu_zero;         
3'b100: branch_taken = alu_result_lsb;    
3'b101: branch_taken = ~alu_result_lsb;   
3'b110:branch_taken = alu_result_lsb;    
3'b111:branch_taken = ~alu_result_lsb;   
default: branch_taken = 1'b0;
endcase
end
end

assign flush = jump || (branch && branch_taken);
endmodule
