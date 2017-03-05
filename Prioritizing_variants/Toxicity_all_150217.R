###############################################################################################

## Function for getting alternnate and reference from the intermediate files
## All toxicity : Annotation level = 1

###############################################################################################

setwd("~/Desktop/hightox_lowtox/LPK/ANN_1/")

Common_NC_HT_all_tox <- read.table("Common_NC_ANN1_HT_LPK_new_tox", quote="\"", comment.char="")
Common_NC_LT_all_tox <- read.table("Common_NC_ANN1_LT_LPK_new_tox", quote="\"", comment.char="")

Common_all_HT <- altfreq(Common_NC_HT_all_tox)
Common_all_LT <- altfreq(Common_NC_LT_all_tox)

#delta_HT_ALL <- Common_all_HT/Common_all_LT
#delta_LT_ALL <- Common_all_LT/Common_all_HT

delta_LPK_HT <- Common_all_HT/Common_all_LT
delta_LPK_LT <- Common_all_LT/Common_all_HT

index = which((delta_LPK_HT != "Inf") & (delta_LPK_HT !="0") & (!(is.na(delta_LPK_HT))))
index = which((delta_LPK_LT != "Inf") & (delta_LPK_LT !="0") & (!(is.na(delta_LPK_LT))))

Common_NC_HT_all_tox_2 <- Common_NC_HT_all_tox[index,]
Common_NC_LT_all_tox_2 <- Common_NC_LT_all_tox[index,]

Common_all_HT_clean <- Common_all_HT[index]
Common_all_LT_clean <- Common_all_LT[index]

#delta_HT_All_2<- Common_all_HT_clean/Common_all_LT_clean 
#delta_LT_All_2<- Common_all_LT_clean/Common_all_HT_clean

delta_HT_LPK_2<- Common_all_HT_clean/Common_all_LT_clean 
delta_LT_LPK_2<- Common_all_LT_clean/Common_all_HT_clean

###############################################################################################
## Visualization stuffs (optional at this point)
###############################################################################################
par(mar=c(7,7,7,2)+0.1)

