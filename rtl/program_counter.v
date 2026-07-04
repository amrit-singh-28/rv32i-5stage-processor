`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2026 04:40:36
// Design Name: 
// Module Name: program_counter
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


module program_counter(
input wire clk,
input wire rst,
input wire pc_write,
input wire [31:0]next_pc,
output reg [31:0]pc_out
    );
    
    always @(posedge clk) begin
    if(rst) begin 
    pc_out <= 32'h0000_0000;
    end
    else if(pc_write) begin
    pc_out <= next_pc;
    end
    end
    
    
endmodule
