phe <- read.delim("~/Downloads/phe.txt")
phe[c("TPK_Nadir_log","LPK_Nadir_log","Neutrophiles_Nadir_log")] <- c(log(phe$TPK_Nadir),
                                                                      log(phe$LPK_Nadir), 
                                                                      log(phe$Neutrophiles_Nadir))

hist(phe$TPK_Nadir_log); shapiro.test(phe$TPK_Nadir_log)
hist(phe$LPK_Nadir_log); shapiro.test(phe$LPK_Nadir_log)
hist(phe$Neutrophiles_Nadir_log); shapiro.test(phe$Neutrophiles_Nadir_log)



library(multic)

phe[c("ENQT_TPK","ENQT_Lpk","ENQT_Neu")]<-c(t.rank(phe$TPK_Nadir),
                                            t.rank(phe$LPK_Nadir),
                                            t.rank(phe$Neutrophiles_Nadir))


phe[c("Nadir_base_TPK","Nadir_base_Lpk","Nadir_base_Neu")]<- 
  c((log(phe$TPK_Nadir/phe$TPK_Baseline)),
    (log(phe$LPK_Nadir/phe$LPK_Baseline)),
    (log(phe$Neutrophiles_Nadir/phe$Neutrophiles_Baseline)))


hist(phe$Nadir_base_TPK); shapiro.test(phe$Nadir_base_TPK)
hist(phe$Nadir_base_Lpk); shapiro.test(phe$Nadir_base_Lpk)
hist(phe$Nadir_base_Neu); shapiro.test(phe$Nadir_base_Neu)

library(multic)

phe[c("ENQT_Nadir_base_TPK","ENQT_Nadir_base_Lpk","ENQT_Nadir_base_Neu")]<- 
  c((t.rank(phe$TPK_Nadir/phe$TPK_Baseline)),
    (t.rank(phe$LPK_Nadir/phe$LPK_Baseline)),
    (t.rank(phe$Neutrophiles_Nadir/phe$Neutrophiles_Baseline)))

hist(phe$ENQT_Nadir_base_TPK); shapiro.test(phe$ENQT_Nadir_base_TPK)
hist(phe$ENQT_Nadir_base_Lpk); shapiro.test(phe$ENQT_Nadir_base_Lpk)
hist(phe$ENQT_Nadir_base_Neu); shapiro.test(phe$ENQT_Nadir_base_Lpk)


pheno_trim<-phe[!phe$FID %in% c("S0328","S0664","S0580","S0922"),]
row.names(pheno_trim)<- NULL

write.table(pheno_trim,"phenotype_manipulated.txt", 
            sep="\t", quote = F, row.names = F)

## Quantitative phenotype files are generated for each individual phenotypes
write.table(pheno_trim[,c(1,2,9,10,12,22,29,32,35)],"Throm.fam", 
            sep="\t", quote = F, row.names = F, col.names=F)
write.table(pheno_trim[,c(1,2,13,14,16,23,30,33,36)],"Leu.fam", 
            sep="\t", quote = F, row.names = F,col.names=F)
phe_Neu<-pheno_trim[,c(1,2,17,18,20,24,31,34,37)]
phe_Neu[, 5:8][is.na(phe_Neu[, 5:8])] <- -9
write.table(phe_Neu,"Neu.fam", 
            sep="\t", quote = F, row.names = F,col.names=F)

## Qualitative -Case Control fil
getwd()
setwd("~/Desktop/THESIS_R FILES")

Phe_Thr_low_tox<-pheno_trim[which(pheno_trim$TPK_CTC==0 | pheno_trim$TPK_CTC==1),]
Phe_Thr_high_tox<-pheno_trim[which(pheno_trim$TPK_CTC==3 | pheno_trim$TPK_CTC==4),]

Phe_Leu_low_tox<- pheno_trim[which(pheno_trim$LPK_CTC==0 | pheno_trim$LPK_CTC==1),]
Phe_Leu_high_tox<- pheno_trim[which(pheno_trim$LPK_CTC==3 | pheno_trim$LPK_CTC==4),]

Phe_Neu_low_tox<- 
  pheno_trim[which(pheno_trim$Neutrophiles_CTC==0 | pheno_trim$Neutrophiles_CTC==1),]
Phe_Neu_high_tox<- 
  pheno_trim[which(pheno_trim$Neutrophiles_CTC==3 | pheno_trim$Neutrophiles_CTC==4),]

Phe_Thr_high_tox$Group <- 1
Phe_Thr_low_tox$Group <- 0
Phe_Thr_high_tox$phe <- 2
Phe_Thr_low_tox$phe <-1
row.names(Phe_Thr_high_tox)<- NULL
row.names(Phe_Thr_low_tox)<- NULL
Phe_Quali_Thr <- rbind(Phe_Thr_high_tox,Phe_Thr_low_tox)

write.table(Phe_Quali_Thr[,1],"Thrombopenia", 
            sep="\t", quote = F, row.names = F,col.names = F)
write.table(Phe_Quali_Thr[,c(1,2,33,39)],"Thr.fam",
            sep="\t", quote = F, row.names = F, col.names=F)


Phe_Leu_high_tox$Groups<-2
Phe_Leu_low_tox$Groups<-1
Phe_Leu_high_tox$phe <- 2
Phe_Leu_low_tox$phe <-1
row.names(Phe_Leu_high_tox)<- NULL
row.names(Phe_Leu_low_tox)<- NULL
Phe_Quali_Leu <- rbind(Phe_Leu_high_tox,Phe_Leu_low_tox)

write.table(Phe_Quali_Leu[,1],"Leucopenia", 
            sep="\t", quote = F, row.names = F,col.names = F)
write.table(Phe_Quali_Leu[,c(1,2,33,39)],"Leu.fam",
            sep="\t", quote = F, row.names = F, col.names= F)


Phe_Neu_high_tox$Group <- 1
Phe_Neu_low_tox$Group <- 0
Phe_Neu_high_tox$phe <- 2
Phe_Neu_low_tox$phe <- 1
row.names(Phe_Neu_high_tox)<- NULL
row.names(Phe_Neu_low_tox)<- NULL
Phe_Quali_Neu <- rbind(Phe_Neu_high_tox,Phe_Neu_low_tox)

write.table(Phe_Quali_Neu[,1],"Neutropenia", 
            sep="\t", quote = F, row.names = F,col.names = F)
write.table(Phe_Quali_Neu[,c(1,2,33,39)],"Neu.fam",
            sep="\t", quote = F, row.names = F)


