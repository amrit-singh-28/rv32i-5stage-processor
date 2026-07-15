`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2026 06:03:46
// Design Name: 
// Module Name: single_cycle_cpu_tb
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


module single_cycle_cpu_tb();
reg clk;
reg rst;

integer errors = 0;
integer cycle;

single_cycle_cpu #(.IMEM_INIT_FILE("single_cycle_cpu.hex")) dut(.clk(clk), .rst(rst));

always #5 clk = ~clk;

task check_reg(input [4:0] reg_num, input [31:0] expected, input [511:0] test_name);
reg [31:0] actual;
begin
actual = dut.rgut.register[reg_num];
if (actual !== expected) begin
$display("FAIL %0s : x%0d expected=0x%08h actual=0x%08h",test_name, reg_num, expected, actual);
errors = errors + 1;
end 
else $display("[PASS] %0s : x%0d=0x%08h", test_name, reg_num, actual); 
end
endtask

initial begin
clk=0; rst=1;
@(posedge clk) #1;rst=0;

for (cycle =0; cycle<40; cycle=cycle+1) @(posedge clk); #1;

check_reg(1,  32'd5,"x1");
check_reg(2,  32'd10,"x2");
check_reg(3,  32'd15,"x3");
check_reg(4,  32'd15,"x4");
check_reg(5,  32'd0,"x5");
check_reg(6,  32'd0,"x6 ");
check_reg(7,  32'd42,"x7");
check_reg(8,  32'd77,"x8 ");
check_reg(9,  32'd52,"x9 ");
check_reg(10, 32'd0,"x10");
check_reg(11, 32'h00010000,"x11");
check_reg(12, 32'd60,"x12 ");
check_reg(13, 32'd76,"x13 ");
check_reg(14, 32'd72,"x14");
check_reg(15, 32'd0,"x15");
check_reg(16, 32'd99,"x16");

if(dut.dmut.mem[0] != 8'h0F || dut.dmut.mem[1] != 8'h00 || dut.dmut.mem[2] != 8'h00 || dut.dmut.mem[3] != 8'h00) begin
$display("FAIL : expected 15 , Actual %02h %02h %02h %02h",dut.dmut.mem[0],dut.dmut.mem[1],dut.dmut.mem[2],dut.dmut.mem[3]);
errors=errors+1;
end
else $display("PASS");

if(dut.curr_pc !=32'd80) begin
$display("FAIL expected : 80 Actual 0x%08h",dut.curr_pc);
errors = errors +1;
end
else $display("PASS");

if(errors == 0) $display("ALL TESTCASES PASSED");
else $display("TESTCASES FAILED");
$finish;
end


endmodule
