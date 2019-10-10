#! /usr/bin/env bash
set -eux

source ./machine-setup.sh
cwd=`pwd`

USE_PREINST_LIBS=${USE_PREINST_LIBS:-"false"}
if [ $USE_PREINST_LIBS = true ]; then
  export MOD_PATH
  source ../modulefiles/chgres_cube.$target             > /dev/null 2>&1
else
  export MOD_PATH=${cwd}/lib/modulefiles
  if [ $target = wcoss_cray ]; then
    source ../modulefiles/chgres_cube.${target}_userlib > /dev/null 2>&1
  else
    source ../modulefiles/chgres_cube.$target
  fi
fi
#
# Check whether exec folder into which the executable will be copied ex-
# ists.  If not, create it.
#
if [ ! -d "../exec" ]; then
  mkdir ../exec
fi
#
# Change location to the directory of the chgres_cube code.  Then clean
# any existing build, rebuild, and install (i.e. move the executable 
# from the source code directory to the exec directory where all other
# executables are located).
#
cd chgres_cube.fd
make -f Makefile clean
make -f Makefile
make -f Makefile install

