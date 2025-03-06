`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 05:50:52 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input logic clk_i,
//    input logic w_en_i,
//    input logic [15:0] addr_read_i,
//    input logic [15:0] addr_write_i,
//    input logic [15:0] data_write_i,
    
//    output logic [15:0] data_read_o
    input logic [9:0] paddr_i,
    input logic pwrite_i,
    input logic psel_mem_i,
    input logic penable_i,
    input logic [15:0] pwdata_i,
    output logic [15:0] prdata_o,
    output logic pready_o
    );
    
    logic w_en_wire;            
    logic [9:0] addr_read_wire;
    logic [9:0] addr_write_wire;
    logic [15:0] data_write_wire;
                         
    logic [15:0] data_read_wire;
    
    logic [15:0] mem [0:1023];
    
    assign w_en_wire = pwrite_i & psel_mem_i & penable_i;
    assign data_write_wire = pwdata_i;
    
    always_comb begin
        if(pwrite_i == 1) begin // pwrite_i == 1 -> scriere
            addr_read_wire = 0;
            addr_write_wire = paddr_i;
        end else begin // pwrite_i == 0 -> citire
            addr_read_wire = paddr_i;
            addr_write_wire = 0;
        end
    end
    
    always_ff@(clk_i) begin
        if(w_en_wire) begin
            mem[addr_write_wire] <= data_write_wire;
        end
    end
    
    assign pready_o = 1;
    assign data_read_wire = mem[addr_read_wire];
    assign prdata_o = ((penable_i & ~pwrite_i) == 1) ? data_read_wire : 0;
    
endmodule
