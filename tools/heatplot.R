##########
# This code produces a heatplot from DNA motifs for the 
# purposes of the CyVerse FOSS 2020 Course
##########
##########
# DATE OF CREATION: 2020-10-27
##########
##########

library(tidyverse)
install.packages('reshape2'); library(reshape2)
install.packages('viridis');library(viridis)

#load in data
motifs = read_csv('./work/raw_data/SRR12901070/SRR12901070_1.fastq.motifs.csv')
colnames(motifs) = c('motifs', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 
                     '10', '11', '12', '13', '14')
#reshape data into long to work nicely with ggplot
motifs_long = melt(motifs)

#make heatplot
heatplot = ggplot(data = motifs_long) +
  geom_tile(aes(x = variable, y = reorder(motifs, desc(motifs)), fill = value)) +
  scale_fill_viridis('Number of Kmers', direction = -1) +
  theme_bw() +
  labs(x = 'Count Bins', y = 'Motif') +
  theme(
    axis.title.x = element_text(size = 16),
    axis.title.y = element_text(size = 16),
    axis.text.x = element_text(size = 12, colour = 'black'),
    axis.text.y = element_text(size = 12, colour = 'black'),
    panel.border = element_rect(colour = 'white')
  )
ggsave('heatplot.png')