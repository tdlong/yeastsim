# call with something like
# Rscript scripts/Pollack.R name start stop
# Rscript scripts/Pollock.R S100 1 2

args = commandArgs(TRUE)
names = as.character(args[1])
startIndex = as.numeric(args[2])
stopIndex = as.numeric(args[3])
fileout=paste0("pollock",names,".pdf")
pdf(fileout, width=8, height=4)
for(i in startIndex:stopIndex){
	filename = paste0("runs/run_",i,"/founder_history.csv")
	founder_hist = read.csv(filename, header=T)
	founder_color = rainbow(18)
	m = founder_hist[founder_hist$tick == 445,]
	start = as.numeric(unlist(m["start"]))
	m = as.matrix(m[,1:18 + 3])
# earlier timepoint
	mear = founder_hist[founder_hist$tick == 193,]
	mear = as.matrix(m[,1:18 + 3])
# change in frequency	
	mstart = founder_hist[founder_hist$tick == 13,]
	mstart = as.matrix(mstart[,1:18 + 3])	
	m2 = m-mstart
	m2ear = mear - mstart

	if(i==startIndex){
		par(mar=c(3.5, 3.5, 1, 1), family="serif", mgp=c(2.1, 0.6, 0))
		plot(x=range(start), y=c(0, 0.4), type="n", xlab="position", ylab="freq change")
		}

	maxPerWindow = as.integer(apply(m2, MARGIN=1, FUN=which.max))
	topFreq = sapply(1:NROW(m2), FUN=function(window) { m2[window, maxPerWindow[window]] })
	topColor = sapply(1:NROW(m2), FUN=function(window) { founder_color [maxPerWindow[window]] })
	points(start, topFreq, col=topColor, pch=19, cex=0.25)
	lines(start, topFreq, col="lightgrey", lwd=0.25)
	
# earlier time point
	maxPerWindow = as.integer(apply(m2ear, MARGIN=1, FUN=which.max))
	topFreq = sapply(1:NROW(m2ear), FUN=function(window) { m2ear[window, maxPerWindow[window]] })
	topColor = sapply(1:NROW(m2ear), FUN=function(window) { founder_color [maxPerWindow[window]] })

	points(start, topFreq, col=topColor, pch=19, cex=0.10)
	lines(start, topFreq, col="lightgrey", lwd=0.15)
	
	}
graphics.off()

