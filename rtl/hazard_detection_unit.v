`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2026 11:31:28
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection_unit (
input wire mem_read_ex_i,
input wire [4:0] rd_addr_ex_i,   
input wire [4:0] rs1_addr_id_i,   
 input wire [4:0] rs2_addr_id_i,   
output wire stall_o
);
wire rd_ex_nonzero = (rd_addr_ex_i != 5'd0);
wire rs1_matches = (rd_addr_ex_i == rs1_addr_id_i);
wire rs2_matches = (rd_addr_ex_i == rs2_addr_id_i);
assign stall_o = mem_read_ex_i && rd_ex_nonzero && (rs1_matches || rs2_matches);
endmodule
