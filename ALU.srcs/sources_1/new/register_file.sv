`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 06:19:54 PM
// Design Name: 
// Module Name: register_file
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


module register_file(
    input logic clk,
    input logic [3:0] addr_operand0,
    input logic [3:0] addr_operand1,
    input logic w_en,
    input logic [3:0] addr_result,
    input logic [15:0] data_write,
    
    output logic [15:0] operand0,
    output logic [15:0] operand1
    );
    
    logic [15:0] registers [0:15];
    
    always_ff@(posedge clk) begin
        if(w_en) begin
            registers[addr_result] <= data_write;
        end
    end
    
    assign operand0 = registers[addr_operand0];
    assign operand1 = registers[addr_operand1];
    
endmodule
