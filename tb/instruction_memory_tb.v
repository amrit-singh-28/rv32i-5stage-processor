`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2026 07:21:39
// Design Name: 
// Module Name: instruction_memory_tb
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


module instruction_memory_tb(
    );
    reg [31:0]addr;
    wire [31:0]inst;
    
    integer error =0;
    
    instruction_memory #(.INIT_FILE("program.hex")) dut(.addr(addr), .inst(inst));

task check(input [31:0] expected, input [256:0] test_name); 
begin
if(expected != inst) begin
$display("FAIL %0s : expected = 0x%08h , actual = 0x%08h", test_name, expected, inst);
error = error +1;
end else begin
$display("PASS");
end
end
endtask

initial begin
addr = 32'h00000000;
#10;check(32'h00000000 ,"T1");

addr = 32'h00000004;
#10;check(32'h00010000 ,"T2");

addr = 32'h00000014;
#10;check(32'h00111111 ,"T3");

addr = 32'h00000020;
#10;check(32'h11111000 ,"T4");

addr = 32'h00000028;
#10;check(32'h01010101 ,"T5");

addr = 32'h0000003D;
#10;check(32'h11111001 ,"T6");
$finish;
end
endmodule
