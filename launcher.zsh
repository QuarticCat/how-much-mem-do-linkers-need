#!/usr/bin/zsh -e

objs=(${(M)@:#*.(o|a)})  # filter arguments end with .o or .a
input_mem=$(( $(wc --bytes --total=only $objs) / 1024 / 1024 ))

TIMEFMT='%M'  # max memory in MiB (zsh's built-in time, not GNU time)
taken_mem=${$(time $@ &>/dev/null):-0}

flock -x $HMM_OUT echo "$input_mem,$taken_mem" >> $HMM_OUT
