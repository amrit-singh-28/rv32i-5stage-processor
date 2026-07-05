`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2026 06:46:03
// Design Name: 
// Module Name: immediate_generator_tb
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


module immediate_generator_tb();
reg [31:0]inst;
wire [31:0]imm;

immediate_generator dut(.inst(inst), .imm(imm));
integer error =0;

task check(input [31:0]expected , input [31:0]test_name);
begin
if(imm != expected) begin
$display("FAIL %0s : expected 0x%08h actual 0x%08h",test_name,expected,imm);
end
else $display("PASS");
end
endtask

initial begin
inst = 32'hFFB00093;
#1;
check(32'hFFFFFFFB,"T1");

inst = 32'h06400113;
#1;
check(32'h00000064,"T2");

inst = 32'hFE21AE23;
#1;
check(32'hFFFFFFFC,"T3");

inst = 32'h0621A223;
#1;
check(32'h00000064,"T4");

inst = 32'hFE208CE3;
#1;
check(32'hFFFFFFF8,"T5");

inst = 32'h00209863;
#1;
check(32'h00000010,"T6");

inst=32'h123452B7;
#1;
check(32'h12345000,"T7");

inst=32'hFFFFF317;
#1;
check(32'hFFFFF000, "T8");

inst = 32'hFFDFF0EF;
#1;
check(32'hFFFFFFFC,"T9");

inst = 32'h001000EF;
#1;
check(32'h00000800,"T10");

inst=32'h007302B3;
#1;
check(32'h00000000,"T11");

$finish;
end
endmodule
