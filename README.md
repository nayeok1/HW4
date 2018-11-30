# Homework2

## Summarize partitions of a genome assembly

We will be revisiting the Drosophila melanogaster genome. As with Homework 3, start at flybase.org. Go to the most current download genomes section and download the gzipped fasta file for all chromosomes.

#### Calculate the following for all sequences ≤ 100kb and all sequences > 100kb:

1. Total number of nucleotides
2. Total number of Ns
3. Total number of sequences

  * ****
      $ cd HW4 #change directory to HW4   
      $ wget ftp://ftp.flybase.net/genomes/Drosophila_melanogaster/current/fasta/dmel-all-chromosome-r6.24.fasta.gz #downloading data   
  > $ md5sum dmel-all-chromosome-r6.24.fasta.gz #checking the file integrity   
  > $ gunzip dmel-all-chromosome-r6.24.fasta.gz #unzipping the file

"$ ls emotion" will help you to check whether this procedure worked. This shows the directory called happy only because I remove "sad" directory from "emotion" 

#### Plots of the following for the whole genome, for all sequences ≤ 100kb, and all sequences > 100kb:

1. Sequence length distribution
2. Sequence GC% distribution
3. Cumulative genome size sorted from largest to smallest sequences


## Genome assembly
