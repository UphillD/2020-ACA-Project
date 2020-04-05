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
ACA_PATH=~/Projects/advcomparch

# Main directories
PAR_PATH=${ACA_PATH}/parsec-3.0       # Parsec folder

# ------------------------------------------------
# You should only have to change things above here
# ------------------------------------------------

# Workspace paths
WRK_PATH=${PAR_PATH}/parsec_workspace
OUT_PATH=${WRK_PATH}/outputs

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
    python plot_L2.py ${OUT_PATH}/L2/${bench}_L2*
    mv L2.png L2_${bench}.png
done
