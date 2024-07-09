#!/usr/bin/zsh -e

# The directory of this script
workdir=${0:a:h}

# Target table
targets=(
    # Name   # Folder       # Extra CMake Arguments
    clang    llvm-project   '-S llvm -DLLVM_ENABLE_PROJECTS=clang -DLLVM_PARALLEL_COMPILE_JOBS=12 -DLLVM_PARALLEL_LINK_JOBS=4'
)

# Use Ninja if possible
if (( $+commands[ninja] )) {
    export CMAKE_GENERATOR='Ninja'
}

# Use custom linker launcher to capture data
export CMAKE_{C,CXX}_LINKER_LAUNCHER=$workdir/launcher.zsh

# Clean old data
rm -rf data
mkdir data

# Main loop
for name folder args in $targets; {
    # No debug builds (without split-dwarf) because of OOM
    for mode in Release; {
        for linker in BFD LLD MOLD; {
            # HMM is short for "How Much Memory"
            export HMM_OUT=$workdir/data/$name-${mode:l}-${linker:l}.csv

            # Clean old builds
            cd $workdir/$folder
            rm -rf build

            # Build project with custom linker launcher
            cmake -B build -DCMAKE_BUILD_TYPE=$mode -DCMAKE_LINKER_TYPE=$linker $=args
            cmake --build build
        }
    }
}
