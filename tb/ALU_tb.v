`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2026 07:29:16
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb();
reg [31:0]opa;
reg [31:0]opb;
reg [3:0]alu_ctrl;
wire [31:0]out;
wire zero_flag;

ALU dut(.opa(opa), .opb(opb), .alu_ctrl(alu_ctrl), .out(out), .zero_flag(zero_flag));
integer error =0;

task check1(input [31:0]expected, input [31:0]test_name);
begin
if(expected != out) begin
$display("FAIL %0s : expected 0x%08h actual 0x%08h",test_name, expected, out);
error = error +1;
end
end
endtask

task check2(input expected, input [31:0]test_name);
begin
if(expected != zero_flag) begin
$display("FAIL %0s : expected 0x%08h actual 0x%08h",test_name, expected, out);
error = error +1;
end
end
endtask

initial begin
opa = 32'd15; opb=32'd18; alu_ctrl=4'b0000;
#1; check1(32'd33,"T1");

opa = 32'd38; opb=32'd18; alu_ctrl=4'b0001;
#1; check1(32'd20,"T2");

opa = 32'd15; opb=32'd15; alu_ctrl=4'b0001;
#1; check1(32'd0,"T3C1"); check2(1'b1,"T3C2");

opa = 32'h00000001; opb=32'd4; alu_ctrl=4'b0010;
#1; check1(32'h00000010,"T4");

opa = 32'h00000001; opb=32'd36; alu_ctrl=4'b0010;
#1; check1(32'h00000010,"T5");

opa = 32'hFFFFFFFF; opb=32'h00000001; alu_ctrl=4'b0011;
#1; check1(32'd1,"T6");

opa = 32'hFFFFFFFF; opb=32'd1; alu_ctrl=4'b0100;
#1; check1(32'd0,"T7");

opa = 32'hF0F0F0F0; opb=32'h0F0F0F0F; alu_ctrl=4'b0101;
#1; check1(32'hFFFFFFFF,"T8");

opa = 32'hF0000000; opb=32'd4; alu_ctrl=4'b0110;
#1; check1(32'h0F000000,"T9");

opa = 32'hF0000000; opb=32'd36; alu_ctrl=4'b0110;
#1; check1(32'h0F000000,"T10");

alu_ctrl=4'b0111;
#1; check1(32'hFF000000,"T11");

opa = 32'h00FF00FF; opb=32'h0F0F0F0F; alu_ctrl=4'b1000;
#1; check1(32'h0FFF0FFF,"T12");

opa = 32'hFFF000FF; opb=32'hFF00FF00; alu_ctrl=4'b1001;
#1; check1(32'hFF000000,"T13");

if(error == 0) $display("ALL TESTCASES PASSED");
else $display("TESTCASES FAILED");

$finish;
end
endmodule
