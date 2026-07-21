`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2026 09:39:24
// Design Name: 
// Module Name: if_id_reg
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


module if_id_reg(
input wire clk,
input wire rst,
input wire stall,
input wire flush,

input wire [31:0]pc,
input wire [31:0]pc_plus,
input wire [31:0]inst,

output reg [31:0]pc_o,
output reg [31:0]pc_plus_o,
output reg [31:0]inst_o
    );
    
always @(posedge clk) begin
if(rst || flush) begin
pc_o <= 32'd0;
pc_plus_o <= 32'd0;
inst_o <= 32'd0;
end

else begin
pc_o <= pc;
pc_plus_o <= pc_plus;
inst_o <= inst;
end
end
endmodule
