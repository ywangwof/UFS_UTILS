#%Module#####################################################
## Module file for nemsutil
#############################################################

# Loading Intel Compiler Suite

unset LD_LIBRARY_PATH

module load PrgEnv-intel
module swap intel/19.0.5.281
module load cray-mpich/7.7.10
module load cray-libsci
module load cray-netcdf-hdf5parallel
module load cray-parallel-netcdf
module load cray-hdf5-parallel

# Loding nceplibs modules
module use /oldscratch/ywang/external/modulefiles
module load w3nco/v2.0.6
module load bacio/v2.0.2
module load nemsio/v2.2.2

export FCMP=ftn
