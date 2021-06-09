#install.packages("ggplot2")
#install.packages("dplyr")
#install.packages("BiocManager")
#BiocManager::install("ChIPseeker")

library(ChIPseeker)
library(ggplot2)
library(dplyr)

setwd('Documents/bioinf/2021/final')

#NAME <- 'ENCFF017UQU.hg19'
#NAME <- 'ENCFF662NTZ.hg19'
#NAME <- 'DeepZ'
NAME <- 'intersect_with_DeepZ' 
  
OUT_DIR <- 'Results/'

bed_df <- read.delim(paste0('data/', NAME, '.bed'), as.is = TRUE, header = FALSE)
#colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
colnames(bed_df) <- c('chrom', 'start', 'end')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

#bed_df <- bed_df[bed_df['len'] < 5000]

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)


#NAME <- 'ENCFF662NTZ.hg19'

bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 1000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.filtered.pdf'), path = OUT_DIR)

bed_df %>%
  select(-len) %>%
  write.table(file='data/H3K4me3_A549.ENCFF832EOL.hg19.filtered.bed',
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)


