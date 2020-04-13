# Advanced Computer Architecture, 2019-2020, 3.4.37.8
# 1st Assignment

# Plotting Code (L2)
# You shouldn't run this directly, run plotter_L2.sh instead.
# Dependencies: python, python-matplotlib

import sys
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

x_Axis = []
ipc_Axis = []
mpki_Axis = []

l2_size_base = 512.0
l2_assoc_base = 8.0

for outFile in sys.argv[3:]:
    fp = open(outFile)
    line = fp.readline()
    while line:
        tokens = line.split()
        if (line.startswith("Total Instructions: ")):
            total_instructions = int(tokens[2])
        elif (line.startswith("IPC:")):
            ipc = float(tokens[1])
        elif (line.startswith("  L2-Data Cache")):
            sizeLine = fp.readline()
            l2_size = float(sizeLine.split()[1])
            bsizeLine = fp.readline()
            l2_bsize = float(bsizeLine.split()[2])
            assocLine = fp.readline()
            l2_assoc = float(assocLine.split()[1])
        elif (line.startswith("L2-Total-Misses")):
            l2_total_misses = int(tokens[1])
            l2_miss_rate = float(tokens[2].split('%')[0])
            mpki = l2_total_misses / (total_instructions / 1000.0)

        line = fp.readline()

    fp.close()

    if sys.argv[1] == "true":
        size_reduction = float(np.log2(l2_size / l2_size_base))
        while (size_reduction > 0.0):
            ipc *= 0.90
            size_reduction -= 1.0
        assoc_reduction = float(np.log2(l2_assoc / l2_assoc_base))
        while (assoc_reduction > 0.0):
            ipc *= 0.95
            assoc_reduction -= 1.0

    l2ConfigStr = '{}K.{}.{}B'.format(int(l2_size),int(l2_assoc),int(l2_bsize))
    print(l2ConfigStr)
    x_Axis.append(l2ConfigStr)
    ipc_Axis.append(ipc)
    mpki_Axis.append(mpki)

print(x_Axis)
print(ipc_Axis)
print(mpki_Axis)

fig, ax1 = plt.subplots()
ax1.grid(True)
ax1.set_xlabel("L2 Cache Size.Associativity.Cache Block Size")

xAx = np.arange(len(x_Axis))
ax1.xaxis.set_ticks(np.arange(0, len(x_Axis), 1))
ax1.set_xticklabels(x_Axis, rotation=45)
ax1.set_xlim(-0.5, len(x_Axis) - 0.5)
ax1.set_ylim(min(ipc_Axis) - 0.05 * min(ipc_Axis), max(ipc_Axis) + 0.05 * max(ipc_Axis))
ax1.set_ylabel("$IPC$")
line1 = ax1.plot(ipc_Axis, label="IPC", color="red",marker='x')

ax2 = ax1.twinx()
ax2.xaxis.set_ticks(np.arange(0, len(x_Axis), 1))
ax2.set_xticklabels(x_Axis, rotation=45)
ax2.set_xlim(-0.5, len(x_Axis) - 0.5)
ax2.set_ylim(min(mpki_Axis) - 0.05 * min(mpki_Axis), max(mpki_Axis) + 0.05 * max(mpki_Axis))
ax2.set_ylabel("$MPKI$")
line2 = ax2.plot(mpki_Axis, label="L1D_MPKI", color="green",marker='o')

lns = line1 + line2
labs = [l.get_label() for l in lns]

plt.title(str(sys.argv[2]))
plt.suptitle("IPC vs MPKI")
lgd = plt.legend(lns, labs)
lgd.draw_frame(False)
plt.savefig("L2.png",bbox_inches="tight")
