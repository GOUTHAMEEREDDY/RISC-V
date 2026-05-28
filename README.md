# RISC-V Single Cycle Processor (Verilog)

A single-cycle RISC-V processor datapath implemented in Verilog HDL. Each instruction completes execution in one clock cycle, passing through all processor stages — fetch, decode, execute, memory, and write-back — without pipelining.

---

## 📁 Repository Structure

```
RISC-V/
├── src/
│   ├── PC.v                    # Program Counter
│   ├── alu.v                   # Arithmetic Logic Unit
│   ├── control_unit.v          # Control signal decoder
│   ├── data_memory.v           # Data memory (LW/SW)
│   ├── immediate_generator.v   # Immediate value extractor
│   ├── instruction_memory.v    # Instruction memory
│   ├── register_file.v         # 32 general-purpose registers
│   └── top_module.v            # Top-level integration
├── tb/
│   └── risc_v_tb.v             # Simulation testbench
├── docs/
│   └── Waveform_RISC-V.png     # Simulation output waveform
└── README.md
```

---

## 🧩 Module Descriptions

### Program Counter (`PC.v`)
Stores the address of the current instruction and increments by 4 every clock cycle to point to the next instruction.

### Instruction Memory (`instruction_memory.v`)
Read-only memory that stores the program instructions. Fetches the instruction at the address provided by the PC.

### Control Unit (`control_unit.v`)
Decodes the instruction opcode and generates the following control signals:

| Signal | Purpose |
|---|---|
| `RegWrite` | Enables writing to the register file |
| `MemRead` | Enables reading from data memory |
| `MemWrite` | Enables writing to data memory |
| `MemtoReg` | Selects between ALU result and memory data for writeback |
| `ALUSrc` | Selects between register value and immediate for ALU input |
| `ALUControl` | Selects the ALU operation |

### Register File (`register_file.v`)
Contains 32 general-purpose registers (`x0` to `x31`) with two read ports and one write port. `x0` is hardwired to zero.

### Immediate Generator (`immediate_generator.v`)
Extracts and sign-extends immediate values from I-type and S-type instruction encodings.

### ALU (`alu.v`)
Performs arithmetic and logical operations: ADD, SUB, AND, OR. Also produces a `zero` flag used for branch decisions.

### Data Memory (`data_memory.v`)
Supports `LW` (Load Word) and `SW` (Store Word) memory operations.

### Top Module (`top_module.v`)
Integrates all the above modules and wires them together to form the complete single-cycle datapath.

---

## ✅ Supported Instructions

Implements a subset of the **RV32I** base instruction set:

| Instruction | Type | Description |
|---|---|---|
| `ADD` | R | Register addition |
| `SUB` | R | Register subtraction |
| `AND` | R | Bitwise AND |
| `OR` | R | Bitwise OR |
| `ADDI` | I | Add immediate |
| `LW` | I | Load word from memory |
| `SW` | S | Store word to memory |

> Branch and jump instructions are not implemented in this version.

---

## 💡 Example Program

Instructions stored in instruction memory:

```
addi x1, x0, 5     # x1 = 5
addi x2, x0, 10    # x2 = 10
add  x3, x1, x2    # x3 = 15
sw   x3, 0(x0)     # store x3 to memory[0]
lw   x4, 0(x0)     # load memory[0] into x4
```

---

## 🖥️ How to Simulate

**Using ModelSim:**
1. Create a new project and add all `.v` files
2. Compile all sources
3. Simulate `risc_v_tb`
4. View waveforms in the Wave window

**Using Icarus Verilog (free):**
```bash
iverilog -o riscv_sim src/*.v tb/risc_v_tb.v
vvp riscv_sim
```

**Using EDA Playground** (no installation needed):
- Upload all `.v` files at [edaplayground.com](https://www.edaplayground.com)
- Select Icarus Verilog as the simulator and run

---

## 🔭 Future Improvements

- [ ] Add branch instructions (BEQ, BNE)
- [ ] Add jump instructions (JAL, JALR)
- [ ] Extend to a pipelined (5-stage) implementation
- [ ] Add hazard detection and forwarding unit
- [ ] Support more RV32I instructions

---

## 🛠️ Tools Used

- Verilog HDL (IEEE 1364-2001)
- ModelSim / Icarus Verilog
