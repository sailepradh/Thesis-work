Gene <- read.delim("~/Downloads/gene", dec=",")
glist.hg19 <- read.table("~/Downloads/glist-hg19.txt", quote="\"")
Gene <- Gene[order(-Gene$exonCount),]
Gene_dup =Gene[duplicated(Gene$name2),]
Gene_non =Gene[!duplicated(Gene$name2),]
Gene_non$chrom<- as.character(Gene_non$chrom)
Gene_non$chrom<- sapply(strsplit(Gene_non$chrom, "_"), "[",1)
Gene_non$chrom<-gsub("chr", "",Gene_non$chrom)
rownames(Gene_non)<- NULL
write.table(Gene_non,"~/Desktop/gene_list.txt", sep="\t", quote = F, row.names = F)
write.table(Gene_non[,c(3,5,6,13)],"~/Desktop/plink_gene_list.txt", sep="\t", quote = F, row.names = F, col.names=F)

#Downstreaming manipulation to get the further information of the genelist
## Gene only

table_Genes<-table(Gene_only_variant_list$Genes)
Gene_more_than_one_variant<-
  Gene_only_variant_list[Gene_only_variant_list$Genes %in% names(table_Genes)[table_Genes>1],]
Gene_one_variant<-
  Gene_only_variant_list[Gene_only_variant_list$Genes %in% names(table_Genes)[table_Genes==1],]
Gene_non_duplicated =Gene_more_than_one_variant[!duplicated(Gene_more_than_one_variant$Variants),]
write.table(Gene_non_duplicated,"~/Desktop/Files_genelist_SKAT/Gene_List_final.txt",
            sep="\t", quote = F, row.names = F, col.names=F)


## Exon only
Exon_only_variant_list <- read.delim("~/Desktop/Files_genelist_SKAT/Exon_only_variant_list.txt", header=FALSE)
colnames(Exon_only_variant_list)<- c("Genes","Variants")
table_exon<-table(Exon_only_variant_list$Genes)
Exon_more_than_one_variant<-
  Exon_only_variant_list[Exon_only_variant_list$Genes %in% names(table_exon)[table_exon>1],]
Exon_one_variant<-
  Exon_only_variant_list[Exon_only_variant_list$Genes %in% names(table_exon)[table_exon==1],]
Exon_non_duplicated = Exon_more_than_one_variant[!duplicated(Exon_more_than_one_variant$Variants),]
write.table(Exon_non_duplicated,"~/Desktop/Files_genelist_SKAT/Exon_List_final.txt",
            sep="\t", quote = F, row.names = F, col.names=F)

## Exon plus six bp
Exon_plus_only_variant_list <- read.delim("~/Desktop/Files_genelist_SKAT/Exon_plus_only_variant_list.txt", header=FALSE)
colnames(Exon_plus_only_variant_list)<- c("Genes","Variants")
table_exon_plus_six<-table(Exon_plus_only_variant_list$Genes)
Exon_plus_six_more_than_one_variant<-
  Exon_plus_only_variant_list[Exon_plus_only_variant_list$Genes %in% names(table_exon_plus_six)
                              [table_exon_plus_six>1],]
Exon_plus_six_one_variant<-
  Exon_plus_only_variant_list[Exon_plus_only_variant_list$Genes %in% names(table_exon_plus_six)
                              [table_exon_plus_six==1],]
Exon_plus_six_non_duplicated = Exon_plus_six_more_than_one_variant[!duplicated(Exon_plus_six_more_than_one_variant$Variants),]
write.table(Exon_non_duplicated,"~/Desktop/Files_genelist_SKAT/Exon_List_final.txt",
            sep="\t", quote = F, row.names = F, col.names=F)