#############################################################################################################
##############################################################################################################
## Histogram of the phenotypic data
## For the individual phenotype data doing the histogram diagram


pdf("Histogramplot.pdf", width= 9.85, height = 6.50)
par(mfrow=c(3,3))

## Part 1 doing the normal histogram for the phenotype values
hist(phe$TPK_Nadir, breaks =20, 
     col = "Red", 
     main= "Distribution of Nadir Thrombopenia", 
     ylab= "Frequency of Thrombopenia",
     xlab="Nadir values Thrombopenia \n",
     cex.lab=0.80, cex.main = 0.80)


# create our histogram, assign it to h, "h<-..."
h<-hist(phe$TPK_Nadir_log,breaks=20,
        main="Distribution of log-converted Thrombopenia ",
        ylab="Frequency of Thrombopenia",
        xlab="Log converted nadir values \n",
        col="Grey", cex.lab=0.80, cex.main = 0.80)

#2) create 40 bins from our data:  
xfit <- seq(min(phe$TPK_Nadir_log, na.rm=TRUE),max(phe$TPK_Nadir_log,na.rm=TRUE),length=10000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean (phe$TPK_Nadir_log, na.rm=TRUE),,sd=sd(phe$TPK_Nadir_log, na.rm=TRUE))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(phe$TPK_Nadir_log)

#5) Plot these lines. 
lines(xfit,yfit)

## doing the similar stuffs with the ENQT data 

h <-hist(phe$ENQT_TPK, breaks =20, 
     col = "light blue", 
     main= "Distribution of ENQT Nadir Thrombopenia", 
     ylab= "Frequency of Thrombopenia",
     xlab="Nadir values Thrombopenia \n",
     cex.lab=0.80, cex.main = 0.80)

#2) create 40 bins from our data:  
  xfit <- seq(min(phe$ENQT_TPK, na.rm=TRUE),max(phe$ENQT_TPK,na.rm=TRUE),length=10000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean (phe$ENQT_TPK, na.rm=TRUE),,sd=sd(phe$ENQT_TPK, na.rm=TRUE))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(phe$ENQT_TPK)

#5) Plot these lines. 
lines(xfit,yfit)

####################################################

#par(mfrow=c(1,3))

## leucopenia histogram
hist(phe$LPK_Nadir, breaks =20, 
     col = "Red", 
     main= "Distribution of Nadir Leucopenia", 
     ylab= "Frequency of Leucopenia",
     xlab="Nadir values Leucopenia \n",
     cex.lab=0.80, cex.main = 0.80)

# create our histogram, assign it to h, "h<-..."
h<-hist(phe$LPK_Nadir_log, breaks=20,
        main="Distribution of log-converted Leucopenia ",
        ylab="Frequency of Leucopenia",
        xlab="Log converted nadir values \n",
        col="Grey", cex.lab=0.80, cex.main = 0.80)

#2) create 40 bins from our data:  
xfit <- seq(min(phe$LPK_Nadir_log, na.rm=TRUE),max(phe$LPK_Nadir_log,na.rm=TRUE),length=10000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean (phe$LPK_Nadir_log, na.rm=TRUE),,sd=sd(phe$LPK_Nadir_log, na.rm=TRUE))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(phe$LPK_Nadir_log)

#5) Plot these lines. 
lines(xfit,yfit)


## Drawing histogram diagam for ENQT data 
h <-hist(phe$ENQT_Lpk, breaks =20, 
         col = "light blue", 
         main= "Distribution of ENQT Nadir Leucopenia", 
         ylab= "Frequency of Leucopenia",
         xlab="Nadir values Leucopenia \n",
         cex.lab=0.80, cex.main = 0.80)

#2) create 40 bins from our data:  
xfit <- seq(min(phe$ENQT_Lpk, na.rm=TRUE),max(phe$ENQT_Lpk,na.rm=TRUE),length=10000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean (phe$ENQT_Lpk, na.rm=TRUE),,sd=sd(phe$ENQT_Lpk, na.rm=TRUE))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(phe$ENQT_Lpk)

#5) Plot these lines. 
lines(xfit,yfit)

#############################################################################
###### Neutropenia data transformed
## neutropenia histogram
#par(mfrow=c(1,3))

hist(phe$Neutrophiles_Nadir, breaks =20, 
     col = "Red", 
     main= "Distribution of Nadir Neutropenia", 
     ylab= "Frequency of Neutropenia ",
     xlab="Nadir values Neutropenia  \n",
     cex.lab=0.80, cex.main = 0.80)

# create our histogram, assign it to h, "h<-..."
h<-hist(phe$Neutrophiles_Nadir_log, breaks=20,
        main="Distribution of log-converted Neutropenia ",
        ylab="Frequency of Neutropenia ",
        xlab="Log converted nadir values \n",
        col="Grey", cex.lab=0.80, cex.main = 0.80)

#2) create 40 bins from our data:  
xfit <- seq(min(phe$Neutrophiles_Nadir_log, na.rm=TRUE),max(phe$Neutrophiles_Nadir_log,na.rm=TRUE),length=10000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean (phe$Neutrophiles_Nadir_log, na.rm=TRUE),,sd=sd(phe$Neutrophiles_Nadir_log, na.rm=TRUE))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(phe$Neutrophiles_Nadir_log)

#5) Plot these lines. 
lines(xfit,yfit)

## Doing similar stuffs for Neutropenia 

h <-hist(phe$ENQT_Neu, breaks =20, 
         col = "light blue", 
         main= "Distribution of ENQT Nadir Neutropenia", 
         ylab= "Frequency of Neutropenia",
         xlab="Nadir values Neutropenia \n",
         cex.lab=0.80, cex.main = 0.80)

#2) create 40 bins from our data:  
xfit <- seq(min(phe$ENQT_Neu, na.rm=TRUE),max(phe$ENQT_Neu,na.rm=TRUE),length=10000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean (phe$ENQT_Neu, na.rm=TRUE),,sd=sd(phe$ENQT_Neu, na.rm=TRUE))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(phe$ENQT_Neu)

#5) Plot these lines. 
lines(xfit,yfit)
dev.off()

#########################################################
################### Single variant association for both log transofrmed and ENQT phenotype data
Common_Thr_LN_assoc <- read.table("~/Downloads/Common_LN_SNV_Thr.assoc.linear", header=TRUE, quote="\"")
Common_Thr_LN_assoc_adj <- read.table("~/Downloads/Common_LN_SNV_Thr.assoc.linear.adjusted", header=TRUE, quote="\"")
Common_Thr_ENQT_assoc <- read.table("~/Downloads/Common_ENQT_SNV_TPK.assoc.linear", header=TRUE, quote="\"")
Common_Thr_ENQT_assoc_adj <- read.table("~/Downloads/Common_ENQT_SNV_TPK.assoc.linear.adjusted", header=TRUE, quote="\"")


