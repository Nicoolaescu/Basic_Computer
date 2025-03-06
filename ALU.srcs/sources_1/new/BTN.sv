`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 05:09:38 PM
// Design Name: 
// Module Name: BTN
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


module BTN(
    input logic clk_i,
    input logic reset_i,
    input logic btn0_i,
    input logic btn1_i,
    input logic btn2_i,
    input logic btn3_i,
    
    output logic [3:0] btn_array_o
    );
    
    logic [3:0] btn_array_mem;
    
    always_ff@(posedge clk_i) begin
        if(reset_i) btn_array_mem <= 0;
        else begin
            btn_array_mem[0] <= btn0_i;
            btn_array_mem[1] <= btn1_i;
            btn_array_mem[2] <= btn2_i;
            btn_array_mem[3] <= btn3_i;
        end
    end
    
    assign btn_array_o = btn_array_mem;
    
endmodule
