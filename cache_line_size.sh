# #!/bin/bash
command_location="${HOME}/university/architectoniki/spec_cpu2006"
command="${command_location}/456.hmmer/src/spechmmer -o ${command_location}/456.hmmer/data/bombesin.hmm"
benchmark="cache_line/spechmmer_l2_4MB_l2_assoc_2_l1i_l1d_128kB"
testVariable="cacheline_size"

# command=$1
# benchmark=$3
# testVariable=$2
gem5="${HOME}/gem5"

options="--cpu-type=MinorCPU --caches --l2cache --l2_size 4MB --l2_assoc 2 --l1d_size 128kB --l1i_size 128kB"

for assosiation in 32 64 128 256 512
do
    ${gem5}/build/ARM/gem5.opt -d ${benchmark}/cache_line_size${assosiation} ${gem5}/configs/example/se.py ${options} --${testVariable} ${assosiation} -c ${command} -I 100000000 &
done