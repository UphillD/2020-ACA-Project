#!/bin/bash

# Advanced Computer Architecture, 2019-2020, 3.4.37.8
# 1st Assignment

# Script Launcher

# This assumes a directory tree like the following:
# Main Project dir  ${ACA_PATH}
# ├ CSLab code dir  ${HLP_PATH}
# ├ Parsec dir      ${PAR_PATH}
# └ PIN dir         ${PIN_PATH}

# ------------------------------------------------
# You should only have to change things below here
# ------------------------------------------------

# Project directory
ACA_PATH=~/Projects/advcomparch

# Main directories
HLP_PATH=${ACA_PATH}/ex1-helpcode     # CSLab Helper code & pintool
PAR_PATH=${ACA_PATH}/parsec-3.0       # Parsec folder
PIN_PATH=${ACA_PATH}/pin-3.13         # PIN folder

# ------------------------------------------------
# You should only have to change things above here
# ------------------------------------------------

export ACA_PATH
export HLP_PATH
export PAR_PATH
export PIN_PATH

echo Greetings!
echo "Would you like to execute a bencher script or a plotter script?"
echo "Please input your selection: (1: bencher, 2: plotter)"

read OPT1
case $OPT1 in
1)
    echo "bencher script selected!"
    SCRIPT=bencher_
    ;;
2)
    echo "plotter script selected!"
    SCRIPT=plotter_
    ;;
*)
    echo option not recognized, please try again!
    exit
    ;;
esac

echo "Please enter the memory level: (L1, L2, TLB, PRF)"

read OPT2
case $OPT2 in
L1)
    echo "L1 memory level selected!"
    LEVEL=L1
    ;;
L2)
    echo "L2 memory level selected!"
    LEVEL=L2
    ;;
TLB)
    echo "TLB memory level selected!"
    LEVEL=TLB
    ;;
PRF)
    echo "PRF memory level selected!"
    LEVEL=PRF
    ;;
*)
    echo "Memory level not recognized, please try again!"
    exit
    ;;
esac

echo "Launching $SCRIPT$LEVEL!"
echo
cd $LEVEL
./$SCRIPT$LEVEL.sh
