#!/bin/bash

# Advanced Computer Architecture, 2019-2020, 3.4.37.8
# 1st Assignment

# Plotter Script (L2)
# Install python-matplotlib before running.

# This assumes a directory tree like the following:
# Main Project dir  ${ACA_PATH}
# ├ CSLab code dir  ${HLP_PATH}
# ├ Parsec dir      ${PAR_PATH}
# └ PIN dir         ${PIN_PATH}
# It also assumes that you used the bencher_L2.sh script for the benchmarks

# ------------------------------------------------
# You should only have to change things below here
# ------------------------------------------------

# Project directory
ACA_PATH="${ACA_PATH:-/home/uphill/Projects/advcomparch}" &> /dev/null

# Main directories
PAR_PATH="${PAR_PATH:-${ACA_PATH}/parsec-3.0}" &> /dev/null

# ------------------------------------------------
# You should only have to change things above here
# ------------------------------------------------

# Workspace paths
WRK_PATH=${PAR_PATH}/parsec_workspace
OUT_PATH=${WRK_PATH}/outputs/L2

# Benchmark array
declare -a BenchArray=(
        "blackscholes"
        "bodytrack"
        "canneal"
        "facesim"
        "ferret"
        "fluidanimate"
        "freqmine"
        "rtview"
        "streamcluster"
        "swaptions"
)

# Loop through the available benchmarks
for bench in "${BenchArray[@]}"; do
    python graph_L2.py "false" ${bench} ${OUT_PATH}/${bench}_L2*
    mv L2.png L2_${bench}.png
done

# Create the graphs for the second question
for bench in "${BenchArray[@]}"; do
    python graph_L2.py "true" "${bench}, IPC Reduction" ${OUT_PATH}/${bench}_L2*
    mv L2.png L2_${bench}_Red.png
done
