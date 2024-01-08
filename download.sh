#!/bin/bash
#SBATCH --job-name=download
# #SBATCH --partition=gpu
# #SBATCH --gres=gpu:1
#SBATCH --time=7-00:00:00
#SBATCH --mem=32GB
# #SBATCH --cpus-per-task=5
#SBATCH --output=download_output.log
#SBATCH --error=download_error.log


source /etc/profile.d/conda.sh
conda activate ecapa_tdnn

python3 download_voxceleb1.py db/voxceleb1/
python3 download_voxceleb2.py db/voxceleb2/
python3 download_musan.py db/musan/
python3 download_rirs_noises.py db/rirs_noises/


conda deactivate