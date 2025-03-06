`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 02:58:28 PM
// Design Name: 
// Module Name: PC
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


module PC(
    input logic clk_i,
    input logic reset_i,
    input logic en_i,
    input logic do_jump_i,
    input logic [7:0] jump_value_i,
    
    output logic [7:0] pc_o
    );
    
    logic [7:0] pc_value;
    
    always_ff@(posedge clk_i) begin
        if(reset_i) pc_value <= 0;
        else if(en_i) begin
            if(do_jump_i) pc_value <= jump_value_i;
            else pc_value <= pc_value + 1; 
        end
        else pc_value <= pc_value;
    end
    
    assign pc_o = pc_value;
    
endmodule
