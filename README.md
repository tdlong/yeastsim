# yeastsim
1.  Make chrV vcf and fasta (in helperfiles)
2.  Read in vcf
3.  initially two types of mutations m1 are the markers of each haploid genome, m3 are SNPs
		- at this stage there are 17 alleles
		- and about 8K SNPs
4.  pick a subset of m3 SNPs to make causative (NSNPs), these become flavor m2 mutations
5.  give these mutations causative effects
		- with effects scaled by 1/ (minorAlleleCount)^scaling_constant
		- the scaling constant allows one to make rarer alleles have bigger effects
6.  now mix these 17 founders to create the population with counts given by K0
		- known mixing proportions * K0 pop size
7.	random mate for 12 generations
8.	grow to size K1 before starting actual evolution experiment
