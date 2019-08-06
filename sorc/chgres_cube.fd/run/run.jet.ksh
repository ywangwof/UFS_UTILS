#!/bin/bash


#SBATCH --nodes=1
#SBATCH --tasks-per-node=12
#SBATCH --partition=xjet
#SBATCH -t 0:15:00
#SBATCH -A emcda
#SBATCH -q windfall
#SBATCH -J fv3
#SBATCH -o ./log
#SBATCH -e ./log

set -x

source /apps/lmod/lmod/init/sh
module purge
module load intel/15.0.3.187
module load impi/2018.4.274
module load szip
module load hdf5
module load netcdf/4.2.1.1
module list

# Threads useful when ingesting spectral gfs sigio files.
# Otherwise set to 1.
export OMP_NUM_THREADS=1
export OMP_STACKSIZE=1024M

WORKDIR=/mnt/lfs3/projects/emcda/George.Gayno/stmp/chgres_fv3
rm -fr $WORKDIR
mkdir -p $WORKDIR
cd $WORKDIR

ln -fs ${SLURM_SUBMIT_DIR}/config.noahmp.jet.nml ./fort.41

date

srun /mnt/lfs3/projects/emcda/George.Gayno/ufs_utils.git/UFS_UTILS/exec/chgres_cube.exe

date

exit 0