library(gplots)
library(qqman)

pdf("SVA_THR.pdf", height=350, width=400)
par(mfrow=c(1,2))
qq(Common_Thr_LN_assoc_adj$UNADJ, 
   main ="Common variants Log transformed \n TPK (Unadjusted p-values)",
   cex.lab=0.50, cex.main = 0.750)
qq(Common_Thr_ENQT_assoc_adj$UNADJ, 
   main ="Common variants ENQT \n TPK (Unadjusted p-values)",
   cex.lab=0.50, cex.main = 0.750)
dev.off()

Common_Thr_LN_assoc<-Common_Thr_LN_assoc[complete.cases
                                          (Common_Thr_LN_assoc[,9]),]
Common_Thr_ENQT_assoc<-Common_Thr_ENQT_assoc[complete.cases
                                             (Common_Thr_ENQT_assoc[,9]),]

par(mfrow=c(1,1))
height =400, width=850
manhattan(Common_Thr_LN_assoc, chr = "CHR",  bp = "BP",p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          main ="Common variants Log transformed TPK \n(Unadjusted p-values)",
          cex.lab=1.0, cex.main = 1.0, cex.axis = 0.5)
manhattan(Common_Thr_ENQT_assoc, chr = "CHR",  bp = "BP",p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          main ="Common variants ENQT transformed TPK \n(Unadjusted p-values)",
          cex.lab=1.0, cex.main = 1.0,cex.axis = 0.5)
dev.off()


High_P_val_Log_Thr <- Common_Thr_LN_assoc[which(Common_Thr_LN_assoc$P <= 1.00e-03),] ##82
row.names(High_P_val_Log_Thr)<-NULL
High_P_val_ENQT_Thr<- Common_Thr_ENQT_assoc[which(Common_Thr_ENQT_assoc$P<= 1.00e-03),] ##79
row.names(High_P_val_ENQT_Thr) <- NULL

length(setdiff(High_P_val_Log_Thr$SNP,High_P_val_ENQT_Thr$SNP)) #24
length(setdiff(High_P_val_ENQT_Thr$SNP,High_P_val_Log_Thr$SNP)) ##21
length(intersect(High_P_val_Log_Thr$SNP, High_P_val_ENQT_Thr$SNP)) ##58

install.packages("VennDiagram")
library(VennDiagram)
grid.newpage()
draw.pairwise.venn(82, 79,58, category = c("LN TPK", "ENQT TPK"), lty = rep("blank", 2), 
                   fill = c("blue", "green"), alpha = rep(0.5, 2), cat.pos = c(-0,0), 
                   cat.dist = rep(0.025, 2), scaled = FALSE, cex.main = 0.50, cat.cex =2.0,cex=4.0)

TEST1<- rep("dbsnp",79)
TEST2<- rep("dbsnp",82)
write.table(cbind(TEST1,High_P_val_Log_Thr$SNP),"TPK_LN.txt",sep="\t", quote=FALSE,row.names=FALSE)
write.table(cbind(TEST2,High_P_val_ENQT_Thr$SNP),"TPK_ENQT.txt",sep="\t", quote=FALSE, row.names= FALSE)


Common_test<-intersect(High_P_val_Log_Thr$SNP, High_Tox_ENQT_TPK$SNP)
Test3<-rep("dbsnp",30)
write.table(cbind(Test3,Common_test),"High_Tox_TPK_LN_ENQT.txt",sep="\t", quote=FALSE,
            row.names=FALSE)
## Finding the commonality between the 2 phenotype transformation methods and showing in 
## Venn diagrams
grid.newpage()
draw.pairwise.venn(46,31,25, category = c("High-Tox LN TPK", "High-Tox ENQT TPK"), 
                   lty = rep("blank", 2), 
                   fill = c("blue", "green"), alpha = rep(0.5, 2), cat.pos = c(-0,0), 
                   cat.dist = rep(0.025, 2), scaled = FALSE, cex.main = 0.50, cat.cex =2.0,cex=4.0)

write.table(unique(refseq_19849$Gene),"High_Tox_TPK_LN_ENQT_genes.txt",sep="\t", quote=FALSE,
            row.names=FALSE)

## Segregating into high toxicity and low toxicity based on the beta values
High_Tox_Log_TPK <- High_P_val_Log_Thr[which(High_P_val_Log_Thr$BETA<0),]
 ## 46 High toxicity SNPs
  ## 36 low toxicity SNps
row.names(High_Tox_Log_TPK) <- NULL
High_Tox_ENQT_TPK<- High_P_val_ENQT_Thr[which(High_P_val_ENQT_Thr$BETA<0),]
## 31 High Toxicity SNps
## 48 Low Toxicity Snps
row.names(High_Tox_ENQT_TPK)<- NULL


Reduce(intersect,  list(High_Tox_Log_TPK$SNP, 
                        High_Tox_ENQT_TPK$SNP,
                        High_P_val_CC_Thr$SNP))
## "rs56070322" "rs10496192" "rs61739531" "rs4808" "rs2298141" 


library(gplots)
library(VennDiagram)
venn.plot<-venn.diagram(x = list(TPK_LN=High_Tox_Log_TPK$SNP, 
                                 TPK_ENQT=High_Tox_ENQT_TPK$SNP,
                                 TPK_CC=High_P_val_CC_Thr$SNP),
                        filename = "TPK_SNV_all.tiff",
                        col = "black",
                        lty = "blank",
                        lwd = 4,
                        fill = c("cornflowerblue", "green", "yellow"),
                        alpha = 0.50,
                        cex = 1.5,
                        fontfamily = "serif",
                        fontface = "bold",
                        cat.col = c("darkblue", "darkgreen", "orange"),
                        cat.cex = 1.0)


#############################################################################
## Doing the similar stuffs with leucopenia
############################################################################

Common_ENQT_Leu_assoc<- read.table("~/Downloads/Common_ENQT_SNV_LPK.assoc.linear", header=TRUE, quote="\"")
Common_ENQT_Leu_adj <- read.table("~/Downloads/Common_ENQT_SNV_LPK.assoc.linear.adjusted", header=TRUE, quote="\"")
Common_LN_Leu_assoc <- read.table("~/Downloads/Common_LN_SNV_LPK.assoc.linear", header=TRUE, quote="\"")
Common_LN_Leu_adj <- read.table("~/Downloads/Common_LN_SNV_LPK.assoc.linear.adjusted", header=TRUE, quote="\"")


