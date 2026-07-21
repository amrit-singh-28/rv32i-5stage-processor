`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 10:19:42
// Design Name: 
// Module Name: mem_wb_reg
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


module mem_wb_reg(
input wire clk,
input wire rst,
input wire stall,
input wire flush,

input wire [31:0]pc_plus,
input wire [31:0]alu_result,
input wire [31:0]mem_read_data,
input wire [4:0]rd_addr,
input wire reg_write,
input wire [1:0]result_src,

output reg [31:0]pc_plus_o,
output reg [31:0]alu_result_o,
output reg [31:0]mem_read_data_o,
output reg [4:0]rd_addr_o,
output reg reg_write_o,
output reg [1:0]result_src_o
    );
    
always @(posedge clk) begin
if(rst || flush) begin
pc_plus_o <= 32'd0;
alu_result_o <= 32'd0;
mem_read_data_o <=32'd0;
rd_addr_o <=5'd0;
reg_write_o <= 0;
result_src_o <= 2'd0;
end

else if(stall) begin
pc_plus_o <= pc_plus;
alu_result_o <=alu_result;
mem_read_data_o <= mem_read_data;
rd_addr_o <=rd_addr;
reg_write_o <=reg_write;
result_src_o <=result_src;
end
end
endmodule
