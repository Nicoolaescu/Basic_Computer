`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/20/2024 10:54:11 PM
// Design Name: 
// Module Name: Basic_computer
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


module Basic_computer(
    input logic clk_i,
    input logic reset_i,
    input logic [3:0] btn_i,
    output logic pwm_signal_o
    );
    
    logic [7:0] instr_mem_addr_read_wire;
    logic [31:0] data_read_wire;
//    logic [15:0] data_mem_data_read_wire;
//    logic [15:0] data_mem_addr_read_wire;
//    logic [15:0] data_mem_addr_write_wire;
//    logic [15:0] data_mem_data_write_wire;
//    logic data_mem_w_en_wire;
    
    logic [9:0] paddr_wire;
    logic p_write_wire; 
    logic penable_wire;
    logic [15:0] pwdata_wire;
    logic [15:0] prdata_wire, prdata_mem_wire, prdata_btn_wire, prdata_pwm_wire;
    logic pready_wire, pready_mem_wire, pready_pwm_wire, pready_btn_wire;
    
    logic [1:0] psel_wire;
    logic psel_pwm_wire;
    logic psel_btn_wire;
    logic psel_mem_wire;
    
    always_comb begin
        case(psel_wire) 
            00: begin //mem selecte
                    psel_pwm_wire = 0;
                    psel_btn_wire = 0;
                    psel_mem_wire = 1;
                end
            01: begin //pwm selected
                    psel_pwm_wire = 1;
                    psel_btn_wire = 0;
                    psel_mem_wire = 0;
                end
            10: begin //btn selected
                    psel_pwm_wire = 0;
                    psel_btn_wire = 1;
                    psel_mem_wire = 0;
                end
        endcase
    end
    
    always_comb begin
        case({psel_mem_wire, psel_pwm_wire, psel_btn_wire})
            3'b100 : pready_wire = pready_mem_wire;
            3'b010 : pready_wire = pready_pwm_wire;
            3'b001 : pready_wire = pready_btn_wire;
        endcase
    end
    
    always_comb begin
        case({psel_mem_wire, psel_pwm_wire, psel_btn_wire})
            3'b100 : prdata_wire = prdata_mem_wire;
            3'b010 : prdata_wire = prdata_pwm_wire;
            3'b001 : prdata_wire = prdata_btn_wire;
        endcase
    end
    
    data_mem data_mem1(
    .clk_i(clk_i),
//    .w_en_i(data_mem_w_en_wire),
//    .addr_read_i(data_mem_addr_read_wire),
//    .addr_write_i(data_mem_addr_write_wire),
//    .data_write_i(data_mem_data_write_wire),
    
//    .data_read_o(data_mem_data_read_wire)
    .paddr_i(paddr_wire),   
    .pwrite_i(pwrite_wire),        
    .psel_mem_i(psel_mem_wire),      
    .penable_i(penable_wire),       
    .pwdata_i(pwdata_wire), 
    
    .prdata_o(prdata_mem_wire),
    .pready_o(pready_mem_wire)        
    );
    
    instr_mem instr_mem1(
    .addr_read_i(instr_mem_addr_read_wire),
    
    .data_read_o(data_read_wire)
    );
    
    processor processor1(
    .instr_mem_data_read_i(data_read_wire),
    //.data_mem_data_read_i(data_mem_data_read_wire),
    .clk_i(clk_i),
    .reset_i(reset_i),
    
//    .data_mem_addr_read_o(data_mem_addr_read_wire),
//    .data_mem_addr_write_o(data_mem_addr_write_wire),
//    .data_mem_data_write_o(data_mem_data_write_wire),
    .instr_mem_addr_read_o(instr_mem_addr_read_wire),
//    .data_mem_w_en_o(data_mem_w_en_wire)
    .paddr_o(paddr_wire),
    .pwrite_o(pwrite_wire),
    .psel_mem_o(psel_wire),
    .penable_o(penable_wire),
    .pwdata_o(pwdata_wire),
    //.data_read_o(data_read_wire),
    .pready_i(pready_wire),
    .prdata_i(prdata_wire)
    );
    
    PWM_APB_SLAVE pwm_apb(
    .clk_i(clk_i),
    .reset_i(reset_i),
    .paddr_i(paddr_wire),
    .pwrite_i(pwrite_wire),
    .psel_pwm_i(psel_pwm_wire),
    .penable_i(penable_wire),
    .pwdata_i(pwdata_wire),
    
    .prdata_o(prdata_pwm_wire),
    .pready_o(pready_pwm_wire),
   
    .pwm_signal_o(pwm_signal_o)
    );
    
    BTN_APB_SLAVE btn_apb(
    .clk_i(clk_i),
    .reset_i(reset_i),
    .paddr_i(paddr_wire),
    .pwrite_i(pwrite_wire),
    .psel_btn_i(psel_btn_wire),
    .penable_i(penable_wire),
    .pwdata_i(pwdata_wire),
    
    .btn0_i(btn_i[0]),
    .btn1_i(btn_i[1]),
    .btn2_i(btn_i[2]),
    .btn3_i(btn_i[3]),
    
    .prdata_o(prdata_btn_wire),
    .pready_o(pready_btn_wire)
    );
    
    
    
endmodule
