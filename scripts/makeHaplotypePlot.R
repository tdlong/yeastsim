xx=read.table("runs/run_1/sample_haps_start.csv",sep=",",header=FALSE)
pdf("haplotypes.pdf",width=8,height=4)
image(t(xx),col=rainbow(8),axes=F)
graphics.off()