plot(Common_all_HT_clean, delta_HT_All_2, pch = 20, col ="darkred", 
     xlab="Common toxicity alternate frequency in Low toxicity LPK group", ylab="Delta score",
     main ="Priorotized common non coding variants with LPK toxicity", 
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(delta_LT_All_2, pch =20, col="red", 
     xlab="Common variants with noncoding marks", ylab="Delta score", 
     main ="Priorized common non variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(unique(delta_LT_All_2), pch =20, col="green4",
     xlab="Common variants with noncoding marks", ylab="Unique Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

plot(sort(delta_LT_All_2), pch =20, col="lightseagreen",
     xlab="Prioritized variants with marks", ylab="Sorted Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)


# index = which((delta != "Inf") & (delta !="0") & (!(is.na(delta))))
# Common_NC_HT_all_tox_2 <- Common_NC_HT_all_tox[index,]
# Common_NC_LT_all_tox_2 <- Common_NC_LT_all_tox[index,]
# index = which((delta_LPK != "Inf") & (delta_LPK !="0") & (!(is.na(delta_LPK))))
# Common_NC_HT_all_tox_2 <- Common_NC_HT_all_tox[index,]
# Common_NC_LT_all_tox_2 <- Common_NC_LT_all_tox[index,]
# plot(delta, pch =20, col = "red")
# plot(unique(delta), pch =20, col = "red")
## There is some values which have NaN values because it was divided by 0
# Common_all_HT_clean <- altfreq(Common_NC_HT_all_tox_2)
# Common_all_LT_clean <- altfreq(Common_NC_LT_all_tox_2)
# delta_2<- Common_all_HT_clean/Common_all_LT_clean
# delta_2_LPK <- Common_all_HT_clean/Common_all_LT_clean
# delta_2_LPK <- Common_all_HT_clean/Common_all_LT_clean
# delta_2_LPK <- Common_all_HT_clean/Common_all_LT_clean


###############################################################################################
## Computing scores for the individual phenotypes

###############################################################################################
## ALL

# score_1_HT <- thres(delta_HT_All_2)
# score_1_LT <- thres(delta_LT_All_2)


###############################################################################################
## LPK

score_1_LPK_HT <- thres(delta_HT_LPK_2)
score_1_LPK_LT <- thres(delta_LT_LPK_2)

###############################################################################################
## LPK 

# length(sort(delta_2_LPK, decreasing =TRUE))
# test1_LPK <- (delta_2_LPK)/max(delta_2_LPK ,na.rm = TRUE)
# sort_test1_LPK <- sort(test1_LPK,decreasing = TRUE)
# score_1_LPK <- thres(sort_test1_LPK)


###############################################################################################
## LPK

# length(sort(delta_2_LPK, decreasing =TRUE))
# test1_LPK <- (delta_2_LPK)/max(delta_2_LPK ,na.rm = TRUE)
# sort_test1_LPK <- sort(test1_LPK,decreasing = TRUE)
# score_1_LPK <- thres(sort_test1_LPK)



###############################################################################################
###############################################################################################

## Function for getting alternnate and reference from the intermediate files
## All toxicity: Annotation level = 2

###############################################################################################
###############################################################################################

setwd("~/Desktop/hightox_lowtox/LPK/ANN_2/")

Common_NC_HT_ANN2_all_tox <- read.table("Common_NC_ANN2_HT_LPK_new_tox", quote="\"", comment.char="")
Common_NC_LT_ANN2_all_tox <- read.table("Common_NC_ANN2_LT_LPK_new_tox", quote="\"", comment.char="")

Common_all_ANN2_HT <- altfreq(Common_NC_HT_ANN2_all_tox)
Common_all_ANN2_LT <- altfreq(Common_NC_LT_ANN2_all_tox)

#delta_HT_ANN2_all <- Common_all_ANN2_HT/Common_all_ANN2_LT
#delta_LT_ANN2_all <- Common_all_ANN2_LT/Common_all_ANN2_HT

delta_HT_ANN2_LPK <- Common_all_ANN2_HT/Common_all_ANN2_LT
delta_LT_ANN2_LPK <- Common_all_ANN2_LT/Common_all_ANN2_HT

# delta_ANN2_LPK<- Common_all_ANN2_HT/Common_all_ANN2_LT
# delta_ANN2_LPK<- Common_all_ANN2_HT/Common_all_ANN2_LT

index = which((delta_HT_ANN2_LPK != "Inf") & (delta_HT_ANN2_LPK !="0") & (!(is.na(delta_HT_ANN2_LPK))))
index = which((delta_LT_ANN2_LPK != "Inf") & (delta_LT_ANN2_LPK !="0") & (!(is.na(delta_LT_ANN2_LPK))))

Common_NC_HT_ANN2_all_tox_2 <- Common_NC_HT_ANN2_all_tox[index,]
Common_NC_LT_ANN2_all_tox_2 <- Common_NC_LT_ANN2_all_tox[index,]

Common_all_ANN2_HT_clean <- Common_all_ANN2_HT[index]
Common_all_ANN2_LT_clean <- Common_all_ANN2_LT[index]

#delta_HT_ANN2_All_2 <- Common_all_ANN2_HT_clean/Common_all_ANN2_LT_clean
#delta_LT_ANN2_All_2 <- Common_all_ANN2_LT_clean/Common_all_ANN2_HT_clean

delta_HT_ANN2_LPK_2 <- Common_all_ANN2_HT_clean/Common_all_ANN2_LT_clean
delta_LT_ANN2_LPK_2 <- Common_all_ANN2_LT_clean/Common_all_ANN2_HT_clean


###############################################################################################
## Computing scores for the individual phenotypes

###############################################################################################
## ALL

#score_2_HT <- thres(delta_HT_ANN2_All_2)
#score_2_LT <- thres(delta_LT_ANN2_All_2)

###############################################################################################
## LPK

score_2_LPK_HT <- thres(delta_HT_ANN2_LPK_2)
score_2_LPK_LT <- thres(delta_LT_ANN2_LPK_2)

###############################################################################################
## LPK

# test2_LPK <- (delta_ANN2_LPK_2)/max(delta_ANN2_LPK_2, na.rm = TRUE)
# 
# sort_test2_LPK <- sort(test2_LPK, decreasing=TRUE)
# 
# score_2_LPK <- thres(sort_test2_LPK)


###############################################################################################
## LPK

# test2_LPK <- (delta_ANN2_LPK_2)/max(delta_ANN2_LPK_2, na.rm = TRUE)
# 
# sort_test2_LPK <- sort(test2_LPK, decreasing=TRUE)
# 
# score_2_LPK <- thres(sort_test2_LPK)


###############################################################################################
## Visualization stuffs (optional at this point)

###############################################################################################

par(mar=c(7,7,7,2)+0.1)
plot(Common_all_ANN2_HT_clean, delta_LT_ANN2_All_2, pch = 20, col ="darkred", 
     xlab="Common toxicity alternate frequency in Low toxicity LPK group", ylab="Delta score",
     main ="Priorotized common non coding variants with LPK toxicity", 
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(delta_LT_ANN2_All_2, pch =20, col="red", 
     xlab="Common variants with noncoding marks", ylab="Delta score", 
     main ="Priorized common non variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(unique(delta_LT_ANN2_All_2), pch =20, col="green4",
     xlab="Common variants with noncoding marks", ylab="Unique Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

plot(sort(delta_LT_ANN2_All_2), pch =20, col="lightseagreen",
     xlab="Prioritized variants with marks", ylab="Sorted Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)




###############################################################################################
###############################################################################################
## All toxicity : Annotation level = 3

setwd("~/Desktop/hightox_lowtox/LPK/ANN_3/")

Common_NC_HT_ANN3_tox <- read.table("Common_NC_ANN3_HT_LPK_new_tox", quote="\"", comment.char="")
Common_NC_LT_ANN3_tox <- read.table("Common_NC_ANN3_LT_LPK_new_tox", quote="\"", comment.char="")

Common_ANN3_HT <- altfreq(Common_NC_HT_ANN3_tox)
Common_ANN3_LT <- altfreq(Common_NC_LT_ANN3_tox)

#delta_HT_ANN3_all <- Common_ANN3_HT/Common_ANN3_LT
#delta_LT_ANN3_all <- Common_ANN3_LT/Common_ANN3_HT

delta_HT_ANN3_LPK <- Common_ANN3_HT/Common_ANN3_LT
delta_LT_ANN3_LPK <- Common_ANN3_LT/Common_ANN3_HT

index = which((delta_HT_ANN3_LPK != "Inf") & (delta_HT_ANN3_LPK !="0") & (!(is.na(delta_HT_ANN3_LPK))))
index = which((delta_LT_ANN3_LPK != "Inf") & (delta_LT_ANN3_LPK !="0") & (!(is.na(delta_LT_ANN3_LPK))))

Common_NC_HT_ANN3_tox_2 <- Common_NC_HT_ANN3_tox[index,]
Common_NC_LT_ANN3_tox_2 <- Common_NC_LT_ANN3_tox[index,]

Common_ANN3_HT_clean <- Common_ANN3_HT[index]
Common_ANN3_LT_clean <- Common_ANN3_LT[index]

#delta_HT_ANN3_all_2 <- Common_ANN3_HT_clean/Common_ANN3_LT_clean
#delta_LT_ANN3_all_2  <- Common_ANN3_LT_clean/Common_ANN3_HT_clean

delta_HT_ANN3_LPK_2 <- Common_ANN3_HT_clean/Common_ANN3_LT_clean
delta_LT_ANN3_LPK_2 <- Common_ANN3_LT_clean/Common_ANN3_HT_clean

dim(Common_NC_HT_ANN3_tox[which(delta_HT_ANN3_LPK == "Inf"),]) ### Gives the number of high toxcity only varaints
dim(Common_NC_LT_ANN3_tox[which(delta_HT_ANN3_LPK == 0),]) ### Gives the number of low toxcity only varaints

###############################################################################################
## Computing scores for the individual phenotypes

###############################################################################################
## ALL
#score_3_HT <- thres(delta_HT_ANN3_all_2)
#score_3_LT <- thres(delta_LT_ANN3_all_2)


###############################################################################################
## LPK
score_3_LPK_HT <- thres(delta_HT_ANN3_LPK_2)
score_3_LPK_LT <- thres(delta_LT_ANN3_LPK_2)

###############################################################################################
## LPK

# test3_LPK <- (delta_3_2_LPK)/max(delta_3_2_LPK, na.rm = TRUE)
# 
# sort_test3_LPK <- sort(test3_LPK, decreasing=TRUE)
# 
# score_3_LPK <- thres(sort_test3_LPK)

###############################################################################################
## LPK

# test3_LPK <- (delta_3_2_LPK)/max(delta_3_2_LPK, na.rm = TRUE)

# sort_test3_LPK <- sort(test3_LPK, decreasing=TRUE)

# score_3_LPK <- thres(sort_test3_LPK)


###############################################################################################
## Visualization stuffs (optional at this point)

###############################################################################################

par(mar=c(7,7,7,2)+0.1)
plot(Common_ANN3_HT_clean, delta3_LT_2, pch = 20, col ="darkred", 
     xlab="Common toxicity alternate frequency in Low toxicity LPK group", ylab="Delta score",
     main ="Priorotized common non coding variants with LPK toxicity", 
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(delta3_LT_2, pch =20, col="red", 
     xlab="Common variants with noncoding marks", ylab="Delta score", 
     main ="Priorized common non variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(unique(delta3_LT_2), pch =20, col="green4",
     xlab="Common variants with noncoding marks", ylab="Unique Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

plot(sort(delta3_LT_2), pch =20, col="lightseagreen",
     xlab="Prioritized variants with marks", ylab="Sorted Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)


###############################################################################################
###############################################################################################
## All toxicity : Annotation level = 4

setwd("~/Desktop/hightox_lowtox/LPK/ANN_4/")

Common_NC_HT_ANN4_all_tox <- read.table("Common_NC_ANN4_HT_LPK_new_tox", quote="\"", comment.char="")
Common_NC_LT_ANN4_all_tox <- read.table("Common_NC_ANN4_LT_LPK_new_tox", quote="\"", comment.char="")

Common_all_ANN4_HT <- altfreq(Common_NC_HT_ANN4_all_tox)
Common_all_ANN4_LT <- altfreq(Common_NC_LT_ANN4_all_tox)

#delta_HT_ANN4_all <- Common_all_ANN4_HT/Common_all_ANN4_LT
#delta_LT_ANN4_all <- Common_all_ANN4_LT/Common_all_ANN4_HT

delta_HT_ANN4_LPK <- Common_all_ANN4_HT/Common_all_ANN4_LT
delta_LT_ANN4_LPK <- Common_all_ANN4_LT/Common_all_ANN4_HT


index = which((delta_HT_ANN4_LPK != "Inf") & (delta_HT_ANN4_LPK !="0") & (!(is.na(delta_HT_ANN4_LPK))))

Common_NC_HT_ANN4_all_tox_2 <- Common_NC_HT_ANN4_all_tox[index,]
Common_NC_LT_ANN4_all_tox_2 <- Common_NC_LT_ANN4_all_tox[index,]

Common_all_ANN4_HT_clean <- Common_all_ANN4_HT[index]
Common_all_ANN4_LT_clean <- Common_all_ANN4_LT[index]

#delta_HT_ANN4_all_2 <- Common_all_ANN4_HT_clean/Common_all_ANN4_LT_clean
#delta_LT_ANN4_all_2 <- Common_all_ANN4_LT_clean/Common_all_ANN4_HT_clean

delta_HT_ANN4_LPK_2 <- Common_all_ANN4_HT_clean/Common_all_ANN4_LT_clean
delta_LT_ANN4_LPK_2 <- Common_all_ANN4_LT_clean/Common_all_ANN4_HT_clean


dim(Common_NC_HT_ANN4_all_tox[which(delta_HT_ANN4_LPK == "Inf"),]) ### number in High toxicity group
dim(Common_NC_HT_ANN4_all_tox[which(delta_HT_ANN4_LPK == 0),]) ### number in low toxicity group

###############################################################################################
## Computing scores for the individual phenotypes

###############################################################################################
## ALL

#score_4_HT <- thres(delta_HT_ANN4_all_2)
#score_4_LT <- thres(delta_LT_ANN4_all_2)

###############################################################################################
## LPK
score_4_LPK_HT <- thres(delta_HT_ANN4_LPK_2)
score_4_LPK_LT <- thres(delta_LT_ANN4_LPK_2)

###############################################################################################
## LPK

# test4_LPK <- (delta_ANN3_LPK_4)/max(delta_ANN3_LPK_4, na.rm = TRUE)
# 
# sort_test4_LPK <- sort(test4_LPK,decreasing = TRUE)
# 
# score_4_LPK <- thres(sort_test4_LPK)

###############################################################################################
## LPK

# test4_LPK <- (delta_ANN3_LPK_4)/max(delta_ANN3_LPK_4, na.rm = TRUE)
# 
# sort_test4_LPK <- sort(test4_LPK,decreasing = TRUE)
# 
# score_4_LPK <- thres(sort_test4_LPK)


###############################################################################################
## Visualization stuffs (optional at this point)

###############################################################################################

par(mar=c(7,7,7,2)+0.1)
plot(Common_all_ANN4_HT_clean, delta_ANN4_LT_2, pch = 20, col ="darkred", 
     xlab="Common toxicity alternate frequency in Low toxicity LPK group", ylab="Delta score",
     main ="Priorotized common non coding variants with LPK toxicity", 
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(delta_ANN4_LT_2, pch =20, col="red", 
     xlab="Common variants with noncoding marks", ylab="Delta score", 
     main ="Priorized common non variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

par(mar=c(7,7,7,2)+0.1)
plot(unique(delta_ANN4_LT_2), pch =20, col="green4",
     xlab="Common variants with noncoding marks", ylab="Unique Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)

plot(sort(), pch =20, col="lightseagreen",
     xlab="Prioritized variants with marks", ylab="Sorted Delta score", 
     main ="Priorized common non coding variant Delta score",
     cex.lab =1.5, cex.axis =1.5, cex.main=1.5)


###############################################################################################
###############################################################################################
## Combinining in all 

# score_HT <- as.data.frame(cbind(score_1_HT,score_2_HT,score_3_HT,score_4_HT))
# 
# sc1_HT <- score_HT[,1]/length(delta_HT_All_2)
# sc2_HT <- score_HT[,2]/length(delta_HT_ANN2_All_2)
# sc3_HT <- score_HT[,3]/length(delta_HT_ANN3_all_2)
# sc4_HT <- score_HT[,4]/length(delta_HT_ANN4_all_2)
# 
# enrichment_score_HT< - as.data.frame(cbind(sc1_HT,sc2_HT,sc3_HT,sc4_HT))
# 
# 
# score_LT <- as.data.frame(cbind(score_1_LT,score_2_LT,score_3_LT,score_4_LT))
# 
# sc1_LT <- score_LT[,1]/length(delta_LT_All_2)
# sc2_LT <- score_LT[,2]/length(delta_LT_ANN2_All_2)
# sc3_LT <- score_LT[,3]/length(delta_LT_ANN3_all_2)
# sc4_LT <- score_LT[,4]/length(delta_LT_ANN4_all_2)
# 
# enrichment_score_LT <- as.data.frame(cbind(sc1_LT,sc2_LT,sc3_LT,sc4_LT))


###############################################################################################

score_HT_LPK <- as.data.frame(cbind(score_1_LPK_HT,score_2_LPK_HT,score_3_LPK_HT,score_4_LPK_HT))

sc1_HT_LPK <- score_HT_LPK[,1]/length(delta_HT_LPK_2)
sc2_HT_LPK <- score_HT_LPK[,2]/length(delta_HT_ANN2_LPK_2)
sc3_HT_LPK <- score_HT_LPK[,3]/length(delta_HT_ANN3_LPK_2)
sc4_HT_LPK <- score_HT_LPK[,4]/length(delta_HT_ANN4_LPK_2)

enrichment_score_LPK_HT <- as.data.frame(cbind(sc1_HT_LPK,sc2_HT_LPK,sc3_HT_LPK,sc4_HT_LPK))


score_LT_LPK <- as.data.frame(cbind(score_1_LPK_LT,score_2_LPK_LT,score_3_LPK_LT,score_4_LPK_LT))

sc1_LT_LPK <- score_LT_LPK[,1]/length(delta_LT_LPK_2)
sc2_LT_LPK <- score_LT_LPK[,2]/length(delta_LT_ANN2_LPK_2)
sc3_LT_LPK <- score_LT_LPK[,3]/length(delta_LT_ANN3_LPK_2)
sc4_LT_LPK <- score_LT_LPK[,4]/length(delta_LT_ANN4_LPK_2)

enrichment_score_LPK_LT <- as.data.frame(cbind(sc1_LT_LPK,sc2_LT_LPK,sc3_LT_LPK,sc4_LT_LPK))


###############################################################################################


# score_LPK <- as.data.frame(cbind(score_1_LPK,score_2_LPK,score_3_LPK,score_4_LPK))
# 
# sc1 <- score_LPK[,1]/length(sort_test1_LPK)
# sc2 <- score_LPK[,2]/length(sort_test2_LPK)
# sc3 <- score_LPK[,3]/length(sort_test3_LPK)
# sc4 <- score_LPK[,4]/length(sort_test4_LPK)
# 
# enrichment_score_LPK<- as.data.frame(cbind(sc1,sc2,sc3,sc4))


# score_LPK <- as.data.frame(cbind(score_1_LPK,score_2_LPK,score_3_LPK,score_4_LPK))
# 
# sc1 <- score_LPK[,1]/length(sort_test1_LPK)
# sc2 <- score_LPK[,2]/length(sort_test2_LPK)
# sc3 <- score_LPK[,3]/length(sort_test3_LPK)
# sc4 <- score_LPK[,4]/length(sort_test4_LPK)

# enrichment_score_LPK<- as.data.frame(cbind(sc1,sc2,sc3,sc4))

###############################################################################################
## HT -all

par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_HT$sc4_HT, col ="red", pch =20, type ="o", axes=FALSE,
     ylim=c(0,0.04), cex.axis = 2.0,
     main ="Enrichment status in common variants in High toxicity group", xlab="delta threshold",
     ylab="Enrichment status",cex.main=2.0, cex.lab=2.0)
lines(enrichment_score_HT$sc3_HT, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_HT$sc2_HT, col ="blue", pch =20, type ="o")
lines(enrichment_score_HT$sc1_HT, col ="bisque4", pch =20, type ="o")
lines(sc0_HT, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex.lab=2,cex.axis=2.0)
axis(2, ylim=c(0,0.04),cex.lab=2,cex.axis=2.0)
#box()

legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=2)


## LT -all

par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_LT$sc4_LT, col ="red", pch =20, type ="o", axes=FALSE,
     ylim=c(0,0.05),
     main ="Enrichment status in common variants in low toxiocity group", xlab="delta threshold", 
     ylab="Enrichment status",cex.main=2, cex.lab=2)
lines(enrichment_score_LT$sc3_LT, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_LT$sc2_LT, col ="blue", pch =20, type ="o")
lines(enrichment_score_LT$sc1_LT, col ="bisque4", pch =20, type ="o")
lines(sc0_LT, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex=1.5)
axis(2, ylim=c(0,0.04),cex=1.5)
box()

legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=1.5)

###############################################################################################
## HT -LPK

par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_LPK_HT$sc4_HT_LPK, col ="red", pch =20, type ="o", axes=FALSE,
     ylim=c(0,0.04),
     main ="Enrichment status in common variants in High toxicity group \n LPK phe", xlab="delta threshold", ylab="Enrichment status",
     cex.main=2, cex.lab=2)
lines(enrichment_score_LPK_HT$sc3_HT, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_LPK_HT$sc2_HT, col ="blue", pch =20, type ="o")
lines(enrichment_score_LPK_HT$sc1_HT, col ="bisque4", pch =20, type ="o")
lines(sc0_LPK_HT, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex.lab=2,cex.axis=2.0)
axis(2, ylim=c(0,0.04),cex.lab=2,cex.axis=2.0)
#box()
legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=2.0)


## LT -LPK

par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_LPK_LT$sc4_LT_LPK, col ="red", pch =20, type ="o", axes=FALSE,
     ylim=c(0,0.05),
     main ="Enrichment status in common variants in low toxicity group in LPK", xlab="delta threshold", ylab="Enrichment status",cex.main=1.5, cex.lab=1.5)
lines(enrichment_score_LPK_LT$sc3_LT_LPK, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_LPK_LT$sc2_LT_LPK, col ="blue", pch =20, type ="o")
lines(enrichment_score_LPK_LT$sc1_LT_LPK, col ="bisque4", pch =20, type ="o")
lines(sc0_LPK_LT, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex=1.5)
axis(2, ylim=c(0,0.04),cex=1.5)
box()

legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=1.5)


par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_LPK$sc4, col ="red", pch =20, type ="o", 
     axes=FALSE,main ="Enrichment status in common variants in LPK toxicity", xlab="delta threshold", ylab="Enrichment status",
     cex.main=1.5, cex.lab=1.5)
lines(enrichment_score_LPK$sc3, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_LPK$sc2, col ="blue", pch =20, type ="o")
lines(enrichment_score_LPK$sc1, col ="bisque4", pch =20, type ="o")
lines(sc0_LPK, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex=1.5)
axis(2,cex=1.5)
box()

legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=1.5)


par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_LPK$sc4, col ="red", pch =20, type ="o", 
     axes=FALSE,main ="Enrichment status in common variants in LPK toxicity", xlab="delta threshold", ylab="Enrichment status",
     cex.main=1.5, cex.lab=1.5)
lines(enrichment_score_LPK$sc3, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_LPK$sc2, col ="blue", pch =20, type ="o")
lines(enrichment_score_LPK$sc1, col ="bisque4", pch =20, type ="o")
lines(sc0_LPK, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex=1.5)
axis(2,cex=1.5)
box()

legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=1.5)

