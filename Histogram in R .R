######################################################################
########Manipulating the phenotype data in the R and doing the phenotype information of the patients

pheno<-read.csv("pheno.csv", header=TRUE, sep =",")
pheno[c("LOG_TPK","LOG_Lpk","LOG_neu")] <- c(log(pheno$Nadir_TPK),
                                             log(pheno$Nadir_LPK), 
                                             log(pheno$Nadir_Neutrophiles))

pheno$Patient.ID<-as.factor(gsub("[_]","", pheno$Patient.ID))
## Removing the samples foles S0328, S0664, S0580, S0922, S0363 from the phenotype data 
## provided to us such that only individuals with the exome sequencing data are present.

pheno_trim<-pheno[!pheno$Patient.ID %in% c("S0328","S0580","S0631","S0664","S0667","S0724","S0922","S0363"),]
row.names(pheno_trim) <- NULL

pop<-pheno_trim[,c(1,25,26,27)]
pop$LOG_TPK<-round((pheno_trim$LOG_TPK),digit=2)
pop$LOG_Lpk<-round((pheno_trim$LOG_Lpk),digit=2)
pop$LOG_neu<-round((pheno_trim$LOG_neu),digit=2)
pop$LOG_neu[is.na(pop$LOG_neu)] <- -9
pop$LOG_neu[is.infinite(pop$LOG_neu)] <- -9
colnames(pop)<- c("#ID","Thr","Leu","Neu")
write.table(pop,"pop2.txt", sep="\t", quote = F, row.names = F)

#############################################################################################################
#############################################################################################################
## Histogram of the phenotypic data
hist(pop$LOG_neu,breaks=20,
     main="Distribution of log-converted Neutropenia ",
     ylab="Frequency of Neutropenia",
     xlab="Log converted nadir values \n",
     col="grey")
hist(pop$LOG_TPK,breaks=20, 
     col="Red",
     main="Distribution of log-converted Thrombopenia ",
     ylab="Frequency of Thrombopenia",
     xlab="Log converted nadir values \n"
     )
hist(pop$LOG_Lpk, breaks = 20, 
     col="Red",
     ain="Distribution of log-converted Leucopenia ",
     ylab="Frequency of Leucopenia",
     xlab="Log converted nadir values \n"
     )

#Your Data Compared to the Normal Distribution
#Draw Histogram, with a normal distribution over it
## For the thrombopenia score
#1) create our histogram, assign it to h, "h<-..."
h<-hist(pop$LOG_TPK,breaks=20,
     main="Distribution of log-converted Thrombopenia ",
     ylab="Frequency of Thrombopenia",
     xlab="Log converted nadir values \n",
     col="Grey")

#2) create 40 bins from our data:	
xfit <- seq(min(pheno_trim$LOG_TPK),max(pheno_trim$LOG_TPK),length=40)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean=mean(pheno_trim$LOG_TPK),,sd=sd(pheno_trim$LOG_TPK))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(pheno_trim$LOG_TPK)

#5) Plot these lines. 
lines(xfit,yfit)

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
h<-hist(pop$LOG_Lpk,breaks=20,
        main="Distribution of log-converted Leucopenia",
        ylab="Frequency of Leucopenia",
        xlab="Log converted nadir values \n",
        col="Grey")

#2) create 40 bins from our data:  
xfit <- seq(min(pheno_trim$LOG_Lpk),max(pheno_trim$LOG_Lpk),length=500)

#3) Given our data's mean and sd, find the normal distribution
yfit <- dnorm(xfit, mean=mean(pheno_trim$LOG_Lpk),,sd=sd(pheno_trim$LOG_Lpk))

#4) Fit the normal dist to our data
yfit<- yfit*diff(h$mids[1:2])*length(pheno_trim$LOG_Lpk)

#5) Plot these lines. 
lines(xfit,yfit)

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
#####################################################
###########  END of the R code #####################
