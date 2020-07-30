#!/usr/bin/python3

import argparse
import glob
from datetime import date, datetime

from PIL import Image


def parse_date(image):
    ts_index = 36867
    exif = image.getexif()
    ts = datetime.strptime(exif[ts_index], "%Y:%m:%d %H:%M:%S")
    return date(ts.year, ts.month, ts.day)


def find_days(files):
    res = []
    for i, f in enumerate(files):
        im = Image.open(f)
        day = parse_date(im)
        if day not in res:
            res.append(day)
    return res


def find_corresponding_images(files, days):
    res = []
    for i, f in enumerate(files):
        im = Image.open(f)
        day = parse_date(im)
        if day not in days:
            res.append(f)
    return res


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("src")
    parser.add_argument("dst")
    parser.add_argument("--copy")
    return parser.parse_args()


def main():
    args = parse_args()
    days = find_days(glob.glob(args.dst))
    images = find_days(glob.glob(args.src), days)
    print(images)


if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        pass
