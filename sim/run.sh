#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "Compiling..."
mkdir -p build waves
iverilog -g2012 -o build/sipo_tb.vvp src/sipo.v tb/sipo_tb.sv

echo "Running..."
vvp build/sipo_tb.vvp

echo "VCD: $(realpath waves/sipo_tb.vcd)"

if command -v gtkwave >/dev/null 2>&1; then
  echo "Opening GTKWave..."
  gtkwave waves/sipo_tb.vcd >/dev/null 2>&1 &
else
  echo "Tip: sudo apt-get install -y gtkwave"
fi
