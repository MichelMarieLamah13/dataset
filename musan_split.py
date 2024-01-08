import argparse
import glob
import os
import sys

from scipy.io import wavfile
from torch.utils.data import Dataset, DataLoader
from tqdm import tqdm


class MusanSplitDataset(Dataset):
    def __init__(self, files):
        self.files = files

    def __len__(self):
        return len(self.files)

    def __getitem__(self, idx):
        audlen = 16000 * 5
        audstr = 16000 * 3
        file = self.files[idx]
        fs, aud = wavfile.read(file)
        writedir = os.path.splitext(file.replace('/musan/', '/musan_split/'))[0]
        os.makedirs(writedir, exist_ok=True)
        for st in range(0, len(aud) - audlen, audstr):
            wavfile.write(writedir + '/%05d.wav' % (st / fs), fs, aud[st:st + audlen])

        return file


def split_musan(args):
    files = glob.glob('%s/musan/*/*/*.wav' % args.save_path)
    dataset = MusanSplitDataset(files)
    loader = DataLoader(dataset, batch_size=10, num_workers=5)
    for idx, _ in tqdm(enumerate(loader, start=1), total=len(loader)):
        print(f"Batch [{idx}/{len(loader)}] DONE")
        sys.stdout.flush()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="VoxCeleb downloader")
    parser.add_argument('--save_path', type=str, default="db", help='Target directory')
    args = parser.parse_args()
    split_musan(args)
