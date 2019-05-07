#!/bin/bash

echo -e "Compiling"
cd intro_hello_world
rm -rf out hw
mpicc -o hw hello_world.c 2> err_log
rc=$?
if [[ $rc != 0 ]]; then
    echo -e "Error : mpicc returned"
    cat err_log
    echo "TECHIO> success false"
    rm -rf out
    exit $rc
fi
echo "Compilation is OK"
rm -rf out
mkdir out
rc=0

echo -e "Execution ... "
mpirun -mca btl sm,tcp,self -np 4 -output-filename out/out ./hw
rm -rf out

