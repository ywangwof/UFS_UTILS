#!/bin/bash

#-----------------------------------------------------------------------
# Create a C96 global uniform grid.  Compare output to a set
# of baseline files using the 'nccmp' utility.  This script is
# run by the machine specific driver script.
#-----------------------------------------------------------------------

set -x

export TMPDIR=${WORK_DIR}/c96.uniform.work
export out_dir=${WORK_DIR}/c96.uniform

export res=96
export gtype=uniform

#-----------------------------------------------------------------------
# Start script.
#-----------------------------------------------------------------------

echo "Starting at: " `date`

$home_dir/ush/fv3gfs_driver_grid.sh

iret=$?
if [ $iret -ne 0 ]; then
  set +x
  echo "<<< C96 UNIFORM TEST FAILED. <<<"
  exit $iret
fi

echo "Ending at: " `date`

#-----------------------------------------------------------------------------
# Compare output to baseline set of data.
#
# Note: orion's nccmp utility does not work with the netcdf
# required to run ufs_utils.  So swap it.
#-----------------------------------------------------------------------------

if [[ "$machine" = "ORION" ]] ;then
  module unload netcdfp/4.7.4.release
  module load netcdf/4.7.2
fi

cd $out_dir/C96

test_failed=0
for files in *tile*.nc ./fix_sfc/*tile*.nc
do
  if [ -f $files ]; then
    echo CHECK $files
    $NCCMP -dmfqS $files $HOMEreg/c96.uniform/$files
    iret=$?
    if [ $iret -ne 0 ]; then
      test_failed=1
    fi
  fi
done

set +x
if [ $test_failed -ne 0 ]; then
  echo "<<< C96 UNIFORM TEST FAILED. >>>"
else
  echo "<<< C96 UNIFORM TEST PASSED. >>>"
fi

exit 0
