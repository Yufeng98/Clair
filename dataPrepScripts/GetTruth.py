import sys
import argparse
import subprocess
import shlex
import os


class TruthStdout(object):
    def __init__(self, handle):
        self.stdin = handle

    def __del__(self):
        self.stdin.close()


def CheckFileExist(fn):
    if not os.path.isfile(fn):
        return None
    return os.path.abspath(fn)


def CheckCmdExist(cmd):
    try:
        subprocess.check_output("which %s" % (cmd), shell=True)
    except:
        return None
    return cmd


def OutputVariant(args):
    var_fn = args.var_fn
    vcf_fn = args.vcf_fn
    ctg_name = args.ctgName
    ctg_start = args.ctgStart
    ctg_end = args.ctgEnd

    if args.var_fn != "PIPE":
        var_fpo = open(var_fn, "wb")
        var_fp = subprocess.Popen(shlex.split("gzip -c"), stdin=subprocess.PIPE,
                                  stdout=var_fpo, stderr=sys.stderr, bufsize=8388608)
    else:
        var_fp = TruthStdout(sys.stdout)

    is_ctg_region_provided = ctg_start is not None and ctg_end is not None

    tabixed = 0
    if is_ctg_region_provided:
        if CheckFileExist("%s.tbi" % (vcf_fn)) != None:
            if CheckCmdExist("tabix") != None:
                tabixed = 1
                vcf_fp = subprocess.Popen(shlex.split("tabix -f -p vcf %s %s:%s-%s" %
                                                      (vcf_fn, ctg_name, ctg_start, ctg_end)), stdout=subprocess.PIPE, bufsize=8388608)
    if tabixed == 0:
        vcf_fp = subprocess.Popen(shlex.split("gzip -fdc %s" % (vcf_fn)), stdout=subprocess.PIPE, bufsize=8388608)

    for row in vcf_fp.stdout:
        row = row.strip().split()
        if row[0][0] == "#":
            continue

        # position in vcf is 1-based
        chromosome, position = row[0], int(row[1])
        if chromosome != ctg_name:
            continue
        if is_ctg_region_provided and not (ctg_start <= position <= ctg_end):
            continue
        reference, alternate, last_column = row[3], row[4], row[-1]

        # normal GetTruth
        genotype = last_column.split(":")[0].replace("/", "|").replace(".", "0").split("|")
        genotype_1, genotype_2 = genotype

        # 1000 Genome GetTruth (format problem) (no genotype is given)
        # genotype_1, genotype_2 = "1", "1"
        # if alternate.find(',') >= 0:
        #     genotype_1, genotype_2 = "1", "2"

        if int(genotype_1) > int(genotype_2):
            genotype_1, genotype_2 = genotype_2, genotype_1

        var_fp.stdin.write(" ".join([chromosome, position, reference, alternate, genotype_1, genotype_2]))
        var_fp.stdin.write("\n")

    vcf_fp.stdout.close()
    vcf_fp.wait()

    if args.var_fn != "PIPE":
        var_fp.stdin.close()
        var_fp.wait()
        var_fpo.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Extract variant type and allele from a Truth dataset")

    parser.add_argument('--vcf_fn', type=str, default="input.vcf",
                        help="Truth vcf file input, default: %(default)s")

    parser.add_argument('--var_fn', type=str, default="PIPE",
                        help="Truth variants output, use PIPE for standard output, default: %(default)s")

    parser.add_argument('--ctgName', type=str, default="chr17",
                        help="The name of sequence to be processed, default: %(default)s")

    parser.add_argument('--ctgStart', type=int, default=None,
                        help="The 1-based starting position of the sequence to be processed")

    parser.add_argument('--ctgEnd', type=int, default=None,
                        help="The 1-based inclusive ending position of the sequence to be processed")

    args = parser.parse_args()

    if len(sys.argv[1:]) == 0:
        parser.print_help()
        sys.exit(1)

    OutputVariant(args)
