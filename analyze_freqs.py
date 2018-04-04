import json

print("rsid\tchr\tpos\tmissing\ttotal")

for line in open("snp_stats.txt"):
    try:
        name, chr, position, freq = line.replace("=>", ":").strip().split("\t")
        freq = json.loads(freq)
        sum_calls = sum([freq[k] for k in freq])
        if "--" in freq.keys():
            missing = freq["--"] / sum_calls
            print("{}\t{}\t{}\t{}\t{}".format(name, chr, position, missing, sum_calls))
        else:
            print("{}\t{}\t{}\t0\t{}".format(name, chr, position, sum_calls))
    except:
        pass
