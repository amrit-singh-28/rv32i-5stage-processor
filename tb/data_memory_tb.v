`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 09:58:55
// Design Name: 
// Module Name: data_memory_tb
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


module data_memory_tb();
reg clk;
reg mem_write;
reg mem_read;
reg [31:0]write_data;
reg [31:0]addr;
reg [2:0]funct3;
wire [31:0]read_data;

data_memory dut(.clk(clk), .mem_write(mem_write), .mem_read(mem_read), .write_data(write_data), .addr(addr), .funct3(funct3), .read_data(read_data));

integer errors =0;

always #5 clk = ~clk;

task check(input[31:0] expected,input [31:0] test_name);
begin
if(expected != read_data) begin
$display("FAIL %0s : expected 0x%08h actual 0x%08h",test_name,expected,read_data);
errors = errors +1;
end
else $display("PASS");
end
endtask

initial begin
clk = 0;
mem_write =0; mem_read=0;addr=0;write_data=0;funct3=3'b000;

addr=32'd0; mem_write =1;funct3=3'b010;write_data=32'h01234567;
@(posedge clk) #1;
mem_write=0;
mem_read =1;#4;
check(32'h01234567,"T1");

funct3=3'b100;
addr=32'd0; #4; check(32'h00000067,"T2");
addr=32'd1; #4;check(32'h00000045,"T3");
addr=32'd2; #4;check(32'h00000023,"T4");
addr=32'd3; #4;check(32'h00000001,"T5");

mem_read=0;
addr=32'd100; mem_write =1;funct3=3'b000;write_data=32'h000000FF;
@(posedge clk); #1;
mem_write=0; mem_read=1;
funct3=3'b000;#4;
check(32'hFFFFFFFF,"T6");
funct3=3'b100;#4;
check(32'h000000FF,"T7");

mem_read=0;
addr=32'd200; mem_write =1;funct3=3'b001;write_data=32'h0000FACA;
@(posedge clk); #1;
mem_write=0; mem_read=1;
funct3=3'b001;#4;
check(32'hFFFFFACA,"T8");
funct3=3'b101;#4;
check(32'h0000FACA,"T9");

mem_read=0; mem_write =1;
addr=32'd300; funct3=3'b010; write_data = 32'hFFFFFFFF;
@(posedge clk); #1;
addr=32'd301; funct3=3'b000; write_data = 32'h00000000;
@(posedge clk); #1;
mem_write=0; mem_read=1;
addr=32'd300; funct3=3'b010; #4;
check(32'hFFFF00FF,"T10");

mem_read=0;#4;
check(32'h00000000,"T11");
if(errors==0) $display("ALL TESTCASES PASSES");
else $display("TESTCASES FAILED");

$finish;
end
endmodule