library(gplots)
library(qqman)
pdf("SVA_Leu.pdf", height=350, width=400)
par(mfrow=c(1,2))
qq(Common_LN_Leu_adj$UNADJ, 
   main ="Common variants Log transformed LPK \n(Unadjusted p-values)",
   cex.lab=0.750, cex.main = 0.75, cex.axis=0.5)
qq(Common_ENQT_Leu_adj$UNADJ, 
   main ="Common variants ENQT LPK \n(Unadjusted p-values)",
   cex.lab=0.750, cex.main = 0.75, cex.axis= 0.5)
dev.off()

Common_ENQT_Leu_assoc<-Common_ENQT_Leu_assoc[complete.cases(Common_ENQT_Leu_assoc[,9]),]
Common_LN_Leu_assoc<-Common_LN_Leu_assoc[complete.cases(Common_LN_Leu_assoc[,9]),]


height =400, width=850
manhattan(Common_LN_Leu_assoc, chr = "CHR",  bp = "BP",p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          main ="Common variants Log transformed LPK \n(Unadjusted p-values)",
          cex.lab=0.75, cex.main = 0.75, cex.axis=0.5)
manhattan(Common_ENQT_Leu_assoc, chr = "CHR",  bp = "BP",p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          main ="Common variants ENQT LPK \n (Unadjusted p-values),",
          cex.lab=0.75, cex.main = 0.75, cex.axis=0.5)

High_P_values_Log_LPK <- Common_LN_Leu_assoc[which(Common_LN_Leu_assoc$P <= 1.00e-03),] ##136
High_P_Values_ENQT_LPK<- Common_ENQT_Leu_assoc[which(Common_ENQT_Leu_assoc$P<= 1.00e-03),] ##66

length(setdiff(High_P_values_Log_LPK$SNP,High_P_Values_ENQT_LPK$SNP)) #81
length(setdiff(High_P_Values_ENQT_LPK$SNP,High_P_values_Log_LPK$SNP)) #11
length(intersect(High_P_values_Log_LPK$SNP, High_P_Values_ENQT_LPK$SNP)) ##55

install.packages("VennDiagram")
library(VennDiagram)

grid.newpage()
draw.pairwise.venn(66, 136, 55, category = c("ENQT LPK","LN LPK"), lty = rep("blank", 2), 
                   fill = c("blue", "green"), alpha = rep(0.5, 2), cat.pos = c(-0,0), 
                   cat.dist = rep(0.025, 2), scaled = FALSE, cex.main = 0.50, cat.cex =2.0,cex=4.0)

##################################################################################
## Dividing into high and low toxicity variants and doing the analysis
#################################################################################
High_Tox_Log_LPK <- High_P_values_Log_LPK[which(High_P_values_Log_LPK$BETA<0),]
## 81 High toxicity SNPs
## 55 low toxicity SNps
row.names(High_Tox_Log_LPK) <- NULL
High_Tox_ENQT_LPK<- High_P_Values_ENQT_LPK[which(High_P_Values_ENQT_LPK$BETA<0),]
## 22 High Toxicity SNps
## 44 Low Toxicity Snps
row.names(High_Tox_ENQT_LPK)<- NULL

## Comparing between the two transformation 
Common_High_toxicity<- intersect(High_Tox_ENQT_LPK$SNP, High_Tox_Log_LPK$SNP)
grid.newpage()
draw.pairwise.venn(22, 81, 18, category = c("High-Tox ENQT LPK","High- Tox LN LPK"), lty = rep("blank", 2), 
                   fill = c("blue", "green"), alpha = rep(0.5, 2), cat.pos = c(-0,0), 
                   cat.dist = rep(0.025, 2), scaled = FALSE, cex.main = 0.50, cat.cex =2.0,cex=4.0)

remove()
write.table(unique(refseq_25940$Gene),"High_Tox_LPK_LN_ENQT_genes.txt",sep="\t", quote=FALSE,
            row.names=FALSE)


Reduce(intersect,  list(High_Tox_Log_LPK$SNP, 
                        High_Tox_ENQT_LPK$SNP,
                        High_P_values_CC_Leu$SNP))

## rs8018462

library(gplots)
library(VennDiagram)
venn.plot<-venn.diagram(x = list(LPK_LN=High_Tox_Log_LPK$SNP, 
                                 LPK_ENQT=High_Tox_ENQT_LPK$SNP,
                                 LPK_CC=High_P_values_CC_Leu$SNP),
                        filename = "LPK_SNV_all.tiff",
                        col = "black",
                        lty = "blank",
                        lwd = 4,
                        fill = c("cornflowerblue", "green", "yellow"),
                        alpha = 0.50,
                        cex = 1.5,
                        fontfamily = "serif",
                        fontface = "bold",
                        cat.pos = c(-10,10,-10),
                        cat.col = c("darkblue", "darkgreen", "orange"),
                        cat.cex = 1.0)




## Doing the similar stuffs with Neutropenia
Common_Neu_ENQT_assoc <- read.table("~/Downloads/Common_ENQT_SNV_NPK.assoc.linear", header=TRUE, quote="\"")
Common_Neu_ENQT_adjusted <- read.table("~/Downloads/Common_ENQT_SNV_NPK.assoc.linear.adjusted", header=TRUE, quote="\"")
Common_Neu_LN.assoc <- read.table("~/Downloads/Common_LN_SNV_NPK.assoc.linear", header=TRUE, quote="\"")
Common_Neu_LN_adjusted <- read.table("~/Downloads/Common_LN_SNV_NPK.assoc.linear.adjusted", header=TRUE, quote="\"")

library(gplots)
library(qqman) 
height=350, width=400
par(mfrow=c(1,2))
qq(Common_Neu_LN_adjusted$UNADJ, 
   main ="Common variants Log transformed NPK \n(Unadjusted p-values)",
   cex.lab=0.750, cex.main = 0.750, cex.axis=0.50)
qq(Common_Neu_ENQT_adjusted$UNADJ, 
   main ="Common variants ENQT NPK  \n(Unadjusted p-values)",
   cex.lab=0.750, cex.main = 0.75, cex.axis=0.50)

Common_Neu_ENQT_assoc<-Common_Neu_ENQT_assoc[complete.cases(Common_Neu_ENQT_assoc[,9]),]
Common_Neu_LN.assoc<-Common_Neu_LN.assoc[complete.cases(Common_Neu_LN.assoc[,9]),]

