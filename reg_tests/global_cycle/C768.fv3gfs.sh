#!/bin/bash

#------------------------------------------------------------------
# Run global_cycle for a C768 test case.  Compare output
# to a baseline set of files using the 'nccmp' utility.
#------------------------------------------------------------------

set -x

export MAX_TASKS_CY=6

export HOMEgfs=$NWPROD
export BASE_GSM=$NWPROD

export CYCLEXEC=$BASE_GSM/exec/global_cycle

export CDATE=2019073000
export FHOUR=00
export DELTSFC=6

export CASE=C768

export COMIN=$HOMEreg/input_data
export FNTSFA=$COMIN/gdas.t00z.rtgssthr.grb
export FNSNOA=$COMIN/gdas.t00z.snogrb_t1534.3072.1536
export FNACNA=$COMIN/gdas.t00z.seaice.5min.blend.grb
export GSI_FILE=$COMIN/gdas.t00z.dtfanl.nc

export JCAP=1534
export LONB=3072
export LATB=1536

export FIXgsm=$BASE_GSM/fix/fix_am

export DONST="YES"
export use_ufo=.true.

export VERBOSE=YES
export CYCLVARS=FSNOL=-2.,FSNOS=99999.,


$BASE_GSM/ush/global_cycle_driver.sh

iret=$?
if [ $iret -ne 0 ]; then
  set +x
  echo "<<< GLOBAL CYCLE TEST FAILED. <<<"
  echo "<<< GLOBAL CYCLE TEST FAILED. <<<"  > ./summary.log
  exit $iret
fi

# orion's nccmp utility does not work with the netcdf
# required to run global_cycle.  So swap it.

machine=${machine:-NULL}
if [[ "$machine" = 'orion' ]]; then
  module unload netcdfp/4.7.4.release
  module load netcdf/4.7.2
fi

test_failed=0

cd $DATA
for files in *tile*.nc
do
  if [ -f $files ]; then
    echo CHECK $files
    $NCCMP -dmfqS $files $HOMEreg/baseline_data/$files
    iret=$?
    if [ $iret -ne 0 ]; then
      test_failed=1
    fi
  fi
done

set +x
if [ $test_failed -ne 0 ]; then
  echo
  echo "*********************************"
  echo "<<< GLOBAL CYCLE TEST FAILED. >>>"
  echo "*********************************"
  echo "<<< GLOBAL CYCLE TEST FAILED. >>>" > ./summary.log
else
  echo
  echo "*********************************"
  echo "<<< GLOBAL CYCLE TEST PASSED. >>>"
  echo "*********************************"
  echo "<<< GLOBAL CYCLE TEST PASSED. >>>" > ./summary.log
fi

exit
