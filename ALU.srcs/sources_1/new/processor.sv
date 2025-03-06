`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 03:03:17 PM
// Design Name: 
// Module Name: processor
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


module processor(
    input logic [31:0] instr_mem_data_read_i,
//    input logic [15:0] data_mem_data_read_i,
    input logic clk_i,
    input logic reset_i,
    
    input [15:0] prdata_i,
    input pready_i,

    
//    output logic [15:0] data_mem_addr_read_o,
//    output logic [15:0] data_mem_addr_write_o,
//    output logic [15:0] data_mem_data_write_o,
    output logic [7:0] instr_mem_addr_read_o,
//    output logic data_mem_w_en_o
    
    output logic [9:0] paddr_o,
    output logic pwrite_o,
    output logic [1:0] psel_mem_o,
    output logic penable_o,
    output logic [15:0] pwdata_o
    //output logic [15:0] data_read_o
    
    );
    
    logic [3:0] opcode_wire;
    logic ralu_w_en_wire;
    logic pc_en_wire;
    logic do_jump_wire;
    logic data_mem_w_en_wire;
    logic [3:0] addr_operand0_wire;
    logic [3:0] addr_operand1_wire;
    logic [15:0] instr_value_wire;
    logic [3:0] addr_result_wire;
    logic [15:0] ralu_result_wire;
    logic ralu_zero_f_wire;
    
    logic [15:0] data_mem_addr_read_wire;
    logic [15:0] data_mem_addr_write_wire;
    logic [15:0] data_mem_data_write_wire;
    logic [7:0] instr_mem_addr_read_wire;       
    logic [15:0] data_mem_data_read_wire;  
    logic apb_pc_block_wire;    
    logic wr_access_wire, rd_access_wire;  
    
    assign opcode_wire = instr_mem_data_read_i[31:28];
    assign addr_operand0_wire = instr_mem_data_read_i[23:20];
    assign addr_operand1_wire = instr_mem_data_read_i[19:16];
    assign instr_value_wire = instr_mem_data_read_i[15:0];
    assign addr_result_wire = instr_mem_data_read_i[27:24];
    
    assign rd_access_wire = (opcode_wire == 14);
    assign wr_access_wire = (opcode_wire == 13);
    
    Control_block Control_block1(
    .opcode_i(opcode_wire),
    .zero_flag_i(ralu_zero_f_wire),
    .apb_pc_block_i(apb_pc_block_wire),
   
    .ralu_w_en_o(ralu_w_en_wire),
    .pc_en_o(pc_en_wire),
    .do_jump_o(do_jump_wire)
    //.data_mem_w_en_o(data_mem_w_en_wire)
    );
    
    RALU RALU1(
    .clk(clk_i),
    .opcode(opcode_wire),
    .addr_operand0(addr_operand0_wire),
    .addr_operand1(addr_operand1_wire),
    .w_en(ralu_w_en_wire),
    .addr_result(addr_result_wire),
    .data_mem_data_read(data_mem_data_read_wire),
    .instr_value(instr_value_wire),
    
    .operand0(data_mem_addr_read_wire),
    .operand1(data_mem_addr_write_wire),
    .result(ralu_result_wire),
    .zero_flag(ralu_zero_f_wire)
    );
    
    PC PC1(
    .clk_i(clk_i),
    .reset_i(reset_i),
    .en_i(pc_en_wire),
    .do_jump_i(do_jump_wire),
    .jump_value_i(ralu_result_wire[7:0]),
    
    .pc_o(instr_mem_addr_read_wire)
    );
    
    APBMaster APBMaster1(
    .clk_i(clk_i),
    .reset_i(reset_i),
    
    .prdata_i(prdata_i),
    .pready_i(pready_i),
    
    .paddr_o(paddr_o),
    .pwrite_o(pwrite_o),
    .psel_mem_o(psel_mem_o),
    .penable_o(penable_o),
    .pwdata_o(pwdata_o),
    
    .addr_read_i(data_mem_addr_read_wire),
    .addr_write_i(data_mem_addr_write_wire),
    .data_write_i(data_mem_data_write_wire),
    .wr_access_i(wr_access_wire),
    .rd_access_i(rd_access_wire),
    .data_read_o(data_mem_data_read_wire),
    
    .block_pc_o(apb_pc_block_wire)
    );
    
//    assign data_read_o = data_mem_data_read_wire;
    assign instr_mem_addr_read_o = instr_mem_addr_read_wire;
    assign data_mem_data_write_wire = ralu_result_wire;
    
endmodule
