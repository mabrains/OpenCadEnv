#!/bin/bash -f

for M in SuiteSparse_config AMD CAMD CHOLMOD KLU CSparse CHOLMOD CCOLAMD
do  
    echo $M
    cd $M
    make
    make install
done