# SPI Slave with Single-Port RAM – Basys3 FPGA Implementation

##  Overview

This repository presents a modular SPI Slave design integrated with a single-port RAM, implemented on the Basys3 FPGA development board. The project includes Verilog source code, simulation scripts, constraint files, and detailed documentation. It is suitable for academic, research, and practical digital systems applications.


##  Repository Structure

### `codes_and_simulation_files/`

Design and simulation resources:

- `SPI.v`: Verilog source code for the SPI Slave module  
- `RAM.v`: Verilog implementation of the single-port RAM  
- `project2.v`: Top-level module integrating SPI and RAM  
- `project2_tb.v`: Testbench for verifying SPI-RAM interaction  
- `Constraints_basys3.xdc`: Xilinx constraints file for Basys3 pin assignments  
- `run.do`: ModelSim simulation script  

### `project_results/`

Project documentation and results:

- `SPI_with_single_port_RAM.docx`: Includes waveform captures, timing analysis, and implementation outcomes  

---

##  Tools & Environment

- **Xilinx Vivado**: Design entry, synthesis, implementation, and bitstream generation  
- **ModelSim**: Simulation and waveform analysis  

---

##  Getting Started

### Simulation

1. Launch ModelSim  
2. Load `project2_tb.v` and execute the `run.do` script  
3. Observe SPI transactions and RAM behavior in the waveform viewer  

### FPGA Implementation

1. Create a new Vivado project  
2. Add `project2.v`, `SPI.v`, `RAM.v`, and `Constraints_basys3.xdc` to the project  
3. Run synthesis and implementation, then generate the bitstream file  
4. Program the Basys3 FPGA board with the generated bitstream  

---

##  Authors

**Mennatu-Allah Abd Elfattah**  
Final-year Electronics & Communications Engineering student, Helwan University  
Specialization: Digital Systems

**[Monaya Wael]**  
Final-year Electronics & Communications Engineering student, Helwan University  
Specialization: Digital Systems

---