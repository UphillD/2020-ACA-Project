# Advanced Computer Architecture, Helper Scripts

This is a collection of helper scripts and codes for the 1st assignment for the course "Advanced Computer Architecture", 2019-2020, 3.4.37.8.

## Prerequisites

You need to follow all the installation instructions as mentioned in the assignment.

By the end you should have the following directory tree:

    Main Project directory            ${ACA_PATH}
    ├ CSLab "Helper" Code directory   ${HLP_PATH}
    ├ Parsec directory                ${PAR_PATH}
    └ PIN directory                   ${PIN_PATH}

The names in the curly brackets are the names of the paths you have to change in the scripts.

## Necessary changes

You will need to make the following changes in the pintool code, according to the advcomparch mailing list:

1. In the `<CSLab Code directory>/pintool/cache.h`, make the following changes:

        207:  UINT32 l1HitLatency = 1, UINT32 l2HitLatency = 15,
        208:  UINT32 l2MissLatency = 250);

2. In the `<CSLab Code directory>/pintool/tlb.h`, make the following change:

        163:  UINT32 HitLatency = 0, UINT32 MissLatency = 100);

You then have to remake the simulator tool:

    make clean; make

## Installation

1. Clone the repository, preferably to the Main Project directory mentioned above:

        $ git clone https://github.com/UphillD/advcomparch-2020-helpers.git

2. Edit the \*.sh files with the appropriate paths.

3. Make the \*.sh files executable:

        $ chmod +x *.sh

## Usage

Simply execute the script you wish to use, e.g.:

    $ ./bencher_L1.sh

The bencher scripts will run every benchmark with every configuration of the appropriate memory level (L1, L2, ..), and place their outputs in the path:

    <parsec_workspace>/outputs/<memory level>/

The plotter scripts will produce the graphs for every benchmark with every configuration of the appropriate memory level (L1, L2, ..) in the folder they are executed from.

They will also produce the same graphs if there was a 5% and 10% IPC reduction in place for every doubling of the memory capacity or associtivity. Those graphs can be distinguished by the `_5pt` and `_10pt` suffixes.

*Important Note: There is a simple check in place to avoid rerunning the same benchmarks; if the output for the current benchmark already exists, and it's not the last one in the folder, it is skipped.*
