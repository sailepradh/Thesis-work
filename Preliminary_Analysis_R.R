pheno<-read.csv("pheno.csv", header=TRUE, sep =",")
pheno[c("LOG_TPK","LOG_Lpk","LOG_neu")] <- c(log(pheno$Nadir_TPK), log(pheno$Nadir_LPK), log(pheno$Nadir_Neutrophiles))
pheo_out <- pheno[, c(1,8,9,10,25,26,27)]
write.table(pheo_out,"Pheno.txt", sep=",", quote = F, row.names = F)

pheno_Low_tox<-pheno[which(((pheno$CTC_TPK =="0") | (pheno$CTC_TPK =="1")) & ((pheno$CTC_Neutrophiles =="0") | (pheno$CTC_Neutrophiles =="1"))) ,]
pheno_High_tox<-pheno[which(((pheno$CTC_TPK =="3") | (pheno$CTC_TPK =="4")) & ((pheno$CTC_Neutrophiles =="3") | (pheno$CTC_Neutrophiles =="4"))) ,]



################################################################################
### in case to test whether there is different result when considering the LPK values as well

pheno_Low_tox_test<-pheno[which(((pheno$CTC_TPK =="0") | (pheno$CTC_TPK =="1"))
                           & ((pheno$CTC_Neutrophiles =="0") | (pheno$CTC_Neutrophiles =="1"))
                          & ((pheno$CTC_LPK =="0") | (pheno$CTC_LPK =="1"))) ,]

pheno_High_tox_test<-pheno[which(((pheno$CTC_TPK =="3") | (pheno$CTC_TPK =="4")) 
                                 & ((pheno$CTC_Neutrophiles =="3") | (pheno$CTC_Neutrophiles =="4"))
                                 & ((pheno$CTC_LPK=="3") | (pheno$CTC_LPK=="4"))) ,]


s3d <-scatterplot3d(pheno_High_tox_test$LOG_TPK,
                    pheno_High_tox_test$LOG_neu,
                    pheno_High_tox_test$LOG_Lpk,
                    type="h",
                    color= "red",xlim=c(0.5,7.0),ylim=c(-2.5,3.0),zlim=c(-0.85,3.0),
                    cex.symbols=0.5,cex.lab=0.60,pch=20, xlab="Log_Nadir_TPK",
                    ylab="Log_Nadir_Neutrophiles",zlab="Log_Nadir_LPK",
                    main="High Toxicity vs Low Toxicity groups")
s3d$points3d(pheno_Low_tox_test$LOG_TPK,
             pheno_Low_tox_test$LOG_neu,
             pheno_Low_tox_test$LOG_Lpk,
             type="h",
             col="darkgreen",cex=0.5,pch=20)

##############################################################################

plot(pheno_Low_tox_test$Nadir_TPK, pheno_Low_tox_test$Nadir_Neutrophiles, col= "Green", pch = 19, xlab = "Nadir TPK", 
     ylab ="Nadir Neutophile", main= "Distribution of Nadir values in Different phenotypes", xlim = c(0,700) , ylim=c(0,25), cex =0.5,frame.plot=FALSE)
points(pheno_High_tox_test$Nadir_TPK, pheno_High_tox_test$Nadir_Neutrophiles, col= "red", pch = 19, xlab = "Nadir TPK", 
       ylab ="Nadir Neutophile", main= "Distribution of Nadir values in different phenotypes",xlim = c(0,700) , ylim=c(0,25), cex =0.5,frame.plot=FALSE)
legend(0,22, c("Extreme", "Normal"), col =c("Red", "Green"), pch=c(19,19), cex = 0.8)

## plot(pheno_normal$LOG_TPK, pheno_normal$LOG_neu, col= "Green", pch = 19, xlab = "LOG Nadir TPK", 
## ylab ="LOG Nadir Neutophile", main= "Distribution of LOG Nadir values in Different phenotypes", xlim = c(0, 7.5) , ylim=c(0,25), cex =0.5,frame.plot=FALSE)

