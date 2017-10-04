#Total Unduplicated Reach and Frequency



vars<-matrix(c(1:25),nrow=25,ncol=1)
dat<-matrix(NA,nrow=290,ncol=length(vars))
head(dat)
dat<-as.data.frame(dat)
probs<-runif(25)/4+.1
rando<-function(index)
{
dat[,index]<-rbinom(290,size=1,probs[index])
}
all<-as.data.frame(apply(vars,1,rando))
names(all)<-paste("q",vars,sep="")
head(all)
colMeans(all)
plot(probs,colMeans(all))

turf<-function(all,choices,minPercent=.1)
{
	#get rid of NAs
	all<-all[complete.cases(all)==1,]
	#check if niche product
	all2<-colSums(all)/nrow(all)
	all<-all[,c(all2>minPercent)]
	#get total number of panelists
	total<-nrow(all)
	xnames <- names(all)
	# Generate list of combinations
	xcomb <- t(combn(xnames,choices))
	# Calculate number of combinations
	xcount <- choose(ncol(all),choices)
	endcol<-choices+1
	#setup output
	output<-(matrix(NA,nrow=xcount,ncol=endcol))
	output[,1:choices]<-xcomb[,1:choices]
	output<-as.data.frame(output, stringsAsFactors = FALSE)
		#loop to get turf analysis
		for (i in 1:xcount)	
		{
			temp<-all[,c(xcomb[i,])]
			if (choices==1)
			{		
				sum<-temp
			}else
			{
				sum<-rowSums(temp)
			}
			reach<-sum[sum>0]
			reached<-length(reach)/total*100
			output[i,(endcol)]<-reached
		}
		#clean up output by rounding, number top results, return results
	output[,endcol]<-round(as.numeric(output[,endcol]),2)
	output<-output[order(as.numeric(output[,endcol]),decreasing=TRUE),]
	maxout<-min(nrow(output),20)
	outputEnd<-output[1:20,]
	list<-list(choices,outputEnd)
	return(list)
}
date()
turf<-cmpfun(turf)
output <- turf(all,choices=4,minPercent=.1)
date()
# runs in 11 seconds


date()

output <- turf(all,choices=5,minPercent=.1)
date()
# runs in 7 minutes 20  seconds



turf2<-function(All,choices,minPercent=.1)
{

	All<-All[complete.cases(All)==1,]
	All2<-colSums(All)/nrow(All)
	All<-All[,c(All2>minPercent)]
	total<-length(All)
	xnames <- names(All)
	# Generate list of combinations
	xcomb <- t(combn(xnames,choices))
	# Calculate number of combinations
	xcount <- choose(ncol(All),choices)
	endcol<-choices+1
	output<-(matrix(NA,nrow=xcount,ncol=endcol))
	output[,1:choices]<-xcomb[,1:choices]
	output<-as.data.frame(output, stringsAsFactors = FALSE)
	#do apply function instead of the loop use any and sum functions
	calc <- function(xcomb) {
	  return(sum(apply(All[xcomb], 1, function(i) {any(i>0)})/nrow(All)))
	}
	output[,endcol]<- apply(xcomb, 1, calc)

	output<-output[order(as.numeric(output[,endcol]),decreasing=TRUE),]
	maxout<-min(nrow(output),20)
	outputEnd<-output[1:20,]
	list<-list(choices,outputEnd)
	return(list)
}




date()
output2 <- turf2(all,choices=4,minPercent=.1)
date()
# runs in  20 seconds


turf3<-function(all,choices,minPercent=.1)
{
	all<-all[complete.cases(all)==1,]
	all2<-colSums(all)/nrow(all)
	all<-all[,c(all2>minPercent)]
	total<-nrow(all)
	xnames <- names(all)
	# Generate list of combinations
	xcomb <- t(combn(xnames,choices))
	# Calculate number of combinations
	xcount <- choose(ncol(all),choices)
	endcol<-choices+1
	output<-(matrix(NA,nrow=xcount,ncol=endcol))
	output[,1:choices]<-xcomb[,1:choices]
	output<-as.data.frame(output, stringsAsFactors = FALSE)
		
		
		#back to the loop with sum, apply, any function
		for (i in 1:xcount)	
		{
			temp<-all[,c(xcomb[i,])]
			if (choices==1)
			{		
				Sum<-sum(temp)
			}else
			{
				#sum<-rowSums(temp)
				Sum <- sum(apply(temp, 1,function(i) {any(i>0)}))
			}
			reached<-Sum/total*100
			output[i,(endcol)]<-reached
		}
	output[,endcol]<-round(as.numeric(output[,endcol]),2)
	output<-output[order(as.numeric(output[,endcol]),decreasing=TRUE),]
	maxout<-min(nrow(output),20)
	outputEnd<-output[1:20,]
	list<-list(choices,outputEnd)
	return(list)
}
date()
turf3<-cmpfun(turf3)
output3 <- turf3(all,choices=4,minPercent=.1)
date()
# runs in 26 seconds
library(compiler)
#date()
#output3 <- turf3(all,choices=1,minPercent=.1)
#date()

turf4<-function(All,choices,minPercent=.1)
{
	All<-All[complete.cases(All)==1,]
	All2<-colSums(All)/nrow(All)
	All<-All[,c(All2>minPercent)]
	#total<-nrow(All)
	xnames <- names(All)
	# Generate list of combinations
	xcomb <- t(combn(xnames,choices))
	# Calculate number of combinations
	xcount <- choose(ncol(All),choices)
	endcol<-choices+1
	output<-(matrix(NA,nrow=xcount,ncol=endcol))
	output[,1:choices]<-xcomb[,1:choices]
	output<-as.data.frame(output, stringsAsFactors = FALSE)
	#use only apply function
	calc <- function(index)  return(sum(rowSums(All[index]) > 0)/nrow(All)*100)
	output[,endcol] <- round(apply(xcomb, 1, calc),2)

	output<-output[order(as.numeric(output[,endcol]),decreasing=TRUE),]
	maxout<-min(nrow(output),20)
	outputEnd<-output[1:maxout,]
	list<-list(choices,outputEnd)
	return(list)
}

date()
output4 <- turf4(all,choices=4,minPercent=.1)
date()
# runs in 5 seconds
date()
output5 <- turf4(all,choices=5,minPercent=.1)
date()
# runs in 27 seconds

date()

if (F)
{
date()
library(XLConnect)
# Load workbook; create if not existing
wb2<-loadWorkbook(paste("TURF Results.xls",sep=""), create = TRUE)
for (i in 1:7)
{
	turfResults<-turf4(all,i,minPercent=.05)
	sheet<-paste("Products",turfResults[[1]])
	column<-as.numeric(turfResults[[1]])
	# Create a worksheet called ’Rand'
	wb2$createSheet(name =paste(sheet))
	# Write data TestData to the worksheet created above
	wb2$writeWorksheet(turfResults[[2]], sheet =paste(sheet), startRow = 1, startCol = 1,header=FALSE)
	setColumnWidth(wb2, sheet = paste(sheet), column = 1:column, width = 5000)
}
# Save workbook
saveWorkbook(wb2)
date()
}