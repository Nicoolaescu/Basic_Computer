A basic computer made using system verilog in Vivado.

The module has following specs:
* a RISC processor
* Harvard architecture
* instruction memory of [0:255] x 32bit size
* data memory of [0:65_535] x 16bit size
* RAM of 16 x 16bit size
* APB protocol comunicaton with peripherals
* PWM slave
* Button array slave
                          Command 
Opcode     Destination     Operand0     Operand1     Value 
              addr           addr         addr       Value 
  4b           4b             4b           4b         16b
  
Opcode                 Operation                              Description
0  NOP                 ---  
1  ADD                 R[dest] = R[op0_addr] + R[op1_addr]  
2  SUB                 R[dest] = R[op0_addr] - R[op1_addr]  
3  MULT                R[dest] = R[op0_addr] * R[op1_addr]  
4  SHIFT 1 RIGHT       R[dest] = R[op1_addr] >> 1;  
5    
6  AND                 R[dest] = R[op0_addr] & R[op1_addr]  
7  OR                  R[dest] = R[op0_addr] | R[op1_addr]  
8  XOR                 R[dest] = R[op0_addr] ^ R[op1_addr]  
9    
10 VALUE LOAD          R[dest] = value_from_instr             alu passes operand1 
11 JMP                 PC = value_from_instr                  alu passes operand1 
12 JMPZ if Z_flag:     PC = value_from_instr                  alu passes operand1 
13 WRITE MEM (STORE)   mem[R[op1_addr]] = R[op0_addr]         alu passes operand 0 
14 READ MEM (LOAD)     R[dest] = mem[R[op0_addr]]             alu passes operand1 
15 HALT PC = PC; 