par(mfrow=c(1,1))
height =400, width=850

manhattan(Common_Neu_LN.assoc, chr = "CHR",  bp = "BP",p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          main ="Common variants LN NPK \n(Unadjusted p-values)",
          cex.lab=0.75, cex.main = 0.75,cex.axis=0.5)
manhattan(Common_Neu_ENQT_assoc, chr = "CHR",  bp = "BP",p = "P", snp = "SNP",
          col = c("gray10", "gray60"), chrlabs = NULL,
          suggestiveline = -log10(1e-05), genomewideline = -log10(5e-08),
          main ="Common variants ENQT NPK \n(Unadjusted p-values),",
          cex.lab=0.75, cex.main = 0.75,cex.axis=0.5)

High_P_val_Neu_Log <- Common_Neu_LN_adjusted[which(Common_Neu_LN_adjusted$UNADJ <= 1.00e-03),] ##77
High_P_val_Neu_ENQT<- Common_Neu_ENQT_adjusted[which(Common_Neu_ENQT_adjusted$UNADJ<= 1.00e-03),] ##79

length(setdiff(High_P_val_Neu_Log$SNP,High_P_val_Neu_ENQT$SNP))  ##5
length(setdiff(High_P_val_Neu_ENQT$SNP,High_P_val_Neu_Log$SNP)) #7
length(intersect(High_P_val_Neu_Log$SNP, High_P_val_Neu_ENQT$SNP)) ##72

library(VennDiagram)
grid.newpage()
draw.pairwise.venn(77, 79, 72, 
                   category = c("LN NPK", "ENQT NPK"), 
                   lty = rep("blank", 2), 
                   fill = c("blue", "green"), alpha = rep(0.5, 2), cat.pos = c(-10,10), 
                   cat.dist = rep(0.025, 2), scaled = FALSE, cex.main = 0.50,
                   cat.cex =2.0,cex=4.0)
## Finding the common between the three phenotypes in both the
## For Log transformed data

##################################################################################
## Dividing into high and low toxicity variants and doing the analysis
#################################################################################
High_Tox_Log_Neu<- High_P_val_Neu_Log[which(High_P_val_Neu_Log$BETA<0),]
## 33 High toxicity SNPs
## 46 low toxicity SNps
row.names(High_Tox_Log_Neu) <- NULL
High_Tox_ENQT_Neu<- High_P_val_Neu_ENQT[which(High_P_val_Neu_ENQT$BETA<0),]
## 36 High Toxicity SNps
## 43 Low Toxicity Snps
row.names(High_Tox_ENQT_Neu)<- NULL

## Comparing between the two transformation 
Common_High_toxicity<- intersect(High_Tox_ENQT_Neu$SNP, High_Tox_Log_Neu$SNP)
grid.newpage()
draw.pairwise.venn(36, 33, 31, category = c("High-Tox ENQT NPK","High- Tox LN NPK"), lty = rep("blank", 2), 
                   fill = c("blue", "green"), alpha = rep(0.5, 2), cat.pos = c(-0,0), 
                   cat.dist = rep(0.025, 2), scaled = FALSE, cex.main = 0.50,
                   cat.cex =2.0,cex=4.0)

Test3<-rep("dbsnp",31)
write.table(cbind(Test3,Common_High_toxicity),"High_Tox_NPK_LN_ENQT.txt",sep="\t", quote=FALSE,
            row.names=FALSE)
write.table(unique(refseq_12387$Gene),"High_Tox_NPK_LN_ENQT_genes.txt",sep="\t", quote=FALSE,
            row.names=FALSE)


Reduce(intersect,  list(High_Tox_ENQT_Neu$SNP, 
                        High_Tox_Log_Neu$SNP,
                        High_P_val_Neu_CC$SNP))
"rs55842403" "rs1049172" 


library(gplots)
library(VennDiagram)
venn.plot<-venn.diagram(x = list(NPK_LN=High_Tox_Log_Neu$SNP, 
                                 NPK_ENQT=High_Tox_ENQT_Neu$SNP,
                                 NPK_CC=High_P_val_Neu_CC$SNP),
                        filename = "LPK_SNV_all.tiff",
                        col = "black",
                        lty = "blank",
                        lwd = 4,
                        fill = c("cornflowerblue", "green", "yellow"),
                        alpha = 0.50,
                        cex = 1.5,
                        fontfamily = "serif",
                        fontface = "bold",
                        #cat.pos = c(-0,0,-0),
                        cat.col = c("darkblue", "darkgreen", "orange"),
                        cat.cex = 1.0)









#Kernal Density Plots
density<-density(pheno_trim$LOG_TPK)
plot(density)

#fancy it up
plot(density,
     main="Kernal Density for Thrombopenia ",
     xlab="Log Nadir Thrombopenia",
     ylab="Density",
     col="red"
)
polygon(density,col="grey")



## For the leucopenia data 
#1) create our histogram, assign it to h, "h<-..."
pdf("Log_normalized_leucopenia.pdf")
h<-hist(pheno_trim$LPK_Nadir_log,breaks=20,
        main="Distribution of log-converted Leucopenia",
        ylab="Frequency of Leucopenia",
        xlab="Log converted nadir values \n",
        col="red")

#2) create 40 bins from our data:  
xfit <- seq(min(pheno_trim$LPK_Nadir_log),max(pheno_trim$LPK_Nadir),length=5000)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean=mean(pheno_trim$LPK_Nadir_log),,sd=sd(pheno_trim$LPK_Nadir_log))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(pheno_trim$LPK_Nadir_log)

#5) Plot these lines. 
lines(xfit,yfit)
dev.off()

#Kernal Density Plots
density<-density(pheno_trim$LOG_Lpk)
plot(density)

#fancy it up
plot(density,
     main="Kernal Density for Leucopenia ",
     xlab="Log Nadir Leucopenia",
     ylab="Density",
     col="red"
)
polygon(density,col="grey")



## For the Neutropenia data 
#1) create our histogram, assign it to h, "h<-..."
h<-hist(pop$LOG_neu,breaks=20,
        main="Distribution of log-converted Neutropenia",
        ylab="Frequency of Neutropenia",
        xlab="Log converted nadir values \n",
        col="Grey")

#2) create 40 bins from our data: 
range(pheno_trim$LOG_neu,na.rm=TRUE,finite=TRUE)
xfit <- seq(-2.407946,2.917771,length=1000)

