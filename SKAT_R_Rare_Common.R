## Manipulation to get the Genes for the thrombopenia
refseq_27650 <- read.delim("~/Desktop/refseq_27650.txt")
ensembl_27650 <- read.delim("~/Desktop/ensembl_27650.txt")

Gene_Refseq_TPK<- sort (unique(Gene_Refseq_TPK))
Gene_Ensembl_TPK<- sort(unique(ensembl_27650$Symbol))

Ref_And_ENSembl<- union (Gene_Ensembl_TPK,Gene_Refseq_TPK)
write.table(Ref_And_ENSembl,"Gene_TPK.txt", sep="\t", quote = F, row.names = F)


## Post analysis of the SKAT analysis from the both databases #########################
########################################################################################


#### ENSEMBL data manipulation 
Rare_ensembl <- read.delim("~/Desktop/Rare_test_Variant_ensembl.txt", header = TRUE)
dim (Rare_ensembl)
Rare_test_variant_2<- na.omit(Rare_ensembl)
row.names(Rare_test_variant_2) <- NULL
Rare_test_variant_2 <- Rare_test_variant_2[order(Rare_test_variant_2$P),] 
row.names(Rare_test_variant_2) <- NULL
Rare_test_variant_2$ALIAS<-as.character(Rare_test_variant_2$ALIAS)
str(Rare_test_variant_2)

test.split<- split(Rare_test_variant_2, Rare_test_variant_2$ALIAS) ## splitting the rare variant with the Gene 
head (test.split)

mergeData <- function(x){
  tmp.LOCUS <- paste(x$LOCUS, collapse = " | ")
  tmp.POS <- paste(x$POS, collapse = " | ")
  tmp.P <-  paste(x$P, collapse = " | ")
  tmp.NVAR<- paste(x$NVAR, collapse = " | ")
  y <- x[1,]
  y$LOCUS <- tmp.LOCUS
  y$POS <- tmp.POS 
  y$P <-tmp.P
  y$NVAR <-tmp.NVAR
  return(y)
}

d.result<-lapply(test.split,function(x) mergeData(x))
head(d.result)
tail(d.result)

require(data.table)
system.time(R_test_Processed_Ensembl<-rbindlist(d.result))

R_test_Processed_Ensembl <- R_test_Processed_Ensembl[order(R_test_Processed_Ensembl$P),]
write.table(R_test_Processed_Ensembl,"R_test_Processed_Ensembl.txt", sep="\t", quote = F, row.names = F)



## Refseq data manipulation##########################################################
#####################################################################################

Rare_test_Variant_refseq <- read.delim("~/Desktop/Rare_test_Variant_refseq.txt")
dim (Rare_test_Variant_refseq)
Rare_test_variant_3<- na.omit(Rare_test_Variant_refseq)
row.names(Rare_test_variant_3) <- NULL


Rare_test_variant_3 <- Rare_test_variant_3[order(Rare_test_variant_3$P),] 
row.names(Rare_test_variant_3) <- NULL

dummy <- Rare_test_variant_3
dummy$ALIAS<-as.character(dummy$ALIAS)


Rare_test_variant_3$ALIAS<- sapply(strsplit(dummy$ALIAS, ","), "[", 1)
Rare_test_variant_3$GENE<- sapply(strsplit(dummy$ALIAS, ","), "[", 2)


test.split_2<- split(Rare_test_variant_3, Rare_test_variant_3$GENE) ## splitting the rare variant with the Gene 
head (test.split_2)

mergeData <- function(x){
  tmp.LOCUS <- paste(x$LOCUS, collapse = " | ")
  tmp.POS <- paste(x$POS, collapse = " | ")
  tmp.P <-  paste(x$P, collapse = " | ")
  tmp.NVAR<- paste(x$NVAR, collapse = " | ")
  y <- x[1,]
  y$LOCUS <- tmp.LOCUS
  y$POS <- tmp.POS 
  y$P <-tmp.P
  y$NVAR <-tmp.NVAR
  return(y)
}

d.result_2<-lapply(test.split_2,function(x) mergeData(x))
head(d.result_2)
tail(d.result_2)

require(data.table)
system.time(R_test_Processed_Refseq<-rbindlist(d.result_2))

R_test_Processed_Refseq <- R_test_Processed_Refseq[order(R_test_Processed_Refseq$P),] 
write.table(R_test_Processed_Refseq ,"R_test_Processed_Refseq.txt", sep="\t", quote = F, row.names = F)
