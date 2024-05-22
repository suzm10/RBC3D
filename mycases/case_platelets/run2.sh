#!/bin/bash

#Do the following before running
#change initcond.F90 layers variable
#change the #cpus and #cores here
#change log file name to reflect proc and layer count
#change num processes in srun to reflect the total execution threads

#run this in the case directory of RBC3D

#SBATCH --account=gts-sbryngelson3
#SBATCH -N1 --ntasks-per-node=24
#SBATCH --mem-per-cpu=2G
#SBATCH -t1:00:00
#SBATCH -q embers
#SBATCH --mail-user=smanasreh6@gatech.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH -o "./run_logs/plat.log"

cd $SLURM_SUBMIT_DIR

ml gcc mvapich2 netcdf-c netcdf-cxx netcdf-fortran fftw

cd D
rm -f *
cd ..

cd ../../common
make clean
make .depend
make

cd ../mycases/case_platelets
make clean
make .depend
make

srun -n 1 ./initcond
srun ./tube