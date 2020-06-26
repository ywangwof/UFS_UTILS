#%Module#####################################################
## Module file for orog
#############################################################

module load PrgEnv-intel
module swap intel/19.0.5.281
module load cray-mpich/7.7.10
module load cray-libsci
module load cray-netcdf-hdf5parallel
module load cray-parallel-netcdf
module load cray-hdf5-parallel

#export NETCDF=/opt/cray/pe/netcdf-hdf5parallel/4.6.3.2/INTEL/19.0

module use /oldscratch/ywang/external/modulefiles

# Loading nceplibs modules
module load ip/v3.0.0
module load sp/v2.0.2
module load w3emc/v2.3.0
module load w3nco/v2.0.6
module load bacio/v2.0.2
