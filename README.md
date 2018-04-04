# Missed SNP calls according to openSNP data
I dumped all the SNP frequencies from the openSNP database into `snp_stats.txt.gz` in the most ridiculous way using the Ruby shell.

`analyze_freqs.py` will transform the unzipped file into a proper CSV (here `frequencies_missing.csv`).
This one was then quickly plotted with `ggplot` in `plot.R`
