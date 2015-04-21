Whole_Variant_SKAT_Leu_ENSEMBL <- read.delim("~/Desktop/SKAT_RESULTS/Whole_Variant_SKAT_Leu_ENSEMBL")
test <- unique(Whole_Variant_SKAT_Leu_ENSEMBL$ALIAS)

library("biomaRt")
ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
filters = listFilters(ensembl)
test <- unique(Whole_Variant_SKAT_Leu_ENSEMBL$ALIAS)

Gene_GO<- getBM(attributes=c('ensembl_gene_id', "hgnc_symbol"), filters = "ensembl_gene_id", values=test, mart=ensembl)
Gene_GO$hgnc_symbol[Gene_GO$hgnc_symbol==""]<- NA
a <- unique(Whole_Variant_SKAT_Leu_ENSEMBL$ALIAS)
total <-union(a, Gene_GO$ensembl_gene_id)
diff <-setdiff(total, Gene_GO$ensembl_gene_id)
diff2 <- rep(0,658)
Missing <- data.frame(diff,diff2)
Missing$diff2<- NA
colnames(Missing)<-c("ensembl_gene_id", "hgnc_symbol")
Gene_lookup_table<- rbind(Gene_GO,Missing)
Whole_Variant_SKAT_Leu_ENSEMBL$HGNC_Symbol<-Gene_lookup_table$hgnc_symbol[match(Whole_Variant_SKAT_Leu_ENSEMBL$ALIAS,Gene_lookup_table$ensembl_gene_id)]
