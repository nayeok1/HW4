library(ggplot2)

leng_whole <- read.table("length-whole-genome.txt")
leng_whole$cut <-cut(x=leng_whole[,1], breaks = 4)
p <- ggplot(data = leng_whole)+ 
  geom_bar(mapping = aes(cut)) 
p + labs(title="Whole Genome Length Distribution", x="Length", y="Count") 

leng_less <- read.table("length-less-genome.txt")
leng_less$cut <-cut(x=leng_less[,1], breaks = 4)
p <- ggplot(data = leng_less)+ 
  geom_bar(mapping = aes(cut)) 
p + labs(title="Less 100kb Length Distribution", x="Length", y="Count") 

leng_great <- read.table("length-great-genome.txt")
leng_great$cut <-cut(x=leng_great[,1], breaks = 4)
p <- ggplot(data = leng_great)+ 
  geom_bar(mapping = aes(cut)) 
p + labs(title="Great 100kb Length Distribution", x="Length", y="Count") 
