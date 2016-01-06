mergeData <- function(x){
  tmp.Data_Set <- paste(x$Data_Set, collapse = " : ")
  tmp.ID_sample <- paste(x$ID_sample, collapse = " : ")
  tmp.ID_tumour <- paste(x$ID_tumour, collapse = " : ")
  tmp.Primary.site <- paste(x$Primary.site, collapse = " : ")
  tmp.Site.subtype <- paste(x$Site.subtype, collapse = " : ")
  tmp.Primary.histology <- paste(x$Primary.histology, collapse = " : ")
  tmp.Histology.subtype<- paste(x$Histology.subtype, collapse = " : ")
  tmp.Tumour.origin<- paste(x$Tumour.origin, collapse = " : ")
  tmp.Gene.name<- paste(x$Gene.name, collapse = " : ")
  tmp.Entrez_Gene_ID<- paste(x$Entrez_Gene_ID, collapse = " : ")
  tmp.Accession.Number<- paste(x$Accession.Number, collapse = " : ")
  tmp.HGNC.ID<- paste(x$HGNC.ID, collapse = " : ")
  tmp.Refseq_mRNA_Id<- paste(x$Refseq_mRNA_Id, collapse = " : ")
  tmp.Refseq_mRNA_Id<- paste(x$Refseq_mRNA_Id, collapse = " : ")
  y <- x[1,]
  y$Accession.Number <-  tmp.Accession
  y$Mutation.CDS <- tmp.Mutation.CDS
  y$Mutation.AA <- tmp.Mutation.AA 
  return(y)
}
