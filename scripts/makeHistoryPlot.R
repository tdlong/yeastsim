library(tidyverse)
library(gridExtra)
library(grid)

for(i in 1:6){
	filename = paste0("runs/run_",i,"/pop_history.csv")
	pop_hist = read.csv(filename, header=T)
	pop_hist$i = rep(i,nrow(pop_hist))
	pop_hist$lps = log(pop_hist$pop_size,base=10)
	## this really has to be divided by (df$OPTIMUM - df$phenotype_mean at time zero)
	## I just have to define what tick I am talking about and do something more sophisticated
	pop_hist$percentToOptima = 100*pop_hist$phenotype_mean/(pop_hist$OPTIMUM-pop_hist$phenotype_mean[pop_hist$tick==13])
	if(i == 1){
		df=pop_hist
		}else{
		df=rbind(df,pop_hist)
		}
	}
df$i = as.factor(df$i)
df$relativeVA = (30*5*df$V_A)/(df$SD_IN_SELECTION^2)     # since Vp = Vg + rnorm(30*Vg) and Vs = 10*Vp

	
msize = ggplot(df %>% filter(i==1),aes(x=tick,y=lps, group=i, colour=i)) +
	geom_line(show.legend = FALSE) +
	scale_color_manual(values=c("red","red","blue","blue","green","green")) +
	xlab("time") +
	ggtitle("log10 pop size") +
	ylab("log(N)")

df2 = df %>% filter(fitness_mean > 0.0001)
mean_phen = ggplot(df2,aes(x=tick,y=percentToOptima, group=i, colour=i)) +
	geom_line() +
	scale_color_manual(values=c("red","red","blue","blue","green","green")) +
	xlab("time") +
	ggtitle("average phenotype as percent of optima") +
	ylab("pheno (%)")

Va = ggplot(df2,aes(x=tick,y=relativeVA, group=i, colour=i)) +
	geom_line() +
	scale_color_manual(values=c("red","red","blue","blue","green","green")) +
	xlab("time") +
	ggtitle("additive genetic variance relative to base") +
	ylab("Va")
	

pdf("history.pdf", width=8, height=8)
grid.arrange(msize, mean_phen, Va, ncol=2)
graphics.off()

