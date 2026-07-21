`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 09:44:21
// Design Name: 
// Module Name: id_ex_reg
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


module id_ex_reg(
input wire clk,
input wire rst,
input wire stall,
input wire flush,

input wire [31:0]pc,
input wire [31:0]pc_plus,
input wire [31:0]rs1_data,
input wire [31:0]rs2_data,
input wire [4:0]rs1_addr,
input wire [4:0]rs2_addr,
input wire [31:0]imm,
input wire [4:0]rd_addr,
input wire [2:0]funct3,

input wire reg_write,
input wire [1:0]alu_a,
input wire alu_b,
input wire mem_read,
input wire mem_write,
input wire [1:0]result_src,
input wire branch,
input wire jump,
input wire jalr,
input wire [3:0]alu_ctrl,

output reg [31:0]pc_o,
output reg [31:0]pc_plus_o,
output reg [31:0]rs1_data_o,
output reg [31:0]rs2_data_o,
output reg [4:0]rs1_addr_o,
output reg [4:0]rs2_addr_o,
output reg [31:0]imm_o,
output reg [4:0]rd_addr_o,
output reg [2:0]funct3_o,

output reg reg_write_o,
output reg [1:0]alu_a_o,
output reg alu_b_o,
output reg mem_read_o,
output reg mem_write_o,
output reg [1:0]result_src_o,
output reg branch_o,
output reg jump_o,
output reg jalr_o,
output reg [3:0]alu_ctrl_o
    );
    
always @(posedge clk) begin
if(rst || flush) begin
pc_o <= 32'd0;
pc_plus_o <= 32'd0;
rs1_data_o <= 32'd0;
rs2_data_o <= 32'd0;
rs1_addr_o <= 5'd0;
rs2_addr_o <= 32'd0;
imm_o <= 32'd0;
rd_addr_o <= 5'd0;
funct3_o <= 3'd0;

reg_write_o <= 0;
alu_a_o <= 2'd0;
alu_b_o <= 0;
mem_read_o <= 0;
mem_write_o <= 0;
result_src_o <= 2'd0;
branch_o <=0;
jump_o<=0;
jalr_o<=0;
alu_ctrl_o<=4'd0;
end

else if(stall) begin
pc_o <= pc;
pc_plus_o <=pc_plus;
rs1_data_o <= rs1_data;
rs2_data_o <= rs2_data;
rs1_addr_o<= rs1_addr;
rs2_addr_o <= rs2_addr;
imm_o <= imm;
rd_addr_o <= rd_addr;
funct3_o <= funct3;

reg_write_o <= reg_write;
alu_a_o <= alu_a;
alu_b_o <= alu_b;
mem_read_o<= mem_read;
mem_write_o<= mem_write;
result_src_o<=result_src;
branch_o<=branch;
jump_o<=jump ;
jalr_o<=jalr; 
alu_ctrl_o<= alu_ctrl; 
end
end
endmodule
