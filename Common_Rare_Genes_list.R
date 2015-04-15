## Manipulation to get the Genes for the thrombopenia
refseq_27650 <- read.delim("~/Desktop/refseq_27650.txt")
ensembl_27650 <- read.delim("~/Desktop/ensembl_27650.txt")

Gene_Refseq_TPK<- sort (unique(Gene_Refseq_TPK))
Gene_Ensembl_TPK<- sort(unique(ensembl_27650$Symbol))

Ref_And_ENSembl<- union (Gene_Ensembl_TPK,Gene_Refseq_TPK)


write.table(Ref_And_ENSembl,"Gene_TPK.txt", sep="\t", quote = F, row.names = F)