#3) Given our data's mean and sd, find the normal distribution
test<-pheno_trim[!(is.na(pheno_trim$LOG_neu) | is.infinite(pheno_trim$LOG_neu)),]
yfit <- dnorm(xfit, mean=mean(test$LOG_neu),,sd=sd(test$LOG_neu))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(pheno_trim$LOG_Lpk)

#5) Plot these lines. 
lines(xfit,yfit)

#Kernal Density Plots
density<-density(pheno_trim$LOG_Lpk)
plot(density)

#fancy it up
plot(density,
     main="Kernal Density for Neutropenia ",
     xlab="Log Nadir Neutropenia",
     ylab="Density",
     col="red"
)
polygon(density,col="grey")


#################################################################
###############################################################
counts <- table(phe$Smoking_history, phe$Gender)
counts1 <- table(phe$Histological_type, phe$Gender)
count2<- table(phe$Pathological_Stage, phe$Gender)
counts4<-table(phe$Treatment, phe$Gender)
counts5 <- table(phe$Histological_type, phe$Smoking_history)
counts6 <- table (phe$Pathological_Stage, phe$Smoking_history)
counts7 <- table(phe$Age, phe$Smoking_history)

pdf("Gendervsallother.pdf", width= 9.27, height = 6.25)
par(mfrow=c(1,5))


barplot(table(phe$Gender), main="Counts of gender in study cohort",
        xlab="Gender", ylab="Number of patients",
        col=c("Red", "Green"), cex.lab=1.00, cex.main = 0.75,
        space=0.50, ylim = c(0, 150))
legend("topleft", c("Female", "Male"), 
       col =colors, pch=c(19,19,19), cex= 0.75, box.lwd = 0,box.col = "white",bg = "white")


barplot(counts, main="Gender and Smoking History",
        xlab="Gender", ylab="Number of patients",
        col=c("Red","green", "yellow"),cex.lab=1.00, cex.main = 0.75,
        space=0.50,ylim = c(0, 150))
legend("topleft", c("Current", "Former", "Never"), col =c("Red", "Green", "Yellow"), 
       pch=c(19,19,19), cex = 0.75, box.lwd = 0,box.col = "white",bg = "white")


barplot(counts1, main="Gender and Lung Cancer Histology",
        xlab="Gender", ylab="Number of patients",
        col=c("Red","green", "yellow", "Blue","Pink"),cex.lab=1.00, cex.main = 0.75,
        space=0.50,ylim = c(0, 150))
legend("topleft", c("ACC", "LCC", "NSCLC","Other", "SCC"), 
       col =c("Red", "Green", "Yellow", "Blue","Pink"), 
       pch=c(19,19,19), cex = 0.75, box.lwd = 0,box.col = "white",bg = "white")


colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan") 
barplot(count2, main="Gender and Pathological Stage",
        xlab="Gender", ylab="Number of patients",
        col=colors, cex.lab=1.00, cex.main = 0.75,
        space=0.50, ylim = c(0, 150))
legend("topleft", c("-", "Ia", "Ib","IIa", "IIb", "IIIa","IIIb","IV"), 
       col =colors, pch=c(20,20,20,20,20,20,20,20), cex= 0.75,
       box.lwd = 0,box.col = "white",bg = "white")


barplot(counts4, main="Gender and Treatment types",
        xlab="Gender", ylab="Number of patients",
        col=c("Red","green"),cex.lab=1.00, cex.main = 0.75,
        space=0.50,ylim = c(0, 150))
legend("topleft", c("Adjuvant_treatment", "Advanced_disease"), col =c("Red", "Green"), 
       pch=c(20,20) cex = 0.75,
       box.lwd = 0,box.col = "white",bg = "white")

dev.off()

pdf("Smokinghistorysallother.pdf", width= 9.27, height = 6.25)
par(mfrow=c(1,2))
barplot(counts5, main="Smoking History and Histological subtypes",
        xlab="Smoking history", ylab="Number of patients",
        col=c("Red","green", "yellow", "Blue","Pink"),cex.lab=1.00, cex.main = 0.75,
        space=0.700,ylim = c(0, 180))
legend("topleft", c("AC", "LCC","NSCLC","Other","SCC"), 
       col=c("Red","green", "yellow", "Blue","Pink"), 
       pch=c(19,19,19),cex = 0.75,
       box.lwd = 0,box.col = "white",bg = "white")


barplot(counts6, main="Smoking History and Pathological stages",
        xlab="Smoking history", ylab="Number of patients",
        col=colors, cex.lab=1.00, cex.main = 0.75,
        space=0.70, ylim = c(0, 200))
legend("topleft", c("-", "Ia", "Ib","IIa", "IIb", "IIIa","IIIb","IV"), 
       col =colors, pch=c(19,19,19,19,19,19,19,19), cex = 0.65,
      box.col = "white",bg = "white")
#text(3,3,"Hello World Default")

dev.off()


###############################################
pdf("NadirvsBaseline.pdf", width= 9.00, height = 6.00)

par(mfrow=c(1,3))

boxplot(TPK_Baseline ~ TPK_CTC, phe, boxwex= 0.25,col = "Green",
        at=1:5-0.2, xlab = " CTC scores", main ="Comparison of baseline and nadir values",
        ylab=" Count of Thrombocytes",ylim = c(0, ceiling(max(phe$TPK_Baseline, na.rm=TRUE))+500),
        yaxs ="i")
boxplot(TPK_Nadir~ TPK_CTC, phe, boxwex = 0.25, col = "Yellow",
        at= 1:5+0.2, add =TRUE)
legend("topleft", c("Baseline TPK Values", "Nadir TPK Values"), col =c( "Green", "Yellow"), 
       pch=c(19,19,19),box.lwd = 0,box.col = "white",bg = "white", cex=1.25)


boxplot(LPK_Baseline ~ LPK_CTC, phe, boxwex= 0.25,col = "Green",
        at=1:5-0.2, xlab = " CTC scores", main ="Comparison of baseline and nadir values",
        ylab=" Count of Leukocytes",ylim = c(0, ceiling(max(phe$LPK_Baseline))+5),
        yaxs ="i")
boxplot(LPK_Nadir ~ LPK_CTC, phe, boxwex = 0.25, col = "Yellow",
        at= 1:5+0.2, add =TRUE)
legend("topleft", c("Baseline LPK Values", "Nadir LPK Values"), col =c( "Green", "Yellow"), 
       pch=c(19,19,19),box.lwd = 0,box.col = "white",bg = "white",cex=1.25)

