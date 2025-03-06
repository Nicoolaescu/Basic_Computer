`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 06:30:38 PM
// Design Name: 
// Module Name: RALU
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


module RALU(
    input logic clk,
    input logic [3:0] opcode,
    input logic [3:0] addr_operand0,
    input logic [3:0] addr_operand1,
    input logic w_en,
    input logic [3:0] addr_result,
    input logic [15:0] data_mem_data_read,
    input logic [15:0] instr_value,
    
    output logic [15:0] operand0,
    output logic [15:0] operand1,
    output logic [15:0] result,
    output logic zero_flag
    );
    
    logic zero_wire;
    logic [15:0] op0_to_alu_wire;
    logic [15:0] op1_to_alu_wire;
    logic [15:0] op1_regfile_wire;
    logic [15:0] result_alu_to_regfile_wire;
    
    register_file register_file1(
    .clk(clk),
    .addr_operand0(addr_operand0),
    .addr_operand1(addr_operand1),
    .w_en(w_en),
    .addr_result(addr_result),
    .data_write(result_alu_to_regfile_wire),
    
    .operand0(op0_to_alu_wire),
    .operand1(op1_regfile_wire)
    );
    
    ALU ALU1(
    .opcode(opcode),
    .operand0(op0_to_alu_wire),
    .operand1(op1_to_alu_wire),
    .result(result_alu_to_regfile_wire),
    .zero(zero_wire)
    );
    
    assign op1_to_alu_wire = (opcode == 14) ?
                                 data_mem_data_read :
                                 (((opcode == 10) | 
                                 (opcode == 11) | 
                                 (opcode == 12)) ? 
                                    instr_value : op1_regfile_wire);
                                    
    assign result = result_alu_to_regfile_wire;
    assign operand1 = op1_to_alu_wire;
    assign operand0 = op0_to_alu_wire;
    always_ff@(posedge clk) zero_flag <= zero_wire;
    
    
    
endmodule
