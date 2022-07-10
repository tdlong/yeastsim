#!/bin/bash
#SBATCH --job-name=ystSlim
#SBATCH -A tdlong_lab
#SBATCH -p highmem 
#SBATCH --array 1-6
#SBATCH --cpus-per-task=8

file="helperfiles/slurm_params.txt"
rseed1=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f1` 
rseed2=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f2` 
myind=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f3` 
nsnps=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f4` 
scale=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f5` 
mkdir runs/run_$myind
/dfs7/adl/tdlong/slim/build/slim -d SEED1=$rseed1 -d SEED2=$rseed2 -d mydirIndicator=$myind -d N_snps=$nsnps -d SCALE=$scale scripts/tony_v2.slim   

