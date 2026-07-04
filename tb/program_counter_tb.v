`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2026 04:45:59
// Design Name: 
// Module Name: program_counter_tb
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


module program_counter_tb();
reg clk;
reg rst;
reg pc_write;
reg [31:0]next_pc;
wire [31:0]pc_out;

integer error =0;

program_counter dut (.clk(clk), .rst(rst), .pc_write(pc_write), .next_pc(next_pc), .pc_out(pc_out));

always #5 clk = ~clk;

task check(input [31:0] expected, input [127:0] test_name);
begin
if(pc_out != expected) begin 
$display("FAIL %0s : expected=0x%08h actual= 0x%08h at time=%0t",test_name, expected, pc_out, $time);
error = error + 1;
end else begin
$display("PASS");
end
end
endtask

initial begin
//$dumpfile(waveforms/program_counter_tb.vcd);
//$dumpvars(0,program_counter_tb);

clk =0;
rst=1;
pc_write=1;
next_pc=32'hDEAD_BEEF;
@(posedge clk) #1;
check(32'h0000_0000 , "T1");

rst=0;
pc_write = 1;
next_pc = 32'h0000_0004;
@(posedge clk) #1;
check(32'h0000_0004 , "T2");

next_pc = 32'h0000_0008;
@(posedge clk) #1;
check(32'h0000_0008 , "T3");

next_pc = 32'h0000_000C;
@(posedge clk) #1;
check(32'h0000_000C , "T4");

pc_write = 0;
next_pc = 32'h0000_0110;
@(posedge clk) #1;
check(32'h0000_000C , "T5");

next_pc = 32'h0000_1100;
@(posedge clk) #1;
check(32'h0000_000C , "T6");

pc_write=1;
next_pc=32'h0001_1000;
@(posedge clk) #1;
check(32'h0001_1000 , "T7");
#5;

if(error ==0)
$display("ALL TESTCASES PASSED");
else 
$display("%0d TEST(S) FAILED",error);
$finish;
end

endmodule
