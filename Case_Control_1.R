## Case-Control Study- Taking extreme of Nadir Thrombopenia and Neutropenia 
pheno<-read.csv("pheno.csv", header=TRUE, sep =",")
pheno[c("LOG_TPK","LOG_Lpk","LOG_neu")] <- c(log(pheno$Nadir_TPK),
                                             log(pheno$Nadir_LPK), 
                                             log(pheno$Nadir_Neutrophiles))
pheno$Patient.ID<-as.factor(gsub("[_]","", pheno$Patient.ID))


## Removing the files S0328, S0664,S0580,S0922,S1056,S0363 such that the phenotype data is such that 
## equal to the ones in the exome data
pheno_trim<-pheno[!pheno$Patient.ID %in% c("S0328","S0664","S0580","S0922","S0363"),]
row.names(pheo_trim)<- NULL

pheno_Low_tox<-pheno_trim[which(((pheno_trim$CTC_TPK =="0") | (pheno_trim$CTC_TPK =="1")) & 
                             ((pheno_trim$CTC_Neutrophiles =="0") | (pheno_trim$CTC_Neutrophiles =="1"))) ,]
rownames(pheno_Low_tox) <- NULL
write.table(pheno_Low_tox$Patient.ID,"Control", sep="\t", quote = F, row.names = F)

pheno_High_tox<-pheno_trim[which(((pheno_trim$CTC_TPK =="3") | (pheno_trim$CTC_TPK =="4")) & 
                              ((pheno_trim$CTC_Neutrophiles =="3") | (pheno_trim$CTC_Neutrophiles =="4"))) ,]
rownames(pheno_High_tox)<- NULL
write.table(pheno_High_tox$Patient.ID,"Case", sep="\t", quote = F, row.names = F)


## Manipulation for loading the phenotype information from the individual group
pheno_High_tox$Group<- "High Toxicity"
pheno_Low_tox$Group<- "Low Toxicity"
pheno_High_tox<- pheno_High_tox[,c(28,1:27)]
pheno_High_tox<- pheno_High_tox[,c(1:11,26,27,28,12:25)]
pheno_High_tox$Group<-2
pheno_Low_tox$Group<-1
pheno_Case_Control<- rbind(pheno_Low_tox,pheno_High_tox)
dim (pheno_Case_Control)
phe <- pheno_Case_Control[,c(2,1)]
colnames(phe)<- c("#ID","phe1")
write.table(phe,"pop.txt", sep="\t", quote = F, row.names = F)
