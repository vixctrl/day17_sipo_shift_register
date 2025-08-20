Day 17: SIPO (Serial-In Parallel-Out) Shift Register Design and Verification
Objective

Design and verify a 4-bit Serial-In Parallel-Out (SIPO) shift register in Verilog that takes serial input data and outputs it in parallel after successive clock cycles.

Tools

Icarus Verilog (Simulation)

GTKWave (Waveform Analysis)

Files

src/sipo.v - RTL Design

src/sipo_tb.v - Testbench

run.sh - Compilation and Simulation script

sipo.vcd - Waveform dump file

Simulation Steps

Compile the Verilog files using Icarus Verilog.

Run the simulation to generate sipo.vcd.

Open the waveform in GTKWave to analyze behavior.

Expected Behavior

On each clock pulse, the serial input bit is shifted into the register.

After 4 clock cycles, the register contains the 4-bit parallel output.

Reset clears the register.

Output

Waveform shows:

Serial data (e.g., 1, 0, 1, 1) shifted in bit by bit.

After 4 cycles, parallel output shows 1011.

Register shifting behavior is visible at every clock edge.

Reset brings the parallel output back to 0000.
