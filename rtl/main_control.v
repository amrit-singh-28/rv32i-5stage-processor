`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 04:00:01
// Design Name: 
// Module Name: main_control
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


module main_control(
input wire [6:0]opcode,
output reg reg_write,
output reg [1:0]alu_a,
output reg alu_b,
output reg mem_read,
output reg mem_write,
output reg [1:0]result_src,
output reg branch,
output reg jump,
output reg jalr
    );
    
    localparam REG = 7'b0110011;
    localparam IMM = 7'b0010011;
    localparam LOAD = 7'b0000011;
    localparam STORE = 7'b0100011;
    localparam BRANCH = 7'b1100011;
    localparam JAL = 7'b1101111;
    localparam JALR=7'b1100111;
    localparam LUI = 7'b0110111;
    localparam AUIPC =7'b0010111;
    
always @(*) begin
reg_write = 1'b0;
alu_a = 2'b00;
alu_b = 1'b0;
mem_read = 1'b0;
mem_write = 1'b0;
result_src = 2'b00;
branch = 1'b0;
jump=1'b0;
jalr=1'b0;

case(opcode)
REG : begin
reg_write = 1'b1;
alu_a = 2'b00;
alu_b=1'b0;
result_src=2'b00;
end

IMM : begin
reg_write = 1'b1;
alu_a = 2'b00;
alu_b=1'b1;
result_src=2'b00;
end

LOAD : begin
reg_write = 1'b1;
alu_a = 2'b00;
alu_b=1'b1;
mem_read = 1'b1;
result_src=2'b01;
end

STORE : begin
reg_write = 1'b0;
alu_a = 2'b00;
alu_b=1'b1;
mem_write = 1'b1;
end

BRANCH : begin
alu_a=2'b00;
alu_b=1'b0;
branch=1'b1;
end

JAL : begin
reg_write = 1'b1;
result_src=2'b10;
jump = 1'b1;
end

JALR : begin
reg_write =1'b1;
alu_a = 2'b00;
alu_b = 1'b1;
result_src=2'b10;
jump=1'b1;
jalr=1'b1;
end

LUI : begin
reg_write=1'b1;
alu_a = 2'b10;
alu_b = 1'b1;
result_src = 2'b00;
end

AUIPC : begin
reg_write = 1'b1;
alu_a = 2'b01;
alu_b = 1'b1;
result_src = 2'b00;
end

endcase
end
endmodule