boxplot(Neutrophiles_Baseline ~ Neutrophiles_CTC, phe, boxwex= 0.25,col = "Green",
        at=1:5-0.2, xlab = " CTC scores", main ="Comparison of baseline and nadir values",
        ylab=" Count of Neutrophils",ylim = c(0, ceiling(max(phe$Neutrophiles_Baseline, na.rm=TRUE))+5),
        yaxs ="i")
boxplot(Neutrophiles_Nadir ~ Neutrophiles_CTC, phe, boxwex = 0.25, col = "Yellow",
        at= 1:5+0.2, add =TRUE)
legend("topleft", c("Baseline NPK Values", "Nadir NPK Values"), col =c( "Green", "Yellow"), 
       pch=c(19,19,19),box.lwd = 0,box.col = "white",bg = "white",cex=1.25)

dev.off()


################################################
# Create Line Chart

#################################
Sequencing_Results <- read.csv("~/Desktop/Sequencing_Results.csv", sep=";")
colnames(Sequencing_Results)<-c("SampleID","Raw_Reads", "Quality_Reads",
                                "Mapped_Reads","Proper_Pair_Reads_Mapped",
                                "Usable_Reads_after_duplicates")

data<-Sequencing_Results[,-1]
names<-Sequencing_Results[,1]
data<- data/(1e6)
data <-t(data)
data <- data.frame(data)
colnames(data)<-names

max_y<-max(data[1,])+20

pdf("Sequencing_Results.pdf", width= 9.85, height = 6.50)
pdf("Sequencing_Result_2.pdf", width=10.75, height=6.50)
plot(data$S0561, type="o", ylim = c(0,max_y), axes=FALSE, ann=FALSE)
axis(1, at=1:5, lab=c("Raw_reads", "Quality_Reads", 
                      "Mapped_Reads", "Proper_pair_reads_Mapped", 
                      "Usable_Reads"), cex.axis=0.75)
axis(2, las=1, cex.axis=0.75)
box()
lines(data$S1169, type ="o", pch=22, lty =2, col="red")
lines(data$S1422, type ="o", pch=22, lty =2, col="dark green")
title (main="Read Counts in Mapping and Alignment Of Reads", cex.main=0.75) 
title (xlab = "Figure a: Quality Control metrices in Mapping and Alignment of Reads", cex.lab=0.75) 
title (ylab = "Read Counts in millions",cex.lab=0.75)

legend("topleft", c("S0561","S1169","S1422"), 
       col =c("black","red","dark green"), pch=c(1,22,22), 
       cex = 0.75,
       box.col = "white",bg = "white")
dev.off()





## For the bigger files
##Read counts after each steps inGATK filter
sequenicng <- read.csv("~/Desktop/sequenicng.csv", sep=";", dec=",")
colnames(sequenicng)<- c("SampleID","Raw_Reads", "Quality_Reads",
                         "Mapped_Reads","Proper_Pair_Reads_Mapped",
                         "Usable_Reads")
data<-sequenicng[,-1]
names<-sequenicng[,1]
data <-t(data)
data <- data.frame(data)
colnames(data)<-names
names<-sequenicng[,1]
max_y<- max(sequenicng$Raw_Reads)+10

test<-data.frame(sapply(sequenicng[,-1], mean))
colnames(test)<- "mean"


pdf("Sequencing_Results_all_samples.pdf", width= 9.85, height = 6.50)
plot(test$mean, type="o", 
     ylim = c(0,max_y), 
     axes=FALSE, ann=FALSE, 
    col="red", pch=16)
axis(1, at=1:5, lab=c("Raw_reads", "Quality_Reads", 
                      "Mapped_Reads", "Proper_pair_reads_Mapped", 
                      "Usable_Reads"),cex.axis=0.5)
axis(2, las=1)
box()

for(i in 1:length(names)){
  lines(data[,i], type ="b", pch=22, lty =2, col="green")
}


title (main="Read Counts in Reads Mapping and Alignment") 
title (xlab = "Quality Control Steps in Mapping and Alignment of Reads") 
title (ylab = "Read Counts in millions")

dev.off()

par(mfrow=c(1,2)) 

plot(data$S0561, type="o", ylim = c(0,max_y), axes=FALSE, ann=FALSE)
axis(1, at=1:5, lab=c("Raw_reads", "Quality_Reads", 
                      "Mapped_Reads", "Proper_pair_reads_Mapped", 
                      "Usable_Reads"), cex.axis=0.5)
axis(2, las=1, cex.axis=0.75)
box()
lines(data$S1169, type ="o", pch=22, lty =2, col="red")
lines(data$S1422, type ="o", pch=22, lty =2, col="dark green")
title (main="Read Counts in Mapping and Alignment Of Reads", cex.main=0.75) 
title (xlab = "Figure a: Mapping and Alignment of Reads for Three Exomes", cex.lab=0.75) 
title (ylab = "Read Counts in millions",cex.lab=0.75)

legend("topleft", c("S0561","S1169","S1422"), 
       col =c("black","red","dark green"), pch=c(1,22,22), 
       cex = 0.75,
       box.col = "white",bg = "white")

plot(test$mean, type="o", 
     ylim = c(0,max_y), 
     axes=FALSE, ann=FALSE, 
     col="red", pch=16)
axis(1, at=1:5, lab=c("Raw_reads", "Quality_Reads", 
                      "Mapped_Reads", "Proper_pair_reads_Mapped", 
                      "Usable_Reads"),cex.axis=0.5)
axis(2, las=1,cex.axis=0.75)
box()

for(i in 1:length(names)){
  lines(data[,i], type ="b", pch=22, lty =2, col="green")
}


title (main="Read Counts in Reads Mapping and Alignment",cex.main=0.75) 
title (xlab = "Figure b: Mapping and Alignment of Reads for all Exomes",cex.lab=0.75) 
title (ylab = "Read Counts in millions",cex.lab=0.75)


### Finding the genes that are present in any of the two methods
##TPK
All_genes<-Reduce(union, list(ENQT_Decrease$SetID, 
                              ENQT_Nadir$SetID, 
                              LN_Decrease$SetID, 
                              LN_Nadir$SetID))
GroupLN_Nadir.f <- All_genes %in% LN_Nadir$SetID
GroupLN_Decrease.f <- All_genes %in% LN_Decrease$SetID
GroupENQT_Decrease.f <- All_genes %in% ENQT_Decrease$SetID
GroupENQT_Nadir <- All_genes %in% ENQT_Nadir$SetID
input.df<- data.frame(LN_Nadir=GroupLN_Nadir.f, 
                      LN_Decrease= GroupLN_Decrease.f, 
                      ENQT_Nadir= GroupENQT_Nadir, 
                      ENQT_Decrease = GroupENQT_Decrease.f)


