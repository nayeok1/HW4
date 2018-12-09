# Homework 4

## Summarize partitions of a genome assembly

We will be revisiting the Drosophila melanogaster genome. As with Homework 3, start at flybase.org. Go to the most current download genomes section and download the gzipped fasta file for all chromosomes.

### Calculate the following for all sequences ≤ 100kb and all sequences > 100kb:

#### Preparation of Data

      $ cd HW4 #change directory to HW4   
      $ wget ftp://ftp.flybase.net/genomes/Drosophila_melanogaster/current/fasta/dmel-all-chromosome-r6.24.fasta.gz #downloading data   
      $ md5sum dmel-all-chromosome-r6.24.fasta.gz #checking the file integrity   
      $ gunzip dmel-all-chromosome-r6.24.fasta.gz #unzipping the file

#### Module load

      $ module load jje/jjeutils jje/kent #need this for bioawk and faSize

I am going to use the bioawk for partitioning. 

#### Partition using BIOAWK
      $ bioawk -c fastx 'length($seq)  <= 100000{ print ">"$name; print $seq }' dmel-all-chromosome-r6.24.fasta | sort -rn > dmel-all-chromosome-r6.24-lessandequal100kb.fasta #file save with -lessandequal100kb
      $ bioawk -c fastx 'length($seq)  > 100000{ print ">"$name; print $seq }' dmel-all-chromosome-r6.24.fasta | sort -rn > dmel-all-chromosome-r6.24-greater100kb.fasta #file saved with -greater100kb
   
#### Checking the file in HW4 directory
      $ ls 
      $ dmel-all-chromosome-r6.24.fasta                    README.md
        dmel-all-chromosome-r6.24-greater100kb.fasta       
        dmel-all-chromosome-r6.24-lessandequal100kb.fasta

Now I know that I have successfully saved two files with sequence ≤ 100kb and >100kb. We are going to use faSize to get total number of nucleotides, total number of Ns and total number of sequences

