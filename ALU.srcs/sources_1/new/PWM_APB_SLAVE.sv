`timescale 1ns / 1ps

module PWM_APB_SLAVE(
    input logic clk_i,
    input logic reset_i,
    input logic [9:0] paddr_i,
    input logic pwrite_i,
    input logic psel_pwm_i,
    input logic penable_i,
    input logic [15:0] pwdata_i,
    
    output logic [15:0] prdata_o,
    output logic pready_o,
    
    output logic pwm_signal_o
    );
    
    logic [15:0] limit_period_reg;
    logic [15:0] limit_duty_reg;
    logic [15:0] stop_reg;
    
    logic w_en_wire;            
    logic [9:0] addr_read_wire;
    logic [15:0] data_write_wire;
    logic [9:0] addr_write_wire;                     
    logic [15:0] data_read_wire;
    
    logic limit_duty_en, conf_en, limit_period_en;
    
    assign w_en_wire = pwrite_i & psel_pwm_i & penable_i;
    assign data_write_wire = pwdata_i;
    assign limit_duty_en = w_en_wire & (paddr_i == 2);
    assign conf_en = w_en_wire & (paddr_i == 0);
    assign limit_period_en = w_en_wire & (paddr_i == 1);
    assign pready_o = 1;
    assign prdata_o = (~pwrite_i & psel_pwm_i & penable_i) ? data_read_wire : 0;
    
    always_ff@(clk_i) begin
        if(reset_i) begin
            limit_period_reg <= 0;
            limit_duty_reg   <= 0;
            stop_reg         <= 0;
        end else begin
            if(conf_en == 1) stop_reg <= pwdata_i;
            if(limit_duty_en) limit_duty_reg <= pwdata_i;
            if(limit_period_en) limit_period_reg <= pwdata_i;
        end
    end
    
    always_comb begin
        case(paddr_i[1:0])
            0: data_read_wire = stop_reg;
            1: data_read_wire = limit_period_reg;
            2: data_read_wire = limit_duty_reg;
            default: data_read_wire = 0;
        endcase
    end
    
    PWM PWM1(
    .clk_i(clk_i),
    .reset_i(reset_i),
    .stop_i(stop_reg[0]),
    .limit_period_i(limit_period_reg),
    .limit_duty_i(limit_duty_reg),
    
    .pwm_signal_o(pwm_signal_o)
    );
    
endmodule
