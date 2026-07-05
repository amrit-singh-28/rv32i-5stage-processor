`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2026 07:15:38
// Design Name: 
// Module Name: ALU
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


module ALU(
input wire [31:0]opa,
input wire [31:0]opb,
input wire [3:0]alu_ctrl,
output reg [31:0]out,
output wire zero_flag
    );

localparam ADD =4'd0;
localparam SUB = 4'd1;
localparam SLL = 4'd2;
localparam SLT = 4'd3;
localparam SLTU = 4'd4;
localparam XOR = 4'd5;
localparam SRL = 4'd6;
localparam SRA = 4'd7;
localparam OR = 4'd8;
localparam AND = 4'd9;

always @(*) begin
case(alu_ctrl) 

ADD : out = opa+opb;
SUB : out = opa-opb;
SLL : out = opa<<opb[4:0];
SLT : out = ($signed(opa)<$signed(opb)) ? {{31{1'b0}},1'b1} : {32{1'b0}};
SLTU : out = (opa<opb) ? {{31{1'b0}},1'b1} : {32{1'b0}};
XOR : out = opa^opb;
SRL : out = opa>>opb[4:0];
SRA : out = $signed(opa)>>>opb[4:0];
OR : out = opa|opb;
AND : out = opa&opb;
default : out = {32{1'b0}};

endcase
end

assign zero_flag = (out == 32'b0);

endmodule
