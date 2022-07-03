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
	# week 5
	m = founder_hist[founder_hist$tick == 193,]
#	m = founder_hist[founder_hist$tick == 445,]
	start = as.numeric(unlist(m["start"]))
	m = as.matrix(m[,1:18 + 3])
	if(i==startIndex){
		par(mar=c(3.5, 3.5, 1, 1), family="serif", mgp=c(2.1, 0.6, 0))
		plot(x=range(start), y=c(0, max(m)), type="n", xlab="position", ylab="frequency")
		}

	maxPerWindow = as.integer(apply(m, MARGIN=1, FUN=which.max))
	topFreq = sapply(1:NROW(m), FUN=function(window) { m[window, maxPerWindow[window]] })
	topColor = sapply(1:NROW(m), FUN=function(window) { founder_color [maxPerWindow[window]] })

	points(start, topFreq, col=topColor, pch=19, cex=0.5)
	lines(start, topFreq, col="lightgrey", lwd=0.25)
	}
graphics.off()

