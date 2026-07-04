`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2026 23:56:57
// Design Name: 
// Module Name: register_tb
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


module register_tb( );
reg clk;
reg rst;
reg reg_write;
reg [4:0]rs1_addr;
reg [4:0]rs2_addr;
reg [4:0]rd_addr;
reg [31:0]rd_data;
wire[31:0]rs1_data;
wire [31:0]rs2_data;

register dut(.clk(clk), .rst(rst), .reg_write(reg_write), .rs1_addr(rs1_addr), .rs2_addr(rs2_addr), .rd_addr(rd_addr), .rd_data(rd_data), .rs1_data(rs1_data), .rs2_data(rs2_data));

integer error =0;

always #5 clk =~clk;
task check1(input [31:0]expected, input [32:0] test_name); 
begin
if(rs1_data != expected) begin
$display("FAIL %0s : expected rs1=0x%08h, actual = 0x%08h",test_name,expected,rs1_data);
error = error+1;
end
else begin
$display("PASS");
end
end
endtask

task check2(input [31:0]expected, input [32:0] test_name); 
begin
if(rs2_data != expected) begin
$display("FAIL %0s : expected rs2=0x%08h, actual = 0x%08h",test_name,expected,rs2_data);
error = error+1;
end
else begin
$display("PASS");
end
end
endtask

initial begin

clk = 1; rst = 1; reg_write = 0;
rs1_addr = 5'd10; rs2_addr = 5'd20; rd_addr = 5'd15; rd_data = 32'd1245;
@(posedge clk) #1;
check1(32'd0,"T1C1");
check2(32'd0,"T1C2");

rst=0;reg_write = 1;
rd_addr = 5'd10; rd_data = 32'd1234;
@(posedge clk) #1;
reg_write = 0;
rs1_addr = 5'd10;
#1;
check1(32'd1234,"T2");

reg_write =1;
rd_addr = 5'd12; rd_data=32'd32432;
@(posedge clk) #1;
reg_write=0;
rs2_addr = 5'd12;
#1;
check2(32'd32432,"T3");

reg_write =1;
rd_addr = 5'd16;
rd_data = 32'hAB2345AA;
rs1_addr = 5'd16;
rs2_addr = 5'd16;
#1;

check1(32'hAB2345AA,"T4C1");
check2(32'hAB2345AA,"T4C2");
@(posedge clk) #1;
check1(32'hAB2345AA,"T4C3");
check2(32'hAB2345AA, "T4C4");


reg_write =1;
rd_addr = 5'd0;
rd_data = 32'd1234567;
@(posedge clk) #1;
reg_write=0;
rs1_addr=5'd0;
#1; check1(32'd0,"T5");

rs1_addr = 5'd16;
rs2_addr = 5'd16;
#1;
check1(32'hAB2345AA, "T6C1");
check2(32'hAB2345AA, "T6C2");

reg_write =0;
rd_addr=5'd10;
rd_data = 32'd1234;
rs1_addr = 5'd10;
@(posedge clk) #1;
check1(32'd1234,"T7");

if(error == 0) $display("ALL TESTCASES PASSED");
else $display("TESTCASES FAILED");
#5;
$finish;
end
endmodule
