`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 02:34:07
// Design Name: 
// Module Name: single_cycle_cpu
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


module single_cycle_cpu #(
parameter IMEM_INIT_FILE = "single_cycle_cpu.hex"
)(
input wire clk,
input wire rst
    );

wire [31:0] curr_pc;
wire [31:0] next_pc;
wire [31:0] inst;

program_counter pcut(clk, rst, 1'b1, next_pc, curr_pc);

instruction_memory #(.INIT_FILE(IMEM_INIT_FILE)) insmut(curr_pc,inst);

wire [6:0] opcode = inst[6:0];
wire [4:0] rd = inst[11:7];
wire [2:0] funct3 = inst[14:12];
wire [4:0] rs1 = inst[19:15];
wire [4:0] rs2 = inst[24:20];
wire funct7_5 = inst[30];

wire reg_write;
wire [1:0]alu_a;
wire alu_b;
wire mem_read;
wire mem_write;
wire [1:0]result_src;
wire branch;
wire jump;
wire jalr;
wire [3:0] alu_ctrl;

main_control mcut(opcode, reg_write, alu_a, alu_b, mem_read, mem_write, result_src, branch, jump, jalr);

alu_control acut(opcode, funct3, fnct7_5, alu_ctrl);

wire [31:0]rs1_data;
wire [31:0]rs2_data;
wire [31:0]imm;
wire [31:0]rd_data;

register rgut(clk, rst, reg_write, rs1, rs2, rd, rd_data, rs1_data, rs2_data);

immediate_generator igut(inst, imm);

reg [31:0]alu_operand_a;
always @(*) begin
case(alu_a)
2'b00 : alu_operand_a = rs1_data;
2'b01 : alu_operand_a = curr_pc;
2'b10 : alu_operand_a = 1'b0;
default : alu_operand_a = rs1_data;
endcase
end

reg[31:0] alu_operand_b;
always @(*) begin
case(alu_b)
1'b0 : alu_operand_b = rs2_data;
1'b1 : alu_operand_b = imm;
endcase
end

wire [31:0]alu_result;
wire zero_flag;

ALU aluut(alu_operand_a, alu_operand_b, alu_ctrl,alu_result,zero_flag);

wire [31:0] read_data;
data_memory dmut(clk,mem_read,mem_write,rs2_data,alu_result,funct3,read_data);

wire [31:0]pc_plus = curr_pc + 32'd4;
wire [31:0]pc_target = curr_pc + imm;
wire [31:0]pc_jalr = {alu_result[31:1],{1'b0}};

reg bt;
always @(*) begin
case(funct3)
3'b000: bt = zero_flag;
3'b001: bt = ~zero_flag;
3'b100,3'b110: bt = alu_result[0];
3'b101,3'b111: bt = ~alu_result[0];
default: bt=1'b0;
endcase
end

reg[31:0] next_pc_r;
always @(*) begin
if(jump && jalr) next_pc_r = pc_jalr;
else if(jump) next_pc_r = pc_target;
else if(branch && bt) next_pc_r = pc_target;
else next_pc_r = pc_plus;
end

assign next_pc = next_pc_r;

reg [31:0] rd_data_r;
always @(*) begin
case(result_src)
2'b00 : rd_data_r = alu_result;
2'b01 : rd_data_r = read_data;
2'b10 : rd_data_r = pc_plus;
default : rd_data_r = alu_result;
endcase
end
assign rd_data = rd_data_r;
endmodule
