import itertools
import math
import pandas
import sys


def main(file, k, bin, kmer_dt):
    i = 0
    motif_dt = {}
    with open(file) as fastq:
        for line in fastq:
            i += 1
            if i == 2:
                motif_dt = binner(line.rstrip(), motif_dt, k, bin, kmer_dt)
            if i == 4:
                i = 0
    return motif_dt


def kmer_combos(k):
    kmer_dt = {}
    k_list = ['ACGTN' for i in range(k)]
    kmer_ls = list(itertools.product(*k_list))
    for i in kmer_ls:
        kmer_dt[''.join(i)] = 0
    return kmer_dt


def binner(seq, motif_dt, k, bin, kmer_dt):
    for i in range(len(seq) - k + 1):
        kmer = seq[i:i+k]
        cat = math.floor(i/bin)
        if cat in motif_dt:
            motif_dt[cat][kmer] += 1
        else:
            motif_dt[cat] = kmer_dt.copy()
            motif_dt[cat][kmer] += 1
    return motif_dt


def writer(motif_dt, kmer_dt):
    df = pandas.DataFrame()
    df['motif'] = list(kmer_dt.keys())
    for k, v in motif_dt.items():
        df[k] = v.values()
    print(df)
    df.to_csv('motifs.csv', index=False)


if __name__ == '__main__':
    file = sys.argv[1]
    k = int(sys.argv[2])
    bin = int(sys.argv[3])
    kmer_dt = kmer_combos(k)
    motif_dt = main(file, k, bin, kmer_dt)
    writer(motif_dt, kmer_dt)
