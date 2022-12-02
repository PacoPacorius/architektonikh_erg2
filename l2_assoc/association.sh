# #!/bin/bash
command_location="${HOME}/university/architectoniki/spec_cpu2006"
command="${command_location}/470.lbm/src/speclibm -o \"${command_location}/470.lbm/data/lbm.in 0 1
spec_cpu2006/470.lbm/data/100_100_130_cf_a.of\""
benchmark="specsjeng_l2_4MB"
testVariable="l2_assoc"

# command=$1
# benchmark=$3
# testVariable=$2
gem5="${HOME}/gem5"

options="--cpu-type=MinorCPU --caches --l2cache --l2_size 4MB"

for assosiation in 1 2 4 8
do
    ${gem5}/build/ARM/gem5.opt -d ${benchmark}/assoc${assosiation} ${gem5}/configs/example/se.py ${options} --${testVariable} ${assosiation} -c ${command} -I 100000000 &
done