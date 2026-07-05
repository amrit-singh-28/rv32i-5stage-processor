`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2026 03:19:08
// Design Name: 
// Module Name: alu_control
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


module alu_control(
input  wire [6:0] opcode, 
input  wire [2:0] funct3,    
input  wire funct7,  
output reg  [3:0] alu_ctrl
    );
localparam r_type = 7'b0110011;
localparam i_type = 7'b0010011;
localparam b_type = 7'b1100011;

localparam ADD  = 4'b0000;
localparam SUB  = 4'b0001;
localparam SLL  = 4'b0010;
localparam SLT  = 4'b0011;
localparam SLTU = 4'b0100;
localparam XOR  = 4'b0101;
localparam SRL  = 4'b0110;
localparam SRA  = 4'b0111;
localparam OR   = 4'b1000;
localparam AND  = 4'b1001;

always @(*) begin
case(opcode)
r_type : begin
    case(funct3)
    3'b000 : alu_ctrl = funct7 ? SUB : ADD;
    3'b001 : alu_ctrl = SLL;
    3'b010 : alu_ctrl = SLT;
    3'b011 : alu_ctrl = SLTU;
    3'b100 : alu_ctrl = XOR;
    3'b101 : alu_ctrl = funct7 ? SRA : SRL;
    3'b110 : alu_ctrl = OR;
    3'b111 : alu_ctrl = AND;
    default : alu_ctrl = ADD;
    endcase
    end
i_type : begin
    case(funct3)
    3'b000 : alu_ctrl = ADD;
    3'b001 : alu_ctrl = SLL;
    3'b010 : alu_ctrl = SLT;
    3'b011 : alu_ctrl = SLTU;
    3'b100 : alu_ctrl = XOR;
    3'b101 : alu_ctrl = funct7 ? SRA : SRL;
    3'b110 : alu_ctrl = OR;
    3'b111 : alu_ctrl = AND;
    default : alu_ctrl = ADD;
    endcase
    end
b_type : begin
    case(funct3)
    3'b000 : alu_ctrl = SUB;
    3'b001: alu_ctrl = SUB;
    3'b100: alu_ctrl = SLT;
    3'b101: alu_ctrl = SLT;
    3'b110: alu_ctrl = SLTU;
    3'b111: alu_ctrl = SLTU;
    endcase
    end
default : alu_ctrl = ADD;
endcase
end
endmodule
