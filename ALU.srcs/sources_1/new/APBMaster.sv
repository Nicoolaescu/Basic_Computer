`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2024 05:46:24 PM
// Design Name: 
// Module Name: APBMaster
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


module APBMaster(
    input logic clk_i,
    input logic reset_i,
    
    input logic [15:0] prdata_i,
    input logic pready_i,
    
    output logic [9:0] paddr_o,
    output logic pwrite_o,
    output logic [1:0] psel_mem_o,
    output logic penable_o,
    output logic [15:0] pwdata_o,
    
    input logic [15:0] addr_read_i,
    input logic [15:0] addr_write_i,
    input logic [15:0] data_write_i,
    input logic wr_access_i,
    input logic rd_access_i,
    output logic [15:0] data_read_o,
    
    output logic block_pc_o
    );
    
    localparam [1:0] idle = 0;
    localparam [1:0] setup = 1;
    localparam [1:0] access = 2;
    
    logic [1:0] state, state_next;
    logic [15:0] addr_wire;
    
    assign addr_wire = (wr_access_i == 1) ? addr_write_i : addr_read_i;
    always_ff@(posedge clk_i) begin
        if(reset_i == 1) begin
            state <= idle;
        end else state <= state_next;
        
       
    end
    
    always_comb begin
        state_next = state;
        case(state)
        idle: begin
            if(wr_access_i | rd_access_i) state_next = setup;
        end
        setup: begin
            state_next = access;
        end
        access: begin
            if(pready_i == 1) begin
                if(wr_access_i | rd_access_i) state_next = setup;
                else state_next = idle;
            end
        end
        endcase
    end
    
    always_comb begin
        paddr_o     = 0;
        pwrite_o    = 0;
        psel_mem_o  = 0;
        penable_o   = 0;
        pwdata_o    = 0;
        data_read_o = 0;
        block_pc_o  = 0;
        
        case(state) 
        idle: begin
            if(wr_access_i | rd_access_i) block_pc_o = 1;
        end
        setup: begin
            paddr_o     = addr_wire[9:0];
            pwrite_o    = wr_access_i;
            psel_mem_o  = addr_wire[11:10];
            penable_o   = 0;
            pwdata_o    = data_write_i;
            data_read_o = 0;
            block_pc_o  = 1;
        end
        access: begin
            paddr_o     = addr_wire[9:0];
            pwrite_o    = wr_access_i;
            psel_mem_o  = addr_wire[11:10];
            penable_o   = 1;
            pwdata_o    = data_write_i;
            data_read_o = (rd_access_i & pready_i) ? prdata_i : 0;
            block_pc_o  = ~pready_i;
        end
        endcase
    end 
    
endmodule
