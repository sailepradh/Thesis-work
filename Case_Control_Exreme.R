pheno<-read.csv("pheno.csv", header=TRUE, sep =",")
pheno[c("LOG_TPK","LOG_Lpk","LOG_neu")] <- c(log(pheno$Nadir_TPK),
                                             log(pheno$Nadir_LPK), 
                                             log(pheno$Nadir_Neutrophiles))

pheno$Patient.ID<-as.factor(gsub("[_]","", pheno$Patient.ID))
## Removing the samples foles S0328, S0664, S0580, S0922, S0363 from the phenotype data 
## provided to us such that only individuals with the exome sequencing data are present.

pheno_trim<-pheno[!pheno$Patient.ID %in% c("S0328","S0664","S0580","S0922","S0363"),]
row.names(pheno_trim) <- NULL
## Number of the individual are 212

pheno_Low_extreme<-pheno_trim[which(((pheno_trim$CTC_TPK =="0") | (pheno_trim$CTC_TPK =="1"))
                      & ((pheno_trim$CTC_Neutrophiles =="0") | (pheno_trim$CTC_Neutrophiles =="1"))
                      & ((pheno_trim$CTC_LPK =="0") | (pheno_trim$CTC_LPK =="1"))) ,]

pheno_High_extreme<-pheno_trim[which(((pheno_trim$CTC_TPK =="3") | (pheno_trim$CTC_TPK =="4")) 
                                 & ((pheno_trim$CTC_Neutrophiles =="3") | (pheno_trim$CTC_Neutrophiles =="4"))
                                 & ((pheno_trim$CTC_LPK=="3") | (pheno_trim$CTC_LPK=="4"))) ,]

rownames(pheno_High_extreme)<- NULL
rownames(pheno_Low_extreme) <- NULL

pheno_High_extreme$Group<- "High Toxicity"
pheno_Low_extreme$Group<- "Low Toxicity"


pheno_High_extreme<- pheno_High_extreme[,c(28,1:27)]
pheno_High_extreme<- pheno_High_extreme[,c(1:11,26,27,28,12:25)]

pheno_Low_extreme<- pheno_Low_extreme[,c(28,1:27)]
pheno_Low_extreme<-pheno_Low_extreme[,c(1:11,26,27,28,12:25)]

## Some visualization stuffs
require(scatterplot3d)
s3d <-scatterplot3d(pheno_High_extreme$LOG_TPK,
                    pheno_High_extreme$LOG_neu,
                    pheno_High_extreme$LOG_Lpk,
                    type="h",
                    color= "red",xlim=c(0.5,7.0),ylim=c(-2.5,3.0),zlim=c(-0.85,3.0),
                    cex.symbols=0.5,cex.lab=0.60,pch=20, xlab="Log_Nadir_TPK",
                    ylab="Log_Nadir_Neutrophiles",zlab="Log_Nadir_LPK",
                    main="High Toxicity vs Low Toxicity groups")

s3d$points3d(pheno_Low_extreme$LOG_TPK,
             pheno_Low_extreme$LOG_neu,
             pheno_Low_extreme$LOG_Lpk,
             type="h",
             col="darkgreen",cex=0.5,pch=20)

pheno_High_extreme$Group<-2
pheno_Low_extreme$Group<-1
pheno_extremes <- rbind (pheno_High_extreme, pheno_Low_extreme)
dim (pheno_extremes)
phe <- pheno_extremes[,c(2,1)]
colnames(phe)<- c("#ID","phe1")
write.table(phe,"pop2.txt", sep="\t", quote = F, row.names = F)
