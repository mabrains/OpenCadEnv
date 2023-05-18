#!/bin/bash -f

cmake \
-D CMAKE_INSTALL_PREFIX=/home/atork/ic-tools/tools/xyce-7.6.0 \
-D Trilinos_ROOT=`readlink -f $HOME/ic-tools/tools/trilinos-14-0-0` \
`readlink -f ../Xyce`
