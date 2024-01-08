import argparse
import glob
import os
import subprocess
import sys

from torch.utils.data import DataLoader, Dataset
from tqdm import tqdm


class ConvertDataset(Dataset):
    def __init__(self, files):
        self.files = files

    def __len__(self):
        return len(self.files)

    def __getitem__(self, idx):
        fname = self.files[idx]
        outfile = fname.replace('.m4a', '.wav')
        out = subprocess.call(
            'ffmpeg -y -i %s -ac 1 -vn -acodec pcm_s16le -ar 16000 %s >/dev/null 2>/dev/null' % (fname, outfile),
            shell=True)
        if out != 0:
            raise ValueError('Conversion failed %s.' % fname)

        os.remove(fname)
        return fname, out


def convert(args):
    files = glob.glob('%s/voxceleb2/*/*/*.m4a' % args.save_path)
    files.sort()

    dataset = ConvertDataset(files)
    loader = DataLoader(dataset, batch_size=100, num_workers=5)
    print('Converting files from AAC to WAV')
    for idx, _ in tqdm(enumerate(loader, start=1), total=len(loader)):
        print(f"Batch [{idx}/{len(loader)}] DONE")
        sys.stdout.flush()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="VoxCeleb downloader")
    parser.add_argument('--save_path', type=str, default="db", help='Target directory')
    args = parser.parse_args()
    convert(args)
