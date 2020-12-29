args <- commandArgs(trailingOnly=TRUE)
file = args[1]
fila = args[2]
a <- read.table(file) 
e <- a[,4]
fdr = p.adjust(e, "BH")
out<-cbind(a,fdr)
write.table(out,file= fila ,quote=FALSE,sep="\t",row.names=FALSE)
