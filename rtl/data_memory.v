`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2026 09:31:44
// Design Name: 
// Module Name: data_memory
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


module data_memory(
input wire clk,
input wire mem_read,
input wire mem_write,
input wire [31:0]write_data,
input wire[31:0]addr,
input wire[2:0]funct3,
output reg[31:0]read_data
    );
localparam BYTE = 3'b000;
localparam HALF = 3'b001;
localparam WORD = 3'b010;
localparam BU = 3'b100;
localparam HU = 3'b101;

reg [7:0]mem [0:1023];
integer i;
initial begin
for(i=0; i<1024; i=i+1) begin
mem[i]=8'b0;
end
end

wire [9:0] idx0 = addr[9:0];
wire [9:0] idx1 = addr[9:0]+1'd1;
wire [9:0] idx2 = addr[9:0]+2'd2;
wire [9:0] idx3 = addr[9:0]+2'd3;

always @(posedge clk) begin
if(mem_write) begin
case(funct3)
BYTE : begin
mem[idx0] <= write_data[7:0];
end
HALF : begin
mem[idx0] <= write_data[7:0];
mem[idx1] <= write_data[15:8];
end
WORD : begin
mem[idx0] <= write_data[7:0];
mem[idx1] <=write_data[15:8];
mem[idx2] <= write_data[23:16];
mem[idx3] <= write_data[31:24];
end
endcase
end
end

always @(*) begin
if(mem_read) begin
case(funct3)
BYTE : read_data = {{24{mem[idx0][7]}},mem[idx0]};
HALF : read_data = {{16{mem[idx1][7]}},mem[idx1],mem[idx0]};
WORD : read_data = {mem[idx3],mem[idx2],mem[idx1],mem[idx0]};
BU : read_data = {{24{1'b0}},mem[idx0]};
HU : read_data = {{16{1'b0}},mem[idx1],mem[idx0]};
default : read_data = 32'b0;
endcase
end
else read_data = 32'b0;
end
endmodule
