`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 02:55:09 PM
// Design Name: 
// Module Name: Control_block
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


module Control_block(
    input logic [3:0] opcode_i,
    input logic zero_flag_i,
    input logic apb_pc_block_i,
    
    output logic ralu_w_en_o,
    output logic pc_en_o,
    output logic do_jump_o
    //output logic data_mem_w_en_o
    );
    
    logic opcode_halt_wire, apb_block_wire;
    //scheamticul se genereaza aiurea for no reason
    assign opcode_halt_wire = (opcode_i != 15);
    assign apb_block_wire = (~apb_pc_block_i);
    
    assign ralu_w_en_o = ((opcode_i == 1) | (opcode_i == 2) | (opcode_i == 3) | (opcode_i == 4) | (opcode_i == 6) | (opcode_i == 7) | (opcode_i == 8) | (opcode_i == 10) | (opcode_i == 14));
    assign pc_en_o = (opcode_halt_wire & apb_block_wire);
    assign do_jump_o = (opcode_i == 11) | ((opcode_i == 12) & (zero_flag_i));
    //assign data_mem_w_en_o = (opcode_i == 13);
    
endmodule
