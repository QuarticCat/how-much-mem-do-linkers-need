#!/usr/bin/zsh -e

# Filter arguments that end with .o or .a
objs=(${(M)@:#*.(o|a)})

# Get total size of inputs (in KiB)
input_size=$(( $(wc --bytes --total=only $objs) / 1024 ))

# Get peak memory usage of linker (in KiB)
taken_mem=$(mktemp)
\time --format='%M' --output=$taken_mem $@

# Write data
flock -x $HMM_OUT echo $input_size,$(<$taken_mem) >> $HMM_OUT
rm $taken_mem
