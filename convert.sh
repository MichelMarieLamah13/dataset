#!/bin/bash
#SBATCH --job-name=convert
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00
#SBATCH --mem=32GB
#SBATCH --cpus-per-task=5
#SBATCH --output=convert_output.log
#SBATCH --error=convert_error.log


source /etc/profile.d/conda.sh
conda activate ecapa_tdnn

python3 convert.py

conda deactivate