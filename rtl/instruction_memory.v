`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.07.2026 07:10:56
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input wire [31:0]addr,
    output wire [31:0]inst
);

localparam NUM_WORDS = 1024 / 4;
localparam ADDR_WIDTH = $clog2(NUM_WORDS);

reg [31:0] mem[NUM_WORDS-1:0];

initial begin
$readmemh("program.hex",mem);
end

assign inst = mem[addr[ADDR_WIDTH+1:2]];
endmodule
