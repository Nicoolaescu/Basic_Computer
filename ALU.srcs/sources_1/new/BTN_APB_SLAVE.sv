`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 05:16:40 PM
// Design Name: 
// Module Name: BTN_APB_SLAVE
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


module BTN_APB_SLAVE(
    input logic clk_i,
    input logic reset_i,
    input logic [9:0] paddr_i,
    input logic pwrite_i,
    input logic psel_btn_i,
    input logic penable_i,
    input logic [15:0] pwdata_i,
    
    input logic btn0_i,
    input logic btn1_i,
    input logic btn2_i,
    input logic btn3_i,
    
    output logic [15:0] prdata_o,
    output logic pready_o
    );
    
    logic [3:0] btn_array_wire;
    logic [15:0] prdata_wire;
    
    BTN BTN1(
    .clk_i(clk_i),
    .reset_i(reset_i),
    .btn0_i(btn0_i),
    .btn1_i(btn1_i),
    .btn2_i(btn2_i),
    .btn3_i(btn3_i),
    
    .btn_array_o(btn_array_wire)
    );
    
    assign pready_o = 1;
    assign prdata_wire = {12'b0000_0000_0000, btn_array_wire};
    assign prdata_o = (~pwrite_i & psel_btn_i & penable_i) ? prdata_wire : 0;
    
endmodule
