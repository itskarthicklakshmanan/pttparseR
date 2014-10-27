########################################################################
# Script written and maintained by:
# Karthick L
# PhD student
# Bioinformatics Division
# National Facility of Marine Cyanobacteria (NFMC)
# Bhanrathidasan University
# Trichy
# email: karthick.lakshman@gmail.com
########################################################################
library(shiny)
shinyServer(function(input, output,session) {


pttdata<-reactive({ 
 if(input$url_ptt1==0){return()}
  if(input$url_ptt==0){return()}
  
input$url_ptt1
isolate({
if(input$link_choice=='Url Link'){
  con<-url(paste("ftp://ftp.ncbi.nlm.nih.gov/genomes/Bacteria/",input$url_ptt,sep=""))}else{
  inFile <- input$file1

    if (is.null(inFile))
      return(NULL)
    
    con<-file(inFile$datapath)
    
  }
  
ptt <- readLines(con)
close(con)
zz <- textConnection(ptt[-(1:2)])
x <- read.delim(zz, stringsAsFactors = FALSE)
close(zz)
y <- strsplit(x$Location, "..", fixed = TRUE)
x$start <- as.numeric(sapply(y, "[", 1))
x$end <- as.numeric(sapply(y, "[", 2))
colnames(x) <- tolower(colnames(x))
colnames(x)[c(4, 6)] <- c("gi", "id")
x$cog[x$cog == "-"] <- NA
x$gene[x$gene == "-"] <- NA

x<-data.frame(x[,c(6,10,11,2,9)])})})

  output$table<- renderDataTable({ 
pttdata()

    },options = list(aLengthMenu = c(5, 10, 15,20,25,50), iDisplayLength = 5))
	
	observe({ 
  
  	if (input$refr==0){ return()}
	input$refr
	isolate({
	updateTextInput(session=session, "pc", value="red")
	updateTextInput(session=session, "mc", value="blue")
	updateNumericInput(session=session, "gstart", value=1000)
	updateNumericInput(session=session, "gend", value=8000)
	})})
	
	
	
  output$plot<- renderPlot({ 
  
  	if (input$execute==0){ return()}
	input$execute

  data<-pttdata()
  rstart=input$gstart
  rend=input$gend
  
  	isolate({
if(input$tset==TRUE){
  plot(x=1, y=1, type="h", col="white", xlim=c(as.numeric(rstart),as.numeric(rend)), ylim=c(-10,4), xlab="", ylab="", yaxt="n",xaxt="n",bty="n")}
  else{  plot(x=1, y=1, type="h", col="white", xlim=c(as.numeric(rstart),as.numeric(rend)), ylim=c(-4,4), xlab="", ylab="", yaxt="n",xaxt="n",bty="n")}
  
box(lwd=1,col="#cccccc")
data <- data[-nrow(data),]
if (input$pc==""){pcol<-"#F1F1F1"}else{pcol<-input$pc}
if (input$mc==""){mcol<-"#F1F1F1"}else{mcol<-input$mc}
for(i in 1:nrow(data)){
if(data[i,4]=="-"){

polygon(c(data[i,2],data[i,2]+100,data[i,3],data[i,3],data[i,2]+100),c(-0.5,-0.1,-0.1,-0.9,-0.9),col =pcol,border = "#cccccc")
text((data[i,3]+data[i,2])/2,-2.5,labels=data[i,1],cex = 1, srt = 90,col = "#666666")
}
else {

polygon(c(data[i,3]-100,data[i,2],data[i,2],data[i,3]-100,data[i,3]),c(0.1,0.1,0.9,0.9,0.5),col =mcol,border = "#cccccc")
text((data[i,3]+data[i,2])/2,2.5,labels=data[i,1],cex = 1, srt = 90,col = "#666666")
}

}

segments(rstart, 0.0, rend, 0.0, col="#333333", lwd=1)


segments(rstart, -5, rend, -5, col="#f1f1f1", lwd=1)
segments(rstart, -6.5, rend, -6.5, col="#f1f1f1", lwd=1)
segments(rstart, -8, rend, -8, col="#f1f1f1", lwd=1)

    con2<-reactive({
	inFile <- input$file2

    if (is.null(inFile))
      return(NULL)
    
read.csv(inFile$datapath, sep="\t",quote=NULL)

	
	})
    con3<-reactive({
	inFile <- input$file3

    if (is.null(inFile))
      return(NULL)
    
 read.csv(inFile$datapath, sep="\t",quote=NULL)

	
	})
    con4<-reactive({
	inFile <- input$file4

    if (is.null(inFile))
      return(NULL)
    
read.csv(inFile$datapath,sep="\t",quote=NULL)

	
	})



if(input$cluster=="manual entry"){
annot<-data.frame(start=as.numeric(input$astart),end=as.numeric(input$aend),ann=as.character(input$anno))
annot1<-data.frame(start=as.numeric(input$astart1),end=as.numeric(input$aend1),ann=as.character(input$anno1))
annot2<-data.frame(start=as.numeric(input$astart2),end=as.numeric(input$aend2),ann=as.character(input$anno2))
}
else{

con2<-con2()
con3<-con3()
con4<-con4()
annot<-data.frame(start=con2[,1],end=con2[,2],ann=con2[,3])
annot1<-data.frame(start=con3[,1],end=con3[,2],ann=con3[,3])
annot2<-data.frame(start=con4[,1],end=con4[,2],ann=con4[,3])
}


if(input$tset==TRUE){
if(input$track1==TRUE){
rect(annot$start, -4.8, annot$end, -5.2, col = "#FF336620", border = "red")
text((annot$start+annot$end)/2,-5.4,labels=annot$ann,cex = 1, srt = 0,col = "#666666")}
if(input$track2==TRUE){
rect(annot1$start, -6.3, annot1$end, -6.8, col = NA, border = "red")
text((annot1$start+annot1$end)/2,-7,labels=annot1$ann,cex = 1, srt = 0,col = "#666666")}
if(input$track3==TRUE){
rect(annot2$start, -7.8, annot2$end, -8.2, col = NA, border = "red")
text((annot2$start+annot2$end)/2,-8.4,labels=annot2$ann,cex = 1, srt = 0,col = "#666666")}}

    })	    }) 	
})

