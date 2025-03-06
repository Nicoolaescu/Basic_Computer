`timescale 1ns / 1ps

module PWM(
    input logic clk_i,
    input logic reset_i,
    input logic stop_i,
    input logic [15:0] limit_period_i,
    input logic [15:0] limit_duty_i,
    
    output logic pwm_signal_o
    );
    
    logic [15:0] counter;
    
    always_ff@(posedge clk_i) begin
        if(reset_i | (counter >= (limit_period_i-1)) | stop_i) begin
            counter <= 0;
        end else counter <= counter + 1;
    end
    
    assign pwm_signal_o = (counter <= limit_duty_i);
    
endmodule
