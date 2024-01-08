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

#rm -f db/voxceleb1/vox1_dev_*
#rm -f db/voxceleb1/vox1_test_*
#
#rm -f db/voxceleb2/vox2_dev_*
#rm -f db/voxceleb2/vox2_aac.zip
#
#
#mv db/voxceleb2/dev/aac/* db/voxceleb2/
#rm -rf db/voxceleb2/dev/
#wget https://www.robots.ox.ac.uk/~vgg/data/voxceleb/meta/train_list.txt -P db/voxceleb2/
#
#mv db/voxceleb1/wav/* db/voxceleb1/
#rm -rf db/voxceleb1/wav
#
#mv db/rirs_noises/RIRS_NOISES  db/
#rm -rf db/rirs_noises
#
#mv db/musan db/musan1
#mv db/musan1/musan db/
#rm -rf db/musan1



# python3 download_voxceleb1.py db/voxceleb1/
# python3 download_voxceleb2.py db/voxceleb2/
# python3 download_musan.py db/musan/
# python3 download_rirs_noises.py db/rirs_noises/



conda deactivate