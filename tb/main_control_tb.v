`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 07:10:26
// Design Name: 
// Module Name: main_control_tb
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


module main_control_tb();
reg [6:0]opcode;
wire reg_write;
wire [1:0]alu_a;
wire alu_b;
wire result_src;
wire branch;
wire jump;
wire jalr;
wire mem_read;
wire mem_write;

main_control dut(.opcode(opcode), .reg_write(reg_write), .alu_a(alu_a), .alu_b(alu_b), .result_src(result_src), .branch(branch), .jump(jump), .jalr(jalr), .mem_read(mem_read), .mem_write(mem_write));
integer error=0;

task check(input e_reg_write, input [1:0]e_alu_a, input e_alu_b, input e_mem_read, input e_mem_write, input e_result_src, input e_branch, input e_jump, input e_jalr, input [31:0]test_name);
begin
if(e_reg_write != reg_write || e_alu_a != alu_a || e_alu_b != alu_b || e_mem_read != mem_read || e_mem_write != mem_write || e_result_src != result_src || e_branch != branch || e_jump != jump || e_jalr != jalr) begin
$display("%0s FAIL",test_name);
$display("EXPECTED : rw=%ob, srcA=%02b, srcB= %0b, mr=%0b, mw=%0b, rs=%02b, bra=%ob, j=%0b, jalr=%0b",e_reg_write, e_alu_a, e_alu_b, e_mem_read, e_mem_write, e_result_src, e_branch, e_jump, e_jalr);
$display("ACTUAL :  rw=%ob, srcA=%02b, srcB= %0b, mr=%0b, mw=%0b, rs=%02b, bra=%ob, j=%0b, jalr=%0b",reg_write, alu_a, alu_b, mem_read, mem_write, result_src, branch, jump, jalr);
error = error +1;
end 
else $display("PASS");
end
endtask

initial begin
opcode = 7'b0110011; #1;
check(1,2'b00,0,0,0,2'b00,0,0,0,"T1");

opcode = 7'b0010011; #1;
check(1,2'b00,1,0,0,2'b00,0,0,0,"T2");

opcode = 7'b0000011; #1;
check(1,2'b00,1,1,0,2'b01,0,0,0,"T3");

opcode = 7'b0100011; #1;
check(0,2'b00,1,0,1,2'b00,0,0,0,"T4");

opcode = 7'b1100011; #1;
check(0,2'b00,0,0,0,2'b00,1,0,0,"T5");

opcode = 7'b1101111; #1;
check(1,2'b00,0,0,0,2'b10,0,1,0,"T6");

opcode = 7'b1100111; #1;
check(1,2'b00,1,0,0,2'b10,0,1,1,"T7");

opcode = 7'b0110111; #1;
check(1,2'b10,1,0,0,2'b00,0,0,0,"T8");

opcode = 7'b0010111; #1;
check(1,2'b01,1,0,0,2'b00,0,0,0,"T9");

opcode = 7'b1111111; #1;
check(0,2'b00,0,0,0,2'b00,0,0,0,"T10");
$finish;
end
endmodule
