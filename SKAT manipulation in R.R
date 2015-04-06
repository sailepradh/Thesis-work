Skattest_rareVariant <- read.delim("~/Desktop/Skattest_rareVariant.txt")
dim (Skattest_rareVariant)
unique(Skattest_rareVariant$LOCUS)
length(unique(Skattest_rareVariant$LOCUS))
SKAT_real<-Skattest_rareVariant[complete.cases(Skattest_rareVariant),]
rownames(SKAT_real)<- NULL
SKAT_real<- SKAT_real[order(SKAT_real$P),]
rownames(SKAT_real)<- NULL
test<- SKAT_real[order(SKAT_real$P),]
rownames(test)<-NULL
SKAT_real$ALIAS<-as.character(SKAT_real$ALIAS)
str(SKAT_real)
test$ALIAS<- sapply(strsplit(SKAT_real$ALIAS, ","), "[", 1)
test$GENES<- sapply(strsplit(SKAT_real$ALIAS, ","), "[", 2)

test.split<-split (test,test$GENES)

mergeData <- function(x){
  tmp.LOCUS <- paste(x$LOCUS, collapse = " | ")
  y <- x[1,]
  y$LOCUS <- tmp.LOCUS
  return(y)
}


source("merge.R")
d.result<-lapply(test.split,function(x) mergeData(x))
head(d.result)
tail(d.result)
install.packages("data.table")
require(data.table)
system.time(Skat_processed <- rbindlist(d.result))
write.table (Skat_processed,"~/Dropbox/Skat_processed.txt", sep=","
             , quote = F, row.names = F)

p.adjust.M <- p.adjust.methods[p.adjust.methods != "fdr"]
p.adj    <- sapply(p.adjust.M, function(meth) p.adjust(Skat_processed$P, meth))



             

