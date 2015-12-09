server <- function(input, output) {
pool.in <- read.csv("~/Desktop/TC_12day_pooled_meanspcorr_QC_normEC.csv",row.names=1)
data.norm <- data.matrix(pool.in)
cnames <- colnames(data.norm)
h.ind <- as.numeric(substr(cnames,2,4))
day.ind <- ceiling(h.ind/24)
names(day.ind) <- cnames

day.col <- rainbow(13)
day.col[c(10,13)]<-c("darkblue","pink")
day.col[5:7]<-c("aquamarine","forestgreen","lightblue")
names(day.col) <- sort(unique(day.ind))

day.col.pool <- day.col[as.character(day.ind[cnames])]

	output$plot <- renderPlot({
	par(mfrow=c(1,2))	
	plot(1, type="n", axes=F, xlab="", ylab="")
legend("top", paste("day", names(day.col)),col=day.col,ncol=4, lwd=2)
plot(data.norm[input$name,],pch=20,col=day.col.pool, main=input$name,ylab="normalized expression")
	
	})
}
