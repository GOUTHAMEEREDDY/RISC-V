# RISC-V Single Cycle Processor (Verilog)

This project implements a **single-cycle RISC-V datapath**.  
Each instruction passes through all processor stages in **one clock cycle**.

Main modules included in the design:

### Program Counter (PC)
- Stores the address of the current instruction.
- Updates every clock cycle.

### Instruction Memory
- Stores instructions.
- Uses the program counter to fetch the current instruction.

### Control Unit
Decodes the instruction opcode and generates control signals such as:

- `RegWrite`
- `MemRead`
- `MemWrite`
- `MemtoReg`
- `ALUSrc`
- `ALUControl`

### Register File
- 32 general-purpose registers (`x0` to `x31`)
- Two read ports
- One write port

### Immediate Generator
Extracts immediate values from instructions such as:
- I-type instructions
- S-type instructions

### ALU (Arithmetic Logic Unit)
Performs arithmetic and logical operations like:

- ADD
- SUB
- AND
- OR

### Data Memory
Used for memory operations such as:

- `LW` (Load Word)
- `SW` (Store Word)

---

# Supported Instructions

The processor supports a subset of **RV32I instructions**.

| Instruction | Description |
|-------------|-------------|
| ADD | Register addition |
| SUB | Register subtraction |
| ADDI | Add immediate |
| AND | Bitwise AND |
| OR | Bitwise OR |
| LW | Load word from memory |
| SW | Store word to memory |

Branch and jump instructions are **not implemented** in this version.

---

# Example Program

Example instructions stored in instruction memory:

```
addi x1, x0, 5
addi x2, x0, 10
add  x3, x1, x2
```

This demonstrates:
- Register operations
- ALU computation
- Instruction execution flow

---
# Testbench

The file **`risc_v_tb.v`** acts as the simulation testbench.

It performs:
- Clock generation
- Reset initialization
- Processor execution for several cycles

Example clock generation:

```
always #5 clk = ~clk;
```

This creates a **10 ns clock period (100 MHz)**.

---

