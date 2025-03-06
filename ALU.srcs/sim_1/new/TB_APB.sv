`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2024 11:09:08 AM
// Design Name: 
// Module Name: TB_APB
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


module TB_APB(

    );
    
    logic clock;
    logic reset;
    
    Basic_computer dut(
    .clk_i(clock),
    .reset_i(reset)
    );
    
    
    initial begin
        clock = 0;
        forever #5 clock =~ clock;
    end
    
    initial begin
        reset <= 1;
        repeat (3) @(posedge clock);
        reset <= 0;
        #3000 $stop();
    end
    
    initial begin
        dut.instr_mem1.mem[0] = 32'b 1010_0011_0000_0000_0000_0000_0000_0101; //vload r3 5
        dut.instr_mem1.mem[1] = 32'b 1010_0100_0000_0000_0000_0000_0000_0111; //vload r4 7
        dut.instr_mem1.mem[2] = 32'b 0001_1010_0011_0100_0000_0000_0000_0000; //add r10 r3 r4
        
        dut.instr_mem1.mem[3] = 32'b 0010_1011_0100_0011_0000_0000_0000_0000; //sub r11 r4 r3
        
        dut.instr_mem1.mem[4] = 32'b 0011_1100_0100_0011_0000_0000_0000_0000; //mult r12 r4 r3
        
        dut.instr_mem1.mem[5] = 32'b 0100_1101_0100_0000_0000_0000_0000_0000; //shift 1 right r13 r4
        
        dut.instr_mem1.mem[6] = 32'b 1010_0101_0000_0000_0000_0000_0000_0111; //vload r5 7
        dut.instr_mem1.mem[7] = 32'b 1010_0110_0000_0000_0000_0000_0000_1110; //vload r6 14
        dut.instr_mem1.mem[8] = 32'b 0110_1110_0101_0110_0000_0000_0000_0000; //and r14 r5 r6
        dut.instr_mem1.mem[9] = 32'b 0111_1111_0101_0110_0000_0000_0000_0000; //or r15 r5 r6
        dut.instr_mem1.mem[10] = 32'b 1000_0000_0101_0110_0000_0000_0000_0000; //xor r0 r5 r6
        
        dut.instr_mem1.mem[11] = 32'b 1101_0000_1011_1010_0000_0000_0000_0000; //mem store: mem[R[10]] = R[11] -> mem[12] = 2
        dut.instr_mem1.mem[12] = 32'b 1110_0001_1010_0000_0000_0000_0000_0000; //mem load: R[1] = mem[R[10]] -> R[1] = 2
        
        dut.instr_mem1.mem[13] = 32'b 1011_0000_0000_0000_0000_0000_0001_1110; //jump 30 : PC = 30
        
        dut.instr_mem1.mem[30] = 32'b 0000_0000_0000_0000_0000_0000_0000_0000; //nop
        dut.instr_mem1.mem[31] = 32'b 1100_0001_1010_0000_0000_0000_0010_1000; //jmpz 40 : PC = 40
        dut.instr_mem1.mem[40] = 32'b 0000_0000_0000_0000_0000_0000_0000_0000; //nop
        
        dut.instr_mem1.mem[41] = 32'b 1111_0000_0000_0000_0000_0000_0000_0000; //halt
    end
endmodule
