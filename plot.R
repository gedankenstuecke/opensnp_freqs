df <- read.csv("frequencies_missing.csv",sep="\t")
library(ggplot2)
library("ggrepel")
library(cowplot)

# remove X & Y, scale data correctly

df_autosomal <- subset(df,df$chr != 'X' & df$chr != "Y")
df_autosomal$missing <- df_autosomal$missing * 100

# overall histogram

histogram_percent_missing <- ggplot(df_autosomal,aes(missing)) + 
  geom_histogram(binwidth = 5) +
  theme_minimal() + 
  scale_x_continuous("% missing genotype calls")

# grab >5% missing calls 
df_sub <- subset(df_autosomal,df_autosomal$missing > 5)

scatter_missing <- ggplot(df_sub,aes(total,missing)) + 
  geom_point(alpha=0.03) +
  geom_rug(alpha=0.01) +
  geom_point(data = subset(df_sub,df_sub$rsid == "rs63751426"),
             color='red') +
  theme_minimal() +
  geom_text_repel(
    data = subset(df_sub,df_sub$rsid == "rs63751426"),
    aes(label = rsid),
    size = 6,
    nudge_x = 45,
    color="red"
  )  +
  scale_x_continuous("total tried genotype calls") +
  scale_y_continuous("% missed genotype calls (missed > 0.05)")

# joint plot
plot_grid(histogram_percent_missing, scatter_missing, labels = c("A", "B"))

# SNPs w >1000 calls and how many are >5% missing?
length(subset(df_autosomal,df_autosomal$total > 1000)$chr)
length(subset(df_autosomal,df_autosomal$total > 1000 & df_autosomal$missing > 5)$chr)

# histogram for these
ggplot(subset(df_autosomal,df_autosomal$total > 1000),aes(missing)) + 
  geom_histogram(binwidth = 2) +
  theme_minimal() + 
  scale_x_continuous("% missing genotype calls")