#### Getting data using FASIZE
      $ faSize dmel-all-chromosome-r6.24-lessandequal100kb.fasta 
      $ 6178042 bases (662593 N's 5515449 real 5515449 upper 0 lower) in 1863 sequences in 1 files
        Total size: mean 3316.2 sd 108053.8 min 0 (211000022278031) max 4245830 (mitochondrion_genome) median 0
        N count: mean 355.7 sd 11351.2
        U count: mean 2960.5 sd 96726.1
        L count: mean 0.0 sd 0.0
        %0.00 masked total, %0.00 masked real
        
      $ faSize dmel-all-chromosome-r6.24-greater100kb.fasta  
      $ 137547960 bases (490385 N's 137057575 real 137057575 upper 0 lower) in 7 sequences in 1 files 
        Total size: mean 19649708.6 sd 51988242.2 min 0 (2L) max 137547960 (X) median 0
        N count: mean 70055.0 sd 185348.1
        U count: mean 19579653.6 sd 51802894.1
        L count: mean 0.0 sd 0.0
        %0.00 masked total, %0.00 masked real

##### Data from sequence ≤ 100kb
1. Total number of nucleotides : 6178042 nucleotides
2. Total number of Ns : 662593 N's
3. Total number of sequences : 1863 sequences

##### Data from sequence > 100kb
1. Total number of nucleotides : 137547960 nucleotides
2. Total number of Ns : 490385 N's
3. Total number of sequences : 7 sequences


### Plots of the following for the whole genome, for all sequences ≤ 100kb, and all sequences > 100kb:

#### Module load

     $ module load jje/jjeutils perl rstudio/0.99.9.9

#### Plots for whole genome
`        

         # For sequence length distribution   
         $ bioawk -c fastx ' { print length($seq) } ' dmel-all-chromosome-r6.24.fasta > length-whole-genome.txt # I have attached R code for the distribution 
         
         # For GC% distribution
         $ bioawk -c fastx '{ print $name, gc($seq) }' dmel-all-chromosome-r6.24.fasta > gc-whole-genome.txt # I have attached R code for the distribution
         
         # For cumulative genome size 
         $ bioawk -c fastx ' { print length($seq) } ' dmel-all-chromosome-r6.24.fasta | sort -rn | awk ' BEGIN { print "Assembly\tLength\nseq_length\t0" } { print "seq_length\t" $1 } ' > length-whole-genome.length # sequence length
         $ plotCDF2 length-whole-genome.length length-whole-genome.png # output graph
         

1. Sequence length distribution   

![whole](https://blogfiles.pstatic.net/MjAxODEyMDlfMjAz/MDAxNTQ0MzI0MTAwNzY0.WZ5oPHz9ff6ULcC5K6ynG1Rh8ir99gsWDmDbyrKY1Tcg.G1_9Z-6exXFQu4hdRwxGHZB_ub72UBKv0ODP-90n7_Eg.JPEG.nayeonkim93/whole_genome_length.jpeg)

2. Sequence GC% distribution   

![gc-whole](https://blogfiles.pstatic.net/MjAxODEyMDdfMTU1/MDAxNTQ0MTg2ODc2NDY0.awjcP3y71vLdJdsa8-vErJzFYnOFHqznkUP1aeSqT7Ig.LCGLjIa3jFsBK_4emJz3DRFvUKb0aW7f4CXcohYOtacg.JPEG.nayeonkim93/gc_whole.jpeg)   

3. Cumulative genome size sorted from largest to smallest sequences   

![len-whole](https://blogfiles.pstatic.net/MjAxODEyMDZfMjMx/MDAxNTQ0MDk2NDA5NjIx.dYbVr_AdfEXVGTCAO-t4T8N7p1Zjqttdrzm9SptmL6Ig.-BELOSgyJzbYZtHz7KGJvXxK93OADlm_55ro2tnSTH0g.PNG.nayeonkim93/length-whole-genome.png)

#### Plots for sequence ≤ 100kb
bioawk -c fastx '{ print $name, gc($seq) }' dmel-all-chromosome-r6.24-lessandequal100kb.fasta > gc-less-genome.txt

         $ bioawk -c fastx ' { print length($seq) } ' dmel-all-chromosome-r6.24-lessandequal100kb.fasta > length-less-genome.txt
         
          $ bioawk -c fastx '{ print $name, gc($seq) }' dmel-all-chromosome-r6.24-lessandequal100kb.fasta > gc-less-genome.txt
         
         $ bioawk -c fastx ' { print length($seq) } ' dmel-all-chromosome-r6.24-lessandequal100kb.fasta | sort -rn | awk ' BEGIN { print "Assembly\tLength\nseq_length\t0" } { print "seq_length\t" $1 } ' > length-less-genome.length 
         $ plotCDF2 length-less-genome.length length-less-genome.png 
        
         
1. Sequence length distribution   

![less](https://blogfiles.pstatic.net/MjAxODEyMDlfMTA0/MDAxNTQ0MzI0MTA1NTkz.BcamqdgHiYJEWf2vsTWHOKbI0xMAAO5wlPVSdF2EKHYg.ulO7DewM_e7aTsTH4J_urisFm3bqw15QisRE1s27CFIg.JPEG.nayeonkim93/less_genome_length.jpeg)

2. Sequence GC% distribution   

![gc-less](https://blogfiles.pstatic.net/MjAxODEyMDdfMjc5/MDAxNTQ0MTg2ODcyNzU2.7MZMJuxUSDtlL_nNib7-CF__2cPrnZFpKDmqO0cBLWgg.k-LsH36W7IHkcj_lPsSWUxKsEmLYQG3C7M8G00yHBu4g.JPEG.nayeonkim93/gc_less.jpeg)   

3. Cumulative genome size sorted from largest to smallest sequences   

![len-less](https://blogfiles.pstatic.net/MjAxODEyMDZfMTIz/MDAxNTQ0MDk2NDE1OTc1.wgP88M7T4ml8YY9kOQf7Kdan9EAsRma3Ob_IVxyzO7kg.W6tvCuNmKciW2upqL0UeNG0tAERO_PIs-lxgjT4KTqcg.PNG.nayeonkim93/length-less-genome.png)   

#### Plots for sequence > 100kb
            
         $ bioawk -c fastx ' { print length($seq) } ' dmel-all-chromosome-r6.24-greater100kb.fasta > length-great-genome.txt
         
         $ bioawk -c fastx '{ print $name, gc($seq) }' dmel-all-chromosome-r6.24-greater100kb.fasta > gc-great-genome.txt
         
         $ bioawk -c fastx ' { print length($seq) } ' dmel-all-chromosome-r6.24-greater100kb.fasta | sort -rn | awk ' BEGIN { print "Assembly\tLength\nseq_length\t0" } { print "seq_length\t" $1 } ' > length-great-genome.length
         $ plotCDF2 length-great-genome.length length-great-genome.png
         
 
1. Sequence length distribution    

![great](https://blogfiles.pstatic.net/MjAxODEyMDlfMTEz/MDAxNTQ0MzI0MTA4NDA0.OSsqByd2EAG-rj1WjnyttTLDutBZ-J4pFC8K8BLpaSAg.8R_a0Pr5tLbrse0zMqoBvo1qjPUAVdOMG05ZBqjtB2Qg.JPEG.nayeonkim93/great_genome_length.jpeg)

2. Sequence GC% distribution  

![gc-great](https://blogfiles.pstatic.net/MjAxODEyMDdfMjM4/MDAxNTQ0MTg2ODY4MTUx.mm1wetLqCkDghUCLt2dy8Be1vnD8q1E0qDpBDtCzjFMg.MfmEU4bCgu6lM9M2iDbUjQpc8aqfGhyOu9AD86_-fHUg.JPEG.nayeonkim93/gc_greater.jpeg)  

3. Cumulative genome size sorted from largest to smallest sequences   

![len-great](https://blogfiles.pstatic.net/MjAxODEyMDZfMTI0/MDAxNTQ0MDk2NDIyNzk5.Vo5bukEg4yEmMbUl4Nj-TbPIzpZjW8ODyWV-ontO3O0g.hTDhCAvZEppVJodRyZd9sg8o_ELKCaaKU99m4m3L3eIg.PNG.nayeonkim93/length-great-genome.png)   

## Genome assembly

### Assemble a genome from MinION reads

1. Download the reads from here  
     
        $ cd HW4
        $ wget https://hpc.oit.uci.edu/~solarese/ee282/iso1_onp_a2_1kb.fastq.gz #downloading data
        $ gunzip iso1_onp_a2_1kb.fastq reads.fq
        $ ln -sf iso1_onp_a2_1kb.fastq reads.fq
        
2. Use minimap to overlap reads  

        $ qrsh -q epyc,abio128,free88i,free72i -pe openmp 32      
        $ minimap -t 32 -Sw5 -L100 -m0 reads.fq{,} | gzip -1 > onp.paf.gz
        
3. Use miniasm to construct an assembly   

        $ miniasm -f reads.fq onp.paf.gz > reads.gfa
        
### Assembly assessment

1. Calculate the N50 of your assembly (this can be done with only faSize+awk+sort or with bioawk+awk+sort) and compare it to the Drosophila community reference's contig N50   
                  
               
          $ n50 () {
            bioawk -c fastx ' { print length($seq); n=n+length($seq); } END { print n; } ' $1 \
            | sort -rn \
            | gawk ' NR == 1 { n = $1 }; NR > 1 { ni = $1 + ni; } ni/n > 0.5 { print $1; exit; } '
            }
          $ awk ' $0 ~/^S/ { print ">" $2" \n" $3 } ' reads.gfa \
            | tee >(n50 /dev/stdin > n50.txt) \
            | fold -w 60 \
            > unitigs.fa  
 
          $ n50 cal-N50-deml-all-chromosome-r6.24.fa
          
2. Compare your assembly to the contig assembly (not the scaffold assembly!) from Drosophila melanogaster on FlyBase using a dotplot constructed with MUMmer   

#### Module load and make contig assemby using faSplitByN

          $ module load jje/jjeutils perl
          $ faSplitByN dmel-all-chromosome-r6.24.fasta dmel-all-chromosome-r6.24-contass.fasta
         
#### From Edwin note

          $ # Loading of binaries via module load or PATH reassignment
            module unload jje/jjeutils
            source /pub/jje/ee282/bin/.qmbashrc
            module load gnuplot/4.6.0

            # Query and Reference Assignment. State my prefix for output filenames
            REF="dmel-all-chromosome-r6.24-contass.fasta"
            PREFIX="flybase"
            SGE_TASK_ID=1
            QRY=$(ls u*.fa | head -n $SGE_TASK_ID | tail -n 1)
            PREFIX=${PREFIX}_$(basename ${QRY} .fa)

            # Please use a value between 75-150 for -c. The value of 1000 is too strict.
            nucmer -l 100 -c 150 -d 10 -banded -D 5 -prefix ${PREFIX} ${REF} ${QRY}
            mummerplot --fat --layout --filter -p ${PREFIX} ${PREFIX}.delta \
            -R ${REF} -Q ${QRY} --png

          

3. Compare your assembly to both the contig assembly and the scaffold assembly from the Drosophila melanogaster on FlyBase using a contiguity plot   
4. Calculate BUSCO scores of both assemblies and compare them  

       module load augustus/3.2.1
       module load blast/2.2.31 hmmer/3.1b2 boost/1.54.0
       source /pub/jje/ee282/bin/.buscorc

       INPUTTYPE="geno"
       MYLIBDIR="/pub/jje/ee282/bin/busco/lineages/"
       MYLIB="diptera_odb9"
       OPTIONS="-l ${MYLIBDIR}${MYLIB}"
       ##OPTIONS="${OPTIONS} -sp 4577"
       QRY="unitigs.fasta"
       ###Please change this based on your qry file. I.e. .fasta or .fa or .gfa
       MYEXT=".fasta" 

       #my busco run
       #you can change the value after -c to tell busco how many cores to run on. Here we are using only 1 core.
       BUSCO.py -c 1 -i ${QRY} -m ${INPUTTYPE} -o $(basename ${QRY} ${MYEXT})_${MYLIB}${SPTAG} ${OPTIONS}

