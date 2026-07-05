`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 03:33:16
// Design Name: 
// Module Name: alu_control_tb
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


module alu_control_tb( );
reg [6:0] opcode;
reg [2:0] funct3;
reg funct7;
wire [3:0] alu_ctrl;

alu_control dut(.opcode(opcode), .funct3(funct3), .funct7(funct7), .alu_ctrl(alu_ctrl));

integer errors =0;
localparam r_type = 7'b0110011;
localparam i_type = 7'b0010011;
localparam b_type = 7'b1100011;
localparam load = 7'b0000011;

task check(input [3:0]expected, input[31:0] test_name);
begin
if(alu_ctrl != expected) begin
$display("FAIL %0s : expected 0x%08h , actual 0x%08h",test_name , expected, alu_ctrl);
errors = errors +1;
end
else $display("%0s PASS",test_name);
end
endtask

initial begin 
opcode = r_type; funct3 = 3'b000; funct7 = 1'b0;
#1; check(4'b0000, "T1");
funct7=1'b1;
#1; check(4'b0001,"T2");

funct3 = 3'b101; funct7 = 1'b0;
#1; check(4'b0110,"T3");
funct7=1'b1;
#1; check(4'b0111,"T4");

opcode = r_type; funct7 = 1'b0;
funct3 = 3'b001; #1; check(4'b0010, "T5");
funct3 = 3'b010; #1; check(4'b0011, "T6");
funct3 = 3'b011; #1; check(4'b0100, "T7");
funct3 = 3'b100; #1; check(4'b0101, "T8");
funct3 = 3'b110; #1; check(4'b1000, "T9");
funct3 = 3'b111; #1; check(4'b1001, "T10");

opcode = i_type; funct3 = 3'b000; funct7=1'b1;
 #1; check(4'b0000, "T11");
 
 funct3=3'b101; funct7=1'b0;
 #1; check(4'b0110, "T12");
 funct7=1'b1;
 #1; check(4'b0111, "T13");
 
 opcode = b_type; funct3=3'b000;
 #1; check(4'b0001, "T14");
 funct3=3'b001;
 #1; check(4'b0001, "T15");
 
 funct3 = 3'b100;
#1; check(4'b0011, "T16");
funct3 = 3'b110;
#1; check(4'b0100, "T17");

opcode = load;funct3=3'b010;
#1 check(4'b0000,"T18");

if(errors ==0) $display("ALL TEST CASES PASSED");
else $display("TESTCASES FAILED");
$finish;
end
endmodule
