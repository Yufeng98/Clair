import os
import cPickle
import argparse
import random
import concurrent.futures
from collections import namedtuple

Data = namedtuple('Data', ['x', 'y', 'pos', 'total'])


def process_command():
    parser = argparse.ArgumentParser(description="Combine small bins into a large bin.")
    parser.add_argument(
        '--src', type=str, default=os.path.join(os.curdir, "all_bins"),
        help="Path to directory that stores small bins. (default: %(default)s)"
    )
    parser.add_argument(
        '--dst', type=str, default=os.curdir,
        help="Path of the output folder. (default: %(default)s)"
    )
    parser.add_argument(
        '--bin_name', type=str, default="tensor.bin",
        help="Name of the large bin. (default: %(default)s)"
    )
    parser.add_argument(
        '--shuffle_data', type=bool, default=False,
        help="Shuffle data after loaded all data. (default: %(default)s)"
    )

    return parser.parse_args()


def load_data_from_one_file_path(file_path):
    X = []
    Y = []
    pos = []
    total = 0

    with open(file_path, "rb") as f:
        total = int(cPickle.load(f))
        X = cPickle.load(f)
        Y = cPickle.load(f)
        pos = cPickle.load(f)

    return Data(x=X, y=Y, pos=pos, total=total)


def load_data_from(directory_path, need_shuffle_file_paths=False):
    X = []
    Y = []
    pos = []
    total = 0

    file_paths = os.listdir(directory_path)
    file_paths.sort()
    if need_shuffle_file_paths:
        random.shuffle(file_paths)

    absolute_file_paths = []
    for file_path in file_paths:
        absolute_file_paths.append(os.path.abspath(os.path.join(directory_path, file_path)))

    for absolute_file_path in absolute_file_paths:
        data = load_data_from_one_file_path(absolute_file_path)

        total += data.total
        X += data.x
        Y += data.y
        pos += data.pos

        print "[INFO] Data loaded: {}".format(absolute_file_path)

    return Data(x=X, y=Y, pos=pos, total=total)


def pickle_dump(obj, file):
    return cPickle.dump(obj, file, protocol=cPickle.HIGHEST_PROTOCOL)


def output_data(dst, data):
    print "[INFO] Output: {}".format(os.path.abspath(dst))
    with open(dst, "wb") as f:
        pickle_dump(data.total, f)
        pickle_dump(data.x, f)
        pickle_dump(data.y, f)
        pickle_dump(data.pos, f)


def main():
    args = process_command()

    data = load_data_from(
        directory_path=args.src,
        need_shuffle_file_paths=args.shuffle_data
    )

    output_data(
        dst=os.path.join(args.dst, args.bin_name),
        data=data
    )


if __name__ == "__main__":
    main()
