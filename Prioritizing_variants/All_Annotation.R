###############################################################################################

## Function for getting alternnate and reference from the intermediate files
## All toxicity : Annotation level = 0

###############################################################################################
setwd("~/Desktop/hightox_lowtox/all/")

Common_ALL_HT_0 <- read.table(pipe("cut -f 1,2,14,15 Common_variant_HT_ALL"))
Common_ALL_LT_0 <- read.table(pipe("cut -f 1,2,14,15 Common_variant_LT_ALL"))

Common_ALL_HT_0$prop <- Common_ALL_HT_0$V4/Common_ALL_HT_0$V3
Common_ALL_LT_0$prop <- Common_ALL_LT_0$V4/Common_ALL_LT_0$V3

delta_HT_all_0<- Common_ALL_HT_0$prop/Common_ALL_LT_0$prop
delta_LT_all_0<- Common_ALL_LT_0$prop/Common_ALL_HT_0$prop

index = which((delta_HT_all_0 != "Inf") & (delta_HT_all_0  !="0") & (!(is.na(delta_HT_all_0))))
index = which((delta_LT_all_0 != "Inf") & (delta_LT_all_0  !="0") & (!(is.na(delta_LT_all_0))))

Common_ALL_HT_0_2 <- Common_ALL_HT_0[index,]
Common_ALL_LT_0_2 <- Common_ALL_LT_0[index,]

delta_HT_all_0_2 <- Common_ALL_HT_0_2$prop/Common_ALL_LT_0_2$prop
delta_LT_all_0_2 <- Common_ALL_LT_0_2$prop/Common_ALL_HT_0_2$prop

score_ALL_HT <- thres(delta_HT_all_0_2)
score_ALL_LT <- thres(delta_LT_all_0_2)


score_ALL

sc0_HT <- score_ALL_HT/(length(Common_ALL_HT_0_2$V1))
sc0_LT  <- score_ALL_LT/(length(Common_ALL_LT_0_2$V1))

###########################################################################################################
setwd("~/Desktop/hightox_lowtox/LPK/no_ANN/")

Common_LPK_HT_0 <- read.table(pipe("cut -f 1,2,14,15 Common_variant_HT_LPK_new"))
head(Common_LPK_HT_0)
Common_LPK_LT_0 <- read.table(pipe("cut -f 1,2,14,15 Common_variant_LT_LPK_new"))
head(Common_LPK_LT_0)


Common_LPK_HT_0$prop <- Common_LPK_HT_0$V4/Common_LPK_HT_0$V3
Common_LPK_LT_0$prop <- Common_LPK_LT_0$V4/Common_LPK_LT_0$V3


delta_HT_LPK_0<- Common_LPK_HT_0$prop/Common_LPK_LT_0$prop
delta_LT_LPK_0<- Common_LPK_LT_0$prop/Common_LPK_HT_0$prop

index = which((delta_HT_LPK_0 != "Inf") & (delta_HT_LPK_0  !="0") & (!(is.na(delta_HT_LPK_0))))
index = which((delta_HT_LPK_0 != "Inf") & (delta_HT_LPK_0  !="0") & (!(is.na(delta_HT_LPK_0))))

Common_LPK_HT_0_2 <- Common_LPK_HT_0[index,]
Common_LPK_LT_0_2 <- Common_LPK_LT_0[index,]


delta_HT_LPK_0_2 <- Common_LPK_HT_0_2$prop/Common_LPK_LT_0_2$prop
delta_LT_LPK_0_2 <- Common_LPK_LT_0_2$prop/Common_LPK_HT_0_2$prop

score_LPK_HT <- thres(delta_HT_LPK_0_2)
score_LPK_LT <- thres(delta_LT_LPK_0_2)


#score_ALL_LPK

sc0_LPK_HT <- score_LPK_HT/(length(Common_LPK_HT_0_2$V1))
sc0_LPK_LT  <- score_LPK_LT/(length(Common_LPK_LT_0_2$V1))


######################################################################################
Common_LPK_HT <- read.table(pipe("cut -f 1,2,14,15 Common_variant_HT_LPK"))
Common_LPK_LT <- read.table(pipe("cut -f 1,2,14,15 Common_variant_LT_LPK"))
Common_LPK_HT$prop <- Common_LPK_HT$V4/Common_LPK_HT$V3
Common_LPK_LT$prop <- Common_LPK_LT$V4/Common_LPK_LT$V3


Delta_all_LPK <- Common_LPK_HT$prop/Common_LPK_LT$prop
index = which((Delta_all_LPK != "Inf") & (Delta_all_LPK !="0") & (!(is.na(Delta_all_LPK))))

Common_LPK_HT_2 <- Common_LPK_HT[index,]
Common_LPK_LT_2 <- Common_LPK_LT[index,]


Delta_LPK_2 <- Common_LPK_HT_2$prop/Common_LPK_LT_2$prop


length(sort(Delta_LPK_2, decreasing =TRUE))

test1_All_LPK <- (Delta_LPK_2)/max(Delta_LPK_2, na.rm = TRUE)

sort_test1_All_LPK <- sort(test1_All_LPK,decreasing = TRUE)

score_ALL_LPK <- thres(sort_test1_All_LPK)


score_ALL_LPK

sc0_LPK <- score_ALL_LPK/(length(Common_LPK_HT_2$V1))
sc0_LPK



######################################################################################
Common_LPK_HT <- read.table(pipe("cut -f 1,2,14,15 Common_variant_HT_LPK"))
Common_LPK_LT <- read.table(pipe("cut -f 1,2,14,15 Common_variant_LT_LPK"))
Common_LPK_HT$prop <- Common_LPK_HT$V4/Common_LPK_HT$V3
Common_LPK_LT$prop <- Common_LPK_LT$V4/Common_LPK_LT$V3


Delta_all_LPK <- Common_LPK_HT$prop/Common_LPK_LT$prop
index = which((Delta_all_LPK != "Inf") & (Delta_all_LPK !="0") & (!(is.na(Delta_all_LPK))))

Common_LPK_HT_2 <- Common_LPK_HT[index,]
Common_LPK_LT_2 <- Common_LPK_LT[index,]


Delta_LPK_2 <- Common_LPK_HT_2$prop/Common_LPK_LT_2$prop


length(sort(Delta_LPK_2, decreasing =TRUE))

test1_All_LPK <- (Delta_LPK_2)/max(Delta_LPK_2, na.rm = TRUE)

sort_test1_All_LPK <- sort(test1_All_LPK,decreasing = TRUE)

score_ALL_LPK <- thres(sort_test1_All_LPK)


score_ALL_LPK

sc0_LPK <- score_ALL_LPK/(length(Common_LPK_HT_2$V1))
sc0_LPK
