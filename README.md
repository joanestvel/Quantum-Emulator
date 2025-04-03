# Quantum Emulator

This project aims to build an FPGA-based quantum emulator capable of simulating quantum algorithms with up to 32 qubits. The goal is to extend beyond 32 qubits in the future, once the initial implementation is successful.

## Project Status
A 16-qubit prototype has been tested to validate the concept. The next step is to complete the full design and conduct more extensive testing, including different instances of Grover's and Shor's algorithms, among others.

## Project Hierarchy
```
QEMU
├── Quantum_Processor
│   ├── Quantum_Core
│   │   ├── QS
│   │   │   └── MultC
│   │   └── Quantum_Gates
│   ├── ADDRGen
│   └── FSM
```

Additionally, the project requires the `types.vhd` file, which defines constants used throughout the design, including gate definitions, sizes, and other parameters.

## Repository Structure
```
/repository_root
├── docs/               # Documentation files
│   ├── Quantum Emulator Architecture.pptx
│
├── src/                # VHDL source files
│   ├── ADDRGen.vhd
│   ├── FSM.vhd
│   ├── MultC.vhd
│   ├── QEMU.vhd
│   ├── QS.vhd
│   ├── Quantum_Core.vhd
│   ├── Quantum_Gates.vhd
│   ├── Quantum_Processor.vhd
│   ├── types.vhd
│
├── README.md           # Project documentation
```

## Usage
The usage details are still under development and will be provided as the project progresses.

## License
This project follows the MIT license.