library(gplots)
venn(input.df)
test<- input.df*1
test$gene<-All_genes
test$count<-rowSums(test[-5])
test[which(test$count >=2),]$gene
write.table(test[which(test$count >=2),]$gene,
                "Gene_based_result_TPK", sep="\t", quote = F, row.names = F)

venn.plot<-venn.diagram(x = list(LN_Decrease=LN_Decrease$SetID, 
                                 LN_Nadir=LN_Nadir$SetID,
                                 ENQT_Decrease= ENQT_Decrease$SetID, 
                                 ENQT_Nadir=ENQT_Nadir$SetID),
                        filename = "TPK_ENQT.tiff",
                        col = "black",
                        lty = "blank",
                        lwd = 4,
                        fill = c("cornflowerblue", "green", "yellow", "darkorchid1"),
                        alpha = 0.50,
                        label.col = c("orange", "white", "darkorchid4", "white", "white", "white",
                                      "white", "white", "darkblue", "white",
                                      "white", "white", "white", "darkgreen", "white"),
                        cex = 1.5,
                        fontfamily = "serif",
                        fontface = "bold",
                        cat.col = c("darkblue", "darkgreen", "orange", "darkorchid4"),
                        cat.cex = 1.0)

Reduce(intersect,  list(ENQT_Decrease$SetID, 
                        ENQT_Nadir$SetID,
                        LN_Decrease$SetID, 
                        LN_Nadir$SetID))


##LPK
All_genes_LPK<-Reduce(union, list(LN_Nadir_LPK$SetID, LN_Decrease_LPK$SetID, 
                              ENQT_Nadir_LPK$SetID,ENQT_Decrease_LPK$SetID))

GroupLN_Nadir.f <- All_genes_LPK %in% LN_Nadir_LPK$SetID
GroupLN_Decrease.f <- All_genes_LPK %in% LN_Decrease_LPK$SetID
GroupENQT_Nadir.f <- All_genes_LPK %in% ENQT_Nadir_LPK$SetID
GroupENQT_Decrease.f <- All_genes_LPK %in% ENQT_Decrease_LPK$SetID


input.df<- data.frame(LN_Nadir_LPK=GroupLN_Nadir.f, 
                      LN_Decrease_LPK= GroupLN_Decrease.f, 
                      ENQT_Nadir_LPK= GroupENQT_Nadir.f, 
                      ENQT_Decrease_LPK = GroupENQT_Decrease.f)
library(gplots)
venn(input.df)
test<- input.df*1
test$gene<-All_genes_LPK
test$count<-rowSums(test[-5])
test[which(test$count >=2),]$gene
write.table(test[which(test$count >=2),]$gene,
            "Gene_based_result_LPK", sep="\t", quote = F, row.names = F)

venn.plot<-venn.diagram(x = list(LN_Decrease=LN_Decrease_LPK$SetID, 
                                 LN_Nadir=LN_Nadir_LPK$SetID,
                                 ENQT_Decrease= ENQT_Decrease_LPK$SetID, 
                                 ENQT_Nadir=ENQT_Nadir_LPK$SetID),
                        filename = "LPJ_Gene_Based.tiff",
                        col = "black",
                        lty = "blank",
                        lwd = 4,
                        fill = c("cornflowerblue", "green", "yellow", "darkorchid1"),
                        alpha = 0.50,
                        label.col = c("orange", "white", "darkorchid4", "white", "white", "white",
                                      "white", "white", "darkblue", "white",
                                      "white", "white", "white", "darkgreen", "white"),
                        cex = 1.5,
                        fontfamily = "serif",
                        fontface = "bold",
                        cat.col = c("darkblue", "darkgreen", "orange", "darkorchid4"),
                        cat.cex = 1.0,
                        )
Reduce(intersect,  list(ENQT_Decrease_LPK$SetID, 
                        ENQT_Nadir_LPK$SetID, LN_Decrease_LPK$SetID, 
                        LN_Nadir_LPK$SetID))

##NPK
All_genes_NPK<-Reduce(union, list(LN_Nadir_NPK$SetID, LN_Decrease_NPK$SetID, 
                                  ENQT_Nadir_NPK$SetID,ENQT_Decrease_NPK$SetID))

GroupLN_Nadir.f <- All_genes_NPK %in% LN_Nadir_NPK$SetID
GroupLN_Decrease.f <- All_genes_NPK %in% LN_Decrease_NPK$SetID
GroupENQT_Nadir.f <- All_genes_NPK %in% ENQT_Nadir_NPK$SetID
GroupENQT_Decrease.f <- All_genes_NPK %in% ENQT_Decrease_NPK$SetID

input.df<- data.frame(LN_Nadir_NPK=GroupLN_Nadir.f, 
                      LN_Decrease_NPK= GroupLN_Decrease.f, 
                      ENQT_Nadir_NPK= GroupENQT_Nadir.f, 
                      ENQT_Decrease_NPK = GroupENQT_Decrease.f)

library(gplots)
venn(input.df)
test<- input.df*1
test$gene<-All_genes_NPK
test$count<-rowSums(test[-5])
test[which(test$count >=2),]$gene
write.table(test[which(test$count >=2),]$gene,
            "Gene_based_result_NPK", sep="\t", quote = F, row.names = F)
Reduce(intersect,  list(ENQT_Decrease_NPK$SetID, 
                        ENQT_Nadir_NPK$SetID, 
                        LN_Decrease_NPK$SetID, 
                        LN_Nadir_NPK$SetID))

venn.plot<-venn.diagram(x = list(LN_Decrease=LN_Decrease_NPK$SetID, 
                                 LN_Nadir=LN_Nadir_NPK$SetID,
                                 ENQT_Decrease= ENQT_Decrease_NPK$SetID, 
                                 ENQT_Nadir=ENQT_Nadir_NPK$SetID),
                        filename = "NPK_ENQT.tiff",
                        col = "black",
                        lty = "blank",
                        lwd = 4,
                        fill = c("cornflowerblue", "green", "yellow", "darkorchid1"),
                        alpha = 0.50,
                        label.col = c("orange", "white", "darkorchid4", "white", "white", "white",
                                      "white", "white", "darkblue", "white",
                                      "white", "white", "white", "darkgreen", "white"),
                        cex = 1.5,
                        fontfamily = "serif",
                        fontface = "bold",
                        cat.col = c("darkblue", "darkgreen", "orange", "darkorchid4"),
                        cat.cex = 1.0)

