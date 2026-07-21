`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 11:59:33
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
input wire [4:0]rs1_addr_ex_i,
input wire [4:0]rs2_addr_ex_i,
input wire [4:0]rd_addr_mem_i,
input wire reg_write_mem_i,
input wire [4:0]rd_addr_wb_i,
input wire reg_write_wb_i,
output wire [1:0]forward_a_o,
output wire [1:0]forward_b_o
    );
localparam fwd_none = 2'b0;
localparam fwd_ex_mem = 2'b01;
localparam fwd_mem_wb = 2'b10;

wire mem_match_valid = reg_write_mem_i &&(rd_addr_mem_i != 5'd0);
wire wb_match_valid = reg_write_wb_i &&(rd_addr_wb_i != 5'd0);
assign forward_a_o = (mem_match_valid && (rd_addr_mem_i == rs1_addr_ex_i)) ? fwd_ex_mem : (wb_match_valid && (rd_addr_wb_i == rs1_addr_ex_i)) ? fwd_mem_wb : fwd_none;
assign forward_b_o = (mem_match_valid && (rd_addr_mem_i == rs2_addr_ex_i)) ? fwd_ex_mem :(wb_match_valid  && (rd_addr_wb_i  == rs2_addr_ex_i)) ? fwd_mem_wb :fwd_none;

endmodule
