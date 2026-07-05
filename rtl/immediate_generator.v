`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2026 06:31:37
// Design Name: 
// Module Name: immediate_generator
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


module immediate_generator(
input wire [31:0] inst,
output reg [31:0] imm
    );

localparam LOAD =7'b0000011;
localparam OP_IMM = 7'b0010011;
localparam JALR = 7'b1100111;
localparam STORE = 7'b0100011;
localparam BRANCH = 7'b1100011;
localparam LUI = 7'b0110111;
localparam AUIPC = 7'b0010111;
localparam JAL = 7'b1101111;

wire [6:0] opcode = inst[6:0];
always @(*) begin
case(opcode)

LOAD, OP_IMM, JALR : begin
imm = {{20{inst[31]}},inst[31:20]};
end

STORE : begin
imm = {{20{inst[31]}},inst[31:25],inst[11:7]};
end

BRANCH : begin
imm = {{19{inst[31]}},inst[31],inst[7],inst[30:25],inst[11:8]};
end

LUI,AUIPC : begin
imm = {inst[31:12],12'b0};
end

JAL : begin
imm = {{11{inst[31]}},inst[31],inst[19:12],inst[20],inst[30:21],1'b0};
end

default : begin
imm = 32'b0;
end

endcase
end
endmodule
