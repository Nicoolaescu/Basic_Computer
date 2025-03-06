`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2024 06:01:04 PM
// Design Name: 
// Module Name: TB
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


module TB(

    );
    
    logic clock;
    logic reset;
    logic [3:0] btn;
    logic pwm_signal;
    
    Basic_computer dut(
    .clk_i(clock),
    .reset_i(reset),
    .btn_i(btn), 
    .pwm_signal_o(pwm_signal)
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
        //basic functions1 vload add sub mult ----- works
        dut.instr_mem1.mem[0] = 32'b1010_0011_0000_0000_0000_0000_0000_0101; //vload r3 5
        dut.instr_mem1.mem[1] = 32'b1010_0100_0000_0000_0000_0000_0000_0111; //vload r4 7
        dut.instr_mem1.mem[2] = 32'b0001_1010_0011_0100_0000_0000_0000_0000; //add r10 r3 r4
       
        dut.instr_mem1.mem[3] = 32'b0010_1011_0100_0011_0000_0000_0000_0000; //sub r11 r4 r3
       
        dut.instr_mem1.mem[4] = 32'b0011_1100_0100_0011_0000_0000_0000_0000; //mult r12 r4 r3
        //end basic functions1
        
        //basic functions2 shift and or xor ----- works
        dut.instr_mem1.mem[5] = 32'b0100_1101_0100_0000_0000_0000_0000_0000; //shift 1 right r13 r4
       
        dut.instr_mem1.mem[6] = 32'b1010_0101_0000_0000_0000_0000_0000_0111; //vload r5 7
        dut.instr_mem1.mem[7] = 32'b1010_0110_0000_0000_0000_0000_0000_1110; //vload r6 14
        dut.instr_mem1.mem[8] = 32'b0110_1110_0101_0110_0000_0000_0000_0000; //and r14 r5 r6
       
        dut.instr_mem1.mem[9] = 32'b0111_1111_0101_0110_0000_0000_0000_0000; //or r15 r5 r6
        
        dut.instr_mem1.mem[10] = 32'b1000_0000_0101_0110_0000_0000_0000_0000; //xor r0 r5 r6
        //end basic functions2
        
        //memstore memload ----- works
        dut.instr_mem1.mem[11] = 32'b1101_0000_1011_1010_0000_0000_0000_0000; //mem store: mem[R[10]] = R[11] -> mem[12] = 2
        dut.instr_mem1.mem[12] = 32'b1010_1010_0000_0000_0000_0000_0000_1100; //vload r10 12
        dut.instr_mem1.mem[13] = 32'b1110_0001_1010_0000_0000_0000_0000_0000; //mem load: R[1] = mem[R[10]] -> R[1] = 2
        //dut.instr_mem1.mem[11] = 32'b 0000_0000_0000_0000_0000_0000_0000_0000; //nop
        //dut.instr_mem1.mem[12] = 32'b 0000_0000_0000_0000_0000_0000_0000_0000; //nop
        dut.instr_mem1.mem[14] = 32'b0001_1010_0001_0001_0000_0000_0000_0000; //add r10 r1 r1
        //end memstore and memload
        
        //btn read test
        dut.instr_mem1.mem[15] = 32'b1010_0010_0000_0000_0000_1000_0000_0000; //vload r2 0
        dut.instr_mem1.mem[16] = 32'b1110_0011_0010_0000_0000_0000_0000_0000; //mem load: R[3] = mem[R[2]]
        dut.instr_mem1.mem[17] = 32'b1010_0010_0000_0000_0000_1000_0000_0001; //vload r2 1
        dut.instr_mem1.mem[18] = 32'b1110_0100_0010_0000_0000_0000_0000_0000; //mem load: R[4] = mem[R[2]]
        dut.instr_mem1.mem[19] = 32'b1010_0010_0000_0000_0000_1000_0000_0010; //vload r2 2
        dut.instr_mem1.mem[20] = 32'b1110_0101_0010_0000_0000_0000_0000_0000; //mem load: R[5] = mem[R[2]]
        dut.instr_mem1.mem[21] = 32'b1010_0010_0000_0000_0000_1000_0000_0011; //vload r2 3
        dut.instr_mem1.mem[22] = 32'b1110_0110_0010_0000_0000_0000_0000_0000; //mem load: R[6] = mem[R[2]]
        //end btn read
        
        
        //jump fucntions, nop, halt ----- works
        dut.instr_mem1.mem[15] = 32'b1011_0000_0000_0000_0000_0000_0001_1110; //jump 30 : PC = 30
       
        dut.instr_mem1.mem[30] = 32'b0000_0000_0000_0000_0000_0000_0000_0000; //nop
        dut.instr_mem1.mem[31] = 32'b1100_0001_1010_0000_0000_0000_0010_1000; //jmpz 40 : PC = 40
        dut.instr_mem1.mem[40] = 32'b0000_0000_0000_0000_0000_0000_0000_0000; //nop
       
        dut.instr_mem1.mem[41] = 32'b1111_0000_0000_0000_0000_0000_0000_0000; //halt
        //end jump, nop, halt
    end
    
endmodule
