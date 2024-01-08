#!/bin/bash
#SBATCH --job-name=musan_split
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00
#SBATCH --mem=32GB
# #SBATCH --cpus-per-task=5
#SBATCH --output=musan_split_output.log
#SBATCH --error=musan_split_error.log


source /etc/profile.d/conda.sh
conda activate ecapa_tdnn

python3 musan_split.py

conda deactivate