par(mar=c(5,5,5,2)+0.1)
plot(enrichment_score_LPK$sc4, col ="red", pch =20, type ="o", 
     axes=FALSE,main ="Enrichment status in common variants in LPK toxicity", xlab="delta threshold", ylab="Enrichment status",
     cex.main=1.5, cex.lab=1.5)
lines(enrichment_score_LPK$sc3, col ="darkgreen", pch =20, type ="o")
lines(enrichment_score_LPK$sc2, col ="blue", pch =20, type ="o")
lines(enrichment_score_LPK$sc1, col ="bisque4", pch =20, type ="o")
lines(sc0_LPK, col= "black", type="o" ,pch =20)
axis(1, at=1:10, lab=c("0.95", "0.90", "0.85", "0.80", "0.75", "0.70", "0.65", "0.5", "0.35", "0.25"),cex=1.5)
axis(2,cex=1.5)
box()

legend("topleft", c("no annotation(a)", "one annotation (b1)", "two annotation (b2)", "three annoation (b3)", "four annotation (b4)"), col =c("black", "bisque4", "blue", "darkgreen", "red"), 
       pch=c(19,19,19,19), box.lwd = 0,box.col = "white",bg = "white", lty =1,cex=1.5)

save.image("~/Desktop/hightox_lowtox/15_Feb_2017.RData")
