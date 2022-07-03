#!/bin/bash
#SBATCH --job-name=ystSlim
#SBATCH -A tdlong_lab
#SBATCH -p standard
#SBATCH --array 1-2
#SBATCH --cpus-per-task=1

file="helperfiles/slurm_params.txt"
rseed1=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f1` 
rseed2=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f2` 
myind=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f3` 
nsnps=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f4` 
scale=`head -n $SLURM_ARRAY_TASK_ID $file | tail -n 1 | cut -f5` 
mkdir runs/run_$myind
build/slim -d SEED1=$rseed1 -d SEED2=$rseed2 -d mydirIndicator=$myind -d N_snps=$nsnps -d SCALE=$scale scripts/tony.slim   

