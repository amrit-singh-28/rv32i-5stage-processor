`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2026 23:46:58
// Design Name: 
// Module Name: register
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


module register(
input wire clk,
input wire rst,
input wire reg_write,
input wire [4:0]rs1_addr,
input wire [4:0]rs2_addr,
input wire [4:0]rd_addr,
input wire [31:0]rd_data,
output wire [31:0]rs1_data,
output wire[31:0]rs2_data
    );
    
    reg [31:0] register[0:31];
    integer i;
    
    always@(posedge clk) begin
    if(rst) begin
    for(i=0; i<32; i=i+1) begin
    register [i] <= 32'b0;
    end
    end
    else if(reg_write && (rd_addr != 5'd0)) begin
    register[rd_addr] <= rd_data;
    end
    end
    
    assign rs1_data = (rs1_addr == 5'd0) ? 32'b0 : 
    (reg_write && (rd_addr == rs1_addr)) ? rd_data : register[rs1_addr];
    
    assign rs2_data = (rs2_addr == 5'd0) ? 32'b0 : 
    (reg_write && (rd_addr == rs2_addr)) ? rd_data : register[rs2_addr];
    
endmodule
