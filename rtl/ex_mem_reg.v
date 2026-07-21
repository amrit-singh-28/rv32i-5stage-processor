`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 10:08:34
// Design Name: 
// Module Name: ex_mem_reg
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


module ex_mem_reg(
input wire clk,
input wire rst,
input wire stall,
input wire flush,

input wire [32:0]pc_plus,
input wire [32:0]alu_result,
input wire [32:0]rs2_data,
input wire [4:0]rd_addr,
input wire [2:0]funct3,

input wire reg_write,
input wire mem_read,
input wire mem_write,
input wire [1:0]result_src,

output reg [32:0]pc_plus_o,
output reg [32:0]alu_result_o,
output reg [32:0]rs2_data_o,
output reg [4:0]rd_addr_o,
output reg [2:0]funct3_o,

output reg reg_write_o,
output reg mem_read_o,
output reg mem_write_o,
output reg [1:0]result_src_o
    );
    
always @(posedge clk) begin
if(rst || flush) begin
pc_plus_o <=32'd0;
alu_result_o <=32'd0;
rs2_data_o <=32'd0;
rd_addr_o <=5'd0;
funct3_o <=3'd0;
reg_write_o <=0;
mem_read_o <=0;
mem_write_o <=0;
result_src_o <=2'd0;
end

else if(stall) begin
pc_plus_o <= pc_plus;
alu_result_o <=alu_result;
rs2_data_o <=rs2_data;
rd_addr_o <=rd_addr;
funct3_o <=funct3;
reg_write_o <=reg_write;
mem_read_o <=mem_read;
mem_write_o <=mem_write;
result_src_o <=result_src;
end
end
endmodule
