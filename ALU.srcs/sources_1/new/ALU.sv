`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2024 05:44:59 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input logic [3:0] opcode,
    input logic [15:0] operand0,
    input logic [15:0] operand1,
    output logic [15:0] result,
    output logic zero
    );
    
    always_comb begin
        case(opcode)
            0: result = 0;
            1: result = operand0 + operand1; //add
            2: result = operand0 - operand1; //subtr
            3: result = operand0 * operand1; //mult
            4: result = operand0 >> 1; //shift 1 right
            
            6: result = operand0 & operand1; //and
            7: result = operand0 | operand1; //or
            8: result = operand0 ^ operand1; //xor
            
            10: result = operand1; //value load
            11: result = operand1; //jmp
            12: result = operand1; //jmpz           
            13: result = operand0; //write mem (store)
            14: result = operand1; //read mem (load)
        
            default: result = 0;
        endcase
    end
    
    assign zero = ~(|result); //zero flag
    
endmodule
