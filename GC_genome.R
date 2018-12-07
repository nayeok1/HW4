library(ggplot2)

gc_great <- read.table("gc-great-genome.txt")
gc_great$percentcut <-cut(x=gc_great[,2], breaks = 15)
p <- ggplot(data = gc_whole) + 
  geom_bar(mapping = aes(percentcut))
p + labs(title="Great 100kb GC Distribution", x="Percentage", y="Count") 

gc_less <- read.table("gc-less-genome.txt")
gc_less$percentcut <-cut(x=gc_less[,2], breaks = 15)
p <- ggplot(data = gc_whole) + 
  geom_bar(mapping = aes(percentcut)) 
p + labs(title="Less 100kb GC Distribution", x="Percentage", y="Count") 

gc_whole <- read.table("gc-whole-genome.txt")
gc_whole$percentcut <-cut(x=gc_whole[,2], breaks = 15)
p <- ggplot(data = gc_whole) + 
  geom_bar(mapping = aes(percentcut)) 
p +labs(title="Whole Genome GC Distribution", x="Percentage", y="Count") 

