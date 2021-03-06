server <- function(input, output) {
pool.in <- read.csv("~/Desktop/TC_12day_pooled_meanspcorr_QC_normEC_Apr2016.csv",row.names=1)
data.norm <- data.matrix(pool.in)+1
cnames <- colnames(data.norm)
h.ind <- as.numeric(substr(cnames,2,4))
day.ind <- ceiling(h.ind/24)
names(day.ind) <- cnames

day.col <- rainbow(13)
day.col[c(10,13)]<-c("darkblue","pink")
day.col[5:7]<-c("aquamarine","forestgreen","lightblue")
names(day.col) <- sort(unique(day.ind))

day.col.pool <- day.col[as.character(day.ind[cnames])]
feeding.s <- rbind(c(0,0),c(21,24),c(37,40),c(69,72),c(96,96),c(141,144),c(189,192),c(237,240))
x.which <- which(h.ind%in%c(1,50,100,150,200,288))
feeding.which <- feeding.s
#for(i in 1:nrow(feeding.s))for(j in 1:2)feeding.which[i,j] <- which(h.ind==feeding.s[i,j])
# dont show the last feeding interval ... no data available
feeding.which <- feeding.s[1:7,]
for(i in 1:nrow(feeding.which))for(j in 1:2)feeding.which[i,j] <- which(h.ind==feeding.s[i,j])


	output$plot <- renderPlot({
	par(mfrow=c(1,3),cex.lab=2, cex.axis=2, cex.main=2, mar=c(5,7,5,7))	
	plot(1, type="n", axes=F, xlab="", ylab="")
	legend("top", paste("day", names(day.col)),col=day.col,ncol=3, lwd=2,cex=2)
	plot(data.norm[input$name,]-1,pch=20,col=day.col.pool, main=input$name,ylab="normalized expression", xlab="hr",xaxt="n")
	axis(1,x.which,c(1,50,100,150,200,288))
	for(i in 1:nrow(feeding.which))axis(3,feeding.which[i,],rep("",2),lwd=8,col="blue",col.ticks="white", lwd.ticks=.1)
	plot(data.norm[input$name,],pch=20,col=day.col.pool, main=input$name,ylab="normalized expression + 1 (log scale)",
	log="y",xlab="hr",xaxt="n")
	axis(1,x.which,c(1,50,100,150,200,288))
	for(i in 1:nrow(feeding.which))axis(3,feeding.which[i,],rep("",2),lwd=8,col="blue", col.ticks="white", lwd.ticks=.1)
	})
}