sample_pheno_extreme<- as.character(pheno_High_tox_test$Patient.ID)
sample_pheno_normal<- as.character(pheno_Low_tox$Patient.ID)

table(pheno_Low_tox$Pathological.Stage)
table(pheno_High_tox$Pathological.Stage)

table(pheno_Low_tox$Gender)
table(pheno_High_tox$Gender)

table(pheno_Low_tox$Histological.type)
table(pheno_High_tox$Histological.type)

table(pheno_Low_tox$Smoking.history)
table(pheno_High_tox$Smoking.history)

table(pheno_High_tox$Treatment)
table(pheno_Low_tox$Treatment)

##THESE PHENOTYPIC CHARACTERSTIC BETWEEN THE 2 GROUP OF INDVIDUALS ARE MORE OF LESS SIMILAR
## Does the treatment regime such that adjuvant and advanced treatment affects the drug toxicity. Is this a variable to consider.
## Because what we see from here when individuals with the low toxicity effect has gine through relatively lesser adjuvant treatment and more advanced
## treatment which might have effect in the drug toxicity. But there is relatively equal amount of treatment regimen in the high toxicity individuals.

## BARPLOT OF THE AGE OF START OF TREATMENT
par (mfrow =c(1,2))
counts <- table(pheno_High_tox$Age.at.start)
counts1<- table(pheno_Low_tox$Age.at.start)

plot(counts, main = "Treatment Age in Extreme phenotypes", xlab="Age.at.start", col= "red")
plot(counts1, main = "Treatment Age in Normal phenotypes", xlab="Age.at.start", col= "Green")

## THUS from this analysis I propose the distinction of the two groups as the low tox and high tox and may be see the analysis from here. As we did
## with the differential analysis in the microarray analysis does that concept work here???

pheno_High_tox$Group<- "High Toxicity"
pheno_Low_tox$Group<- "Low Toxicity"
row.names(pheno_High_tox) <- NULL
row.names(pheno_Low_tox)<- NULL

pheno_High_tox<- pheno_High_tox[,c(28,1:27)]
pheno_High_tox<- pheno_High_tox[,c(1:11,26,27,28,12:25)]
pheno_High_tox$Patient.ID<- gsub("_", "",pheno_High_tox$Patient.ID)
pheno_Low_tox<- pheno_Low_tox[,c(28,1:27)]
pheno_Low_tox<-pheno_Low_tox[,c(1:11,26,27,28,12:25)]
pheno_Low_tox$Patient.ID<- gsub("_", "",pheno_Low_tox$Patient.ID)


## Qualitative classification of the toxicity phenotypes
Pheno_Hig_tox_Qual<-pheno_High_tox[,c(1,2)] 
Pheno_Low_tox_Qual<-pheno_Low_tox [,c(1,2)] 

## Quantitative classification of the toxicity phenotypes
Pheno_Hig_tox_Quan <- pheno_High_tox[,c(2,9,10,11,12,13,14)]
Pheno_Low_tox_Quan <- pheno_Low_tox[,c(2,9,10,11,12,13,14)]




#########
s3d <-scatterplot3d(pheno_High_tox$LOG_TPK,
                    pheno_High_tox$LOG_neu,
                    pheno_High_tox$LOG_Lpk,
                    type="h",
                    color= "red",xlim=c(0.5,7.0),ylim=c(-2.5,3.0),zlim=c(-0.85,3.0),
                    cex.symbols=0.5,cex.lab=0.60,pch=20, xlab="Log_Nadir_TPK",
                    ylab="Log_Nadir_Neutrophiles",zlab="Log_Nadir_LPK",
                    main="High Toxicity vs Low Toxicity groups")
s3d$points3d(pheno_Low_tox$LOG_TPK,
             pheno_Low_tox$LOG_neu,
             pheno_Low_tox$LOG_Lpk,
             type="h",
             col="darkgreen",cex=0.5,pch=20)

