#!/bin/bash -f

cmake \
-D CMAKE_INSTALL_PREFIX=`readlink -f $HOME/ic-tools/tools/trilinos-14-0-0` \
-C `readlink -f ../Xyce/cmake/trilinos/trilinos-base.cmake` \
`readlink -f ../Trilinos-trilinos-release-14-0-0`


