ENSEMBL_Common_Leu_Gene_ANN$ALIAS<- as.character(ENSEMBL_Common_Leu_Gene_ANN$ALIAS)
ENSEMBL_Common_Leu_Gene_ANN$NVAR<- as.numeric(ENSEMBL_Common_Leu_Gene_ANN$NVAR)
system.time(test.split<- split(ENSEMBL_Common_Leu_Gene_ANN, ENSEMBL_Common_Leu_Gene_ANN$ALIAS)) ## splitting the rare variant with the Gene 
head (test.split)

mergeData <- function(x){
  tmp.LOCUS <- paste(x$LOCUS, collapse = " | ")
  tmp.POS <- paste(x$POS, collapse = " | ")
  tmp.P <-  mean(x$P)
  tmp.NVAR<- paste(x$NVAR, collapse = " | ")
  tmp.meanVAR <- mean(x$NVAR)
  y <- x[1,]
  y$LOCUS <- tmp.LOCUS
  y$POS <- tmp.POS 
  y$P <-tmp.P
  y$NVAR <-tmp.NVAR
  y$meanVAR<-tmp.meanVAR
  return(y)
}

system.time(d.result<-lapply(test.split,function(x) mergeData(x)))
head(d.result)
tail(d.result)
require(data.table)
system.time(Skat_processed <- rbindlist(d.result))
