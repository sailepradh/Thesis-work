## Gene-Based Association in the Thrombopenia using Quantitative
## approach 

## Taking into account the log normalized values

File.Bed <-"Common_rare.bed"
File.Bim <- "Common_rare.bim"
File.Fam <- "Common_rare.fam"
File.SetID<-"../Gene_list_plink_files/Exon_6bp_sai_list.txt"
File.SSD<- "Common_rare.SSD"
File.Info<- "Common_rare.info"

Generate_SSD_SetID(File.Bed,File.Bim,
                   File.Fam,File.SetID,
                   File.SSD,File.Info)

SSD.INFO<-Open_SSD(File.SSD, File.Info)

Open_SSD(File.SSD,File.Info)
obj<-SKAT_Null_Model(phenotype$TPK_Nadir_log~ 1, out_type="C")


##SKAT 
SKAT_Log_Unadj_Thr<-SKAT.SSD.All(SSD.INFO, obj)
SKAT_Log_Unadj_Thr$results[order(SKAT_Log_Unadj_Thr$results$P.value),] [1:15,]
qq(SKAT_Log_Unadj_Thr$results$P.value,
   main ="Quantitative SKAT result - log normalized Thr")

########################################################################
SKAT_Log_adj_Thr<-SKAT.SSD.All(SSD.INFO, obj,weights.beta=c(1,1))
SKAT_Log_adj_Thr$results[order(SKAT_Log_adj_Thr$results$P.value),] [1:15,]
SKAT_Log_adj_Thr$results$p_adjust_BH<-p.adjust((SKAT_Log_adj_Thr$results$P.value),
                                               method ="BH")
SKAT_Log_adj_Thr$results$p_adjust_Bonf<-p.adjust((SKAT_Log_adj_Thr$results$P.value),
                                                 method ="bonferroni")
write.table(SKAT_Log_adj_Thr$results[order(SKAT_Log_adj_Thr$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKAT_Log_adj_top15.txt",
            sep="\t", quote = F, row.names = F)
pdf("SKAT_log_Thr.pdf", width=4, height=4)
qq(SKAT_Log_adj_Thr$results$P.value, 
   main ="Quantitative SKAT Log normalized Thr", 
    cex.lab =0.70, cex.main= 0.70)
dev.off()

##########################################################
pdf("SKAT_results_Thr_log_normalized_Quantitative.pdf")
par(mfrow=c(1,1))
qq(SKAT_Log_Unadj_Thr$results$P.value,
   main ="Quantitative SKAT Log normalized Thr", cex.lab =0.50, cex.main= 0.50)
qq(SKAT_Log_adj_Thr$results$P.value, 
   main ="Quantitative (weights adjusted) SKAT Log normalized Thr",
   cex.lab =0.50, cex.main= 0.50)
dev.off()

###############################################################################
###########################################################################
################SKAT Test for ENQT Normalized data

obj<-SKAT_Null_Model(phenotype$ENQT_TPK ~ 1, out_type="C")

##SKAT 
SKAT_ENQT_Unadj_Thr<-SKAT.SSD.All(SSD.INFO, obj)
SKAT_ENQT_Unadj_Thr$results[order(SKAT_ENQT_Unadj_Thr$results$P.value),] [1:15,]
qq(SKAT_ENQT_Unadj_Thr$results$P.value,
   main ="Quantitative SKAT result - ENQT normalized Thr")

###########################################################################
SKAT_ENQT_adj_Thr<-SKAT.SSD.All(SSD.INFO, obj,weights.beta=c(1,1))
SKAT_ENQT_adj_Thr$results[order(SKAT_ENQT_adj_Thr$results$P.value),] [1:15,]

SKAT_ENQT_adj_Thr$results$p_adjust_BH<-p.adjust((SKAT_ENQT_adj_Thr$results$P.value),
                                               method ="BH")
SKAT_ENQT_adj_Thr$results$p_adjust_Bonf<-p.adjust((SKAT_ENQT_adj_Thr$results$P.value),
                                                 method ="bonferroni")

write.table(SKAT_ENQT_adj_Thr$results[order(SKAT_ENQT_adj_Thr$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKAT_ENQT_adj_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKAT_ENQT_Thr.pdf", width=4, height=4)
qq(SKAT_ENQT_adj_Thr$results$P.value, 
   main ="Quantitative SKAT ENQT Thr", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

#####################################################################################
pdf("SKAT_results_Thr_ENQT_Quantitative.pdf")
qq(SKAT_ENQT_Unadj_Thr$results$P.value,
   main ="Quantitative SKAT result - ENQT normalized Thr")
qq(SKAT_ENQT_adj_Thr$results$P.value, 
   main ="Quantitative weights adjusted SKAT result - ENQT normalized Thr")
dev.off()
####################################################################################
#############Drawing the venn diagram of the above results
TPK_ENQT<-as.character((SKAT_ENQT_adj_Thr$results[(which(SKAT_ENQT_adj_Thr$results$P.value <= 1.00e-03)),])$SetID)
                 
TPK_Log<-as.character((SKAT_Log_adj_Thr$results[(which(SKAT_Log_adj_Thr$results$P.value <= 1.00e-03)),])$SetID )


v <- venn.diagram(list(TPK_ENQT=TPK_ENQT, TPK_Log=TPK_Log),
                  lty = rep("blank", 2), fill = c("light blue", "pink"), 
                  alpha = rep(0.5, 2),cat.pos = c(0,0), cat.dist = rep(0.025, 2)
                  ,filename=NULL)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(setdiff(TPK_Log,TPK_ENQT), collapse="\n") 
v[[6]]$label <- paste(setdiff(TPK_ENQT, TPK_Log)  , collapse="\n")
v[[7]]$label <- paste(intersect(TPK_ENQT, TPK_Log), collapse="\n")  

pdf("SKAT_TPK_Genebased.pdf", width=9, height=9)
grid.newpage()
grid.draw(v)
dev.off()
##############################################################################
## Burden test
 
Burden_Log_Unadj_Thr<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1)
Burden_Log_Unadj_Thr$results[order(Burden_Log_Unadj_Thr$results$P.value),] [1:15,]
qq(Burden_Log_Unadj_Thr$results$P.value, 
   main = "Burden result Log Normalized Thr")
#############################################################################
Burden_Log_adj_Thr<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1,weights.beta=c(1,1))
Burden_Log_adj_Thr$results[order(Burden_Log_adj_Thr$results$P.value),] [1:15,]
Burden_Log_adj_Thr$results$p_adjust_BH<-p.adjust((Burden_Log_adj_Thr$results$P.value),
                                               method ="BH")
Burden_Log_adj_Thr$results$p_adjust_Bonf<-p.adjust((Burden_Log_adj_Thr$results$P.value),
                                                 method ="bonferroni")
write.table(Burden_Log_adj_Thr$results[order(Burden_Log_adj_Thr$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/Burden_Log_adj_top15.txt",
            sep="\t", quote = F, row.names = F)
pdf("Burden_log_Thr.pdf", width=4, height=4)
qq(Burden_Log_adj_Thr$results$P.value, 
   main ="Quantitative Burden-test Log normalized Thr", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()
#######################################################

pdf("Burden_results_Thr_Quantitative_Log.pdf")
qq(Burden_Log_Unadj_Thr$results$P.value, 
   main = "Burden result Log Normalized Thr")
qq(Burden_Log_adj_Thr$results$P.value, 
   main ="Burden result Weight Adjusted Log Normalized Thr")
dev.off()


###############################################################################
########################################################
## ENQT TPK phenotype and log normaized data
## Burden test

Burden_ENQT_Unadj_Thr<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1)
Burden_ENQT_Unadj_Thr$results[order(Burden_ENQT_Unadj_Thr$results$P.value),] [1:15,]
qq(Burden_ENQT_Unadj_Thr$results$P.value, 
   main = "Burden result ENQT Thr")
#####################################################
Burden_ENQT_adj_Thr<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1,weights.beta=c(1,1))
Burden_ENQT_adj_Thr$results[order(Burden_ENQT_adj_Thr$results$P.value),] [1:15,]
Burden_ENQT_adj_Thr$results$p_adjust_BH<-p.adjust((Burden_ENQT_adj_Thr$results$P.value),
                                                 method ="BH")
Burden_ENQT_adj_Thr$results$p_adjust_Bonf<-p.adjust((Burden_ENQT_adj_Thr$results$P.value),
                                                   method ="bonferroni")
write.table(Burden_ENQT_adj_Thr$results[order(Burden_ENQT_adj_Thr$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/Burden_ENQT_adj_top15.txt",
            sep="\t", quote = F, row.names = F)
pdf("Burden_ENQT_Thr.pdf", width=4, height=4)
qq(Burden_Log_adj_Thr$results$P.value, 
   main ="Quantitative Burden-test ENQT normalized Thr", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

################################################################
TPK_ENQT_burd<-as.character((Burden_ENQT_Thr$results[(which(Burden_ENQT_adj_Thr$results$P.value <= 1.00e-03)),])$SetID)
TPK_Log_burd<-as.character((Burden_Log_adj_Thr$results[(which(Burden_Log_adj_Thr$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(TPK_ENQT_burd=TPK_ENQT_burd, TPK_Log_burd=TPK_Log_burd),
                  lty = rep("blank", 2), fill = c("light blue", "pink"), 
                  alpha = rep(0.5, 2),cat.pos = c(-10,10), 
                  cat.cex = 0.75, cex=1.0,
                  ,filename=NULL)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(setdiff(TPK_Log_burd,TPK_ENQT_burd), collapse="\n") 
v[[6]]$label <- paste(setdiff(TPK_ENQT_burd, TPK_Log_burd)  , collapse="\n")
v[[7]]$label <- paste(intersect(TPK_ENQT_burd, TPK_Log_burd), collapse="\n")  

pdf("Burden_TPK_Genebased.pdf", width=9, height=9)
grid.newpage()
grid.draw(v)
dev.off()

#####################################################
pdf("Burden_results_Thr_Quantitative_ENQT.pdf")
qq(Burden_ENQT_Unadj_Thr$results$P.value, 
   main = "Burden result ENQT Thr")
qq(Burden_ENQT_adj_Thr$results$P.value, 
   main ="Burden result Weight Adjusted ENQT Thr")
dev.off()

##############################################################################
##SKAT-O
SKATO_Log_Unadj_Thr<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
SKATO_Log_Unadj_Thr$results[order(SKATO_Log_Unadj_Thr$results$P.value),] [1:15,]
qq(SKATO_Log_Unadj_Thr$results$P.value,
   main ="SKATO Quantitative results weights(1,25)")

###############################################################################
######

SKATO_Log_adj_Thr<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj",weights.beta=c(1,1))
SKATO_Log_adj_Thr$results[order(SKATO_Log_adj_Thr$results$P.value),] [1:15,]
SKATO_Log_adj_Thr$results$p_adjust_BH<-p.adjust((SKATO_Log_adj_Thr$results$P.value),
                                                method ="BH")
SKATO_Log_adj_Thr$results$p_adjust_Bonf<-p.adjust((SKATO_Log_adj_Thr$results$P.value),
                                                  method ="bonferroni")

write.table(SKATO_Log_adj_Thr$results[order(SKATO_Log_adj_Thr$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKATO_Log_adj_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKATO_Thr_log.pdf", width=4, height=4)
qq(SKATO_Log_adj_Thr$results$P.value, 
   main ="Quantitative SKAT Log TPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()


#######################################
pdf("SKATO_results_Thr_Quantitative_log.pdf")
qq(SKATO_Log_Unadj_Thr$results$P.value,
   main ="SKATO Quantitative results weights(1,25)")
qq(SKATO_Log_adj_Thr$results$P.value, 
   main ="SKATO  Results Quantitative Equal weights results")
dev.off()
########################################################

## Testing for ENQT normalized value
##SKAT-O
SKATO_ENQT_Unadj_Thr<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
SKATO_ENQT_Unadj_Thr$results[order(SKATO_ENQT_Unadj_Thr$results$P.value),] [1:15,]
qq(SKATO_ENQT_Unadj_Thr$results$P.value,
   main ="SKATO ENQT THR Quantitative DATA UNADJUSTED")

SKATO_ENQT_adj_Thr<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj",weights.beta=c(1,1))
SKATO_ENQT_adj_Thr$results[order(SKATO_ENQT_adj_Thr$results$P.value),] [1:15,]
SKATO_ENQT_adj_Thr$results$p_adjust_BH<-p.adjust((SKATO_Log_adj_Thr$results$P.value),
                                                method ="BH")
SKATO_ENQT_adj_Thr$results$p_adjust_Bonf<-p.adjust((SKATO_Log_adj_Thr$results$P.value),
                                                  method ="bonferroni")

write.table(SKATO_ENQT_adj_Thr$results[order(SKATO_ENQT_adj_Thr$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKATO_Thr_adj_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKATO_Thr_ENQT.pdf", width=4, height=4)
qq(SKATO_ENQT_adj_Thr$results$P.value, 
   main ="Quantitative SKAT ENQT TPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

######################################################################
################################

TPK_ENQT_SKATO<-as.character((SKATO_ENQT_adj_Thr$results[(which(SKATO_ENQT_adj_Thr$results$P.value <= 1.00e-03)),])$SetID)
TPK_Log_SKATO<-as.character((SKATO_ENQT_adj_Thr$results[(which(SKATO_Log_adj_Thr$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(TPK_ENQT_SKATO=TPK_ENQT_SKATO, TPK_Log_SKATO=TPK_Log_SKATO),
                  lty = rep("blank", 2), fill = c("light blue", "pink"), 
                  alpha = rep(0.5, 2),cat.pos = c(-10,10), 
                  cat.cex = 0.75, cex=1.0,
                  ,filename=NULL)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(setdiff(TPK_Log_SKATO,TPK_ENQT_SKATO), collapse="\n") 
v[[6]]$label <- paste(setdiff(TPK_ENQT_SKATO, TPK_Log_SKATO)  , collapse="\n")
v[[7]]$label <- paste(intersect(TPK_ENQT_SKATO, TPK_Log_SKATO), collapse="\n")  

pdf("SKATO_TPK_Genebased.pdf", width=9, height=9)
grid.newpage()
grid.draw(v)
dev.off()

#############################################
pdf("SKATO_results_Thr_Quantitative_ENQT.pdf")
qq(SKATO_ENQT_Unadj_Thr$results$P.value,
   main ="SKATO ENQT THR Quantitative DATA UNADJUSTED")
qq(SKATO_ENQT_adj_Thr$results$P.value, 
   main ="SKATO ENQT THR Quantitative DATA ADJUSTED")
dev.off()


###########################################
#####Doing the similar analysis for Neutropenia

obj<-SKAT_Null_Model(phenotype$Neutrophiles_Nadir_log~ 1, out_type="C")


##SKAT 
SKAT_Log_Unadj_Neu<-SKAT.SSD.All(SSD.INFO, obj)
SKAT_Log_Unadj_Neu$results[order(SKAT_Log_Unadj_Neu$results$P.value),] [1:15,]
qq(SKAT_Log_Unadj_Neu$results$P.value,
   main ="Quantitative SKAT result - log normalized Neu")
################################################################
SKAT_Log_adj_Neu<-SKAT.SSD.All(SSD.INFO, obj,weights.beta=c(1,1))
SKAT_Log_adj_Neu$results[order(SKAT_Log_adj_Neu$results$P.value),] [1:15,]
SKAT_Log_adj_Neu$results$p_adjust_BH<-p.adjust((SKAT_Log_adj_Neu$results$P.value),
                                                method ="BH")
SKAT_Log_adj_Neu$results$p_adjust_Bonf<-p.adjust((SKAT_Log_adj_Neu$results$P.value),
                                                  method ="bonferroni")

write.table(SKAT_Log_adj_Neu$results[order(SKAT_Log_adj_Neu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKAT_Log_adj__Neu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKAT_Neu_log.pdf", width=4, height=4)
qq(SKAT_Log_adj_Neu$results$P.value, 
   main ="Quantitative SKAT Log NPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

##############################################################

pdf("SKAT_results_Neu_log_normalized_Quantitative.pdf")
qq(SKAT_Log_Unadj_Neu$results$P.value,
   main ="Quantitative SKAT result - log normalized Neu")
qq(SKAT_Log_adj_Neu$results$P.value, 
   main ="Quantitative weights adjusted SKAT result - log normalized Neu")
dev.off()
 ###################################################################
#########
## Testing for ENQT normalized value
obj<-SKAT_Null_Model(phenotype$ENQT_Neu ~ 1, out_type="C")

##SKAT 
SKAT_ENQT_Unadj_Neu<-SKAT.SSD.All(SSD.INFO, obj)
SKAT_ENQT_Unadj_Neu$results[order(SKAT_ENQT_Unadj_Neu$results$P.value),] [1:15,]
qq(SKAT_ENQT_Unadj_Neu$results$P.value,
   main ="Quantitative SKAT result - ENQT normalized Neu")
###################################################################
SKAT_ENQT_adj_Neu<-SKAT.SSD.All(SSD.INFO, obj,weights.beta=c(1,1))
SKAT_ENQT_adj_Neu$results[order(SKAT_ENQT_adj_Neu$results$P.value),] [1:15,]
SKAT_ENQT_adj_Neu$results$p_adjust_BH<-p.adjust((SKAT_ENQT_adj_Neu$results$P.value),
                                               method ="BH")
SKAT_ENQT_adj_Neu$results$p_adjust_Bonf<-p.adjust((SKAT_ENQT_adj_Neu$results$P.value),
                                                 method ="bonferroni")

write.table(SKAT_ENQT_adj_Neu$results[order(SKAT_ENQT_adj_Neu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKAT_adj_ENQT_Neu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKAT_Neu_ENQT.pdf", width=4, height=4)
qq(SKAT_ENQT_adj_Neu$results$P.value, 
   main ="Quantitative SKAT Log NPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

############################################################################
NPK_ENQT_SKAT<-as.character((SKAT_ENQT_adj_Neu$results[(which(SKAT_ENQT_adj_Neu$results$P.value <= 1.00e-03)),])$SetID)
NPK_Log_SKAT<-as.character((SKAT_Log_adj_Neu$results[(which(SKAT_Log_adj_Neu$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(NPK_Log_SKAT=NPK_Log_SKAT, NPK_ENQT_SKAT=NPK_ENQT_SKAT),
                  lty = rep("blank", 2), fill = c("light blue", "light green"), 
                  alpha = rep(0.5, 2),cat.pos = c(-10,10), 
                  cat.cex = 1.0, cex=0.75,
                  ,filename=NULL, scaled = FALSE)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(intersect(NPK_ENQT_SKAT, NPK_Log_SKAT), collapse="\n") 
v[[6]]$label <- paste(setdiff(NPK_Log_SKAT, NPK_ENQT_SKAT)   , collapse="\n")

pdf("SKAT_Neu_Genebased.pdf", width=9, height=9)
grid.newpage()
grid.draw(v)
dev.off()

#################################################################
pdf("SKAT_results_Neu_ENQT_Quantitative.pdf")
qq(SKAT_ENQT_Unadj_Neu$results$P.value,
   main ="Quantitative SKAT result - ENQT normalized Neu")
qq(SKAT_ENQT_adj_Neu$results$P.value, 
   main ="Quantitative weights adjusted SKAT result - ENQT normalized T")
dev.off()


##########################################################################
####################################################################
## Burden test

Burden_Log_Unadj_Neu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1)
Burden_Log_Unadj_Neu$results[order(Burden_Log_Unadj_Neu$results$P.value),] [1:15,]
qq(Burden_Log_Unadj_Neu$results$P.value, 
   main = "Burden result Log Normalized Neu")

########################################
Burden_Log_adj_Neu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1,weights.beta=c(1,1))
Burden_Log_adj_Neu$results[order(Burden_Log_adj_Neu$results$P.value),] [1:15,]
Burden_Log_adj_Neu$results$p_adjust_BH<-p.adjust((Burden_Log_adj_Neu$results$P.value),
                                                method ="BH")
Burden_Log_adj_Neu$results$p_adjust_Bonf<-p.adjust((Burden_Log_adj_Neu$results$P.value),
                                                  method ="bonferroni")

write.table(Burden_Log_adj_Neu$results[order(Burden_Log_adj_Neu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/Burden_adj_Log_Neu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("BURDEN_Neu_log.pdf", width=4, height=4)
qq(Burden_Log_adj_Neu$results$P.value, 
   main ="Quantitative Burden Log NPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()
###############################################################
pdf("Burden_results_Neu_Quantitative_Log.pdf")
qq(Burden_Log_Unadj_Neu$results$P.value, 
   main = "Burden result Log Normalized Neu")
qq(Burden_Log_adj_Neu$results$P.value, 
   main ="Burden result Weight Adjusted Log Normalized Thr")
dev.off()

##### ENQT transformed phenotype
## Burden test

Burden_ENQT_Unadj_Neu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1)
Burden_ENQT_Unadj_Neu$results[order(Burden_ENQT_Unadj_Neu$results$P.value),] [1:15,]
qq(Burden_ENQT_Unadj_Neu$results$P.value, 
   main = "Burden result ENQT Non-adjusted")
###########################################################################
Burden_ENQT_adj_Neu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1,weights.beta=c(1,1))
Burden_ENQT_adj_Neu$results[order(Burden_ENQT_adj_Neu$results$P.value),] [1:15,]
Burden_ENQT_adj_Neu$results$p_adjust_BH<-p.adjust((Burden_ENQT_adj_Neu$results$P.value),
                                                 method ="BH")
Burden_ENQT_adj_Neu$results$p_adjust_Bonf<-p.adjust((Burden_ENQT_adj_Neu$results$P.value),
                                                   method ="bonferroni")

write.table(Burden_ENQT_adj_Neu$results[order(Burden_ENQT_adj_Neu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/Burden_adj_ENQT_Neu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("Burden_Neu_ENQT.pdf", width=4, height=4)
qq(Burden_ENQT_adj_Neu$results$P.value, 
   main ="Quantitative Burden ENQT NPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

##############################################################

NPK_BURDEN_ENQT<-as.character((Burden_ENQT_adj_Neu$results[(which(Burden_ENQT_adj_Neu$results$P.value <= 1.00e-03)),])$SetID)
NPK_BURDEN_LOG<-as.character((Burden_Log_adj_Neu$results[(which(Burden_Log_adj_Neu$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(NPK_BURDEN_ENQT=NPK_BURDEN_ENQT, NPK_BURDEN_LOG=NPK_BURDEN_LOG),
                  lty = rep("blank", 2), fill = c("light blue", "light green"), 
                  alpha = rep(0.5, 2),cat.pos = c(-10,10), 
                  cat.cex = 1.0, cex=0.75,
                  ,filename=NULL, scaled = FALSE)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(intersect(NPK_BURDEN_ENQT, NPK_BURDEN_LOG), collapse="\n") 
v[[6]]$label <- paste(setdiff(NPK_BURDEN_LOG, NPK_BURDEN_ENQT), collapse="\n")

pdf("Burden_Neu_Genebased.pdf", width=9, height=9)
grid.newpage()
grid.draw(v)
dev.off()

##############
pdf("Burden_results_Neu_Quantitative_ENQT.pdf")
qq(Burden_ENQT_Unadj_Neu$results$P.value, 
   main = "Burden result ENQT Non-adjusted")
qq(Burden_ENQT_adj_Neu$results$P.value, 
   main ="Burden result Weight Adjusted ENQT Neu")
dev.off()

##################################################################


##SKAT-O
SKATO_Log_Unadj_Neu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
SKATO_Log_Unadj_Neu$results[order(SKATO_Log_Unadj_Neu$results$P.value),] [1:15,]
qq(SKATO_Log_Unadj_Neu$results$P.value,
   main ="SKATO Quantitative results weights(1,25)")


SKATO_Log_adj_Neu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj",weights.beta=c(1,1))
SKATO_Log_adj_Neu$results[order(SKATO_Log_adj_Neu$results$P.value),] [1:15,]

SKATO_Log_adj_Neu$results$p_adjust_BH<-p.adjust((SKATO_Log_adj_Neu$results$P.value),
                                                  method ="BH")
SKATO_Log_adj_Neu$results$p_adjust_Bonf<-p.adjust((SKATO_Log_adj_Neu$results$P.value),
                                                    method ="bonferroni")

write.table(SKATO_Log_adj_Neu$results[order(SKATO_Log_adj_Neu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKATO_adj_LOG_Neu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKATO_Neu_Log.pdf", width=4, height=4)
qq(SKATO_Log_adj_Neu$results$P.value, 
   main ="Quantitative SKATO Log NPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

########################################
###############################################

pdf("SKATO_results_Neu_Quantitative_log.pdf")
qq(SKATO_Log_Unadj_Neu$results$P.value,
   main ="SKATO Quantitative results weights (1,25) NEU")
qq(SKATO_Log_adj_Neu$results$P.value, 
   main ="SKATO  Results Quantitative weights  Neu results")
dev.off()

#####################################################
### Neutropenia ENQT
##SKAT-O
SKATO_ENQT_Unadj_Neu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
SKATO_ENQT_Unadj_Neu$results[order(SKATO_ENQT_Unadj_Neu$results$P.value),] [1:15,]
qq(SKATO_ENQT_Unadj_Neu$results$P.value,
   main ="SKATO ENQT Neu Quantitative DATA UNADJUSTED")

SKATO_ENQT_adj_Neu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj",weights.beta=c(1,1))
SKATO_ENQT_adj_Neu$results[order(SKATO_ENQT_adj_Neu$results$P.value),] [1:15,]

SKATO_ENQT_adj_Neu$results$p_adjust_BH<-p.adjust((SKATO_ENQT_adj_Neu$results$P.value),
                                                method ="BH")
SKATO_ENQT_adj_Neu$results$p_adjust_Bonf<-p.adjust((SKATO_ENQT_adj_Neu$results$P.value),
                                                  method ="bonferroni")

write.table(SKATO_ENQT_adj_Neu$results[order(SKATO_ENQT_adj_Neu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKATO_adj_ENQT_Neu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKATO_Neu_ENQT.pdf", width=4, height=4)
qq(SKATO_ENQT_adj_Neu$results$P.value, 
   main ="Quantitative SKATO ENQT NPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

#######################################################
### Venn diagram to represent the above results
NPK_SKATO_ENQT<-as.character((SKATO_ENQT_adj_Neu$results[(which(SKATO_ENQT_adj_Neu$results$P.value <= 1.00e-03)),])$SetID)
NPK_SKATO_LOG<-as.character((SKATO_Log_adj_Neu$results[(which(SKATO_Log_adj_Neu$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(NPK_SKATO_ENQT=NPK_SKATO_ENQT, NPK_SKATO_LOG=NPK_SKATO_LOG),
                  lty = rep("blank", 2), fill = c("light blue", "light green"), 
                  alpha = rep(0.5, 2),cat.pos = c(-10,10), 
                  cat.cex = 1.0, cex=0.75,
                  ,filename=NULL, scaled = FALSE)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(intersect(NPK_SKATO_LOG, NPK_SKATO_ENQT), collapse="\n") 
v[[6]]$label <- paste(setdiff(NPK_SKATO_LOG, NPK_SKATO_ENQT), collapse="\n")

pdf("SKATO_Neu_Genebased.pdf", width=9, height=9)
grid.newpage()
grid.draw(v)
dev.off()

pdf("SKATO_results_Neu_Quantitative_ENQT.pdf")
qq(SKATO_ENQT_Unadj_Neu$results$P.value,
   main ="SKATO ENQT Neu Quantitative DATA UNADJUSTED")
qq(SKATO_ENQT_adj_Neu$results$P.value, 
   main ="SKATO ENQT NEU Quantitative DATA ADJUSTED")
dev.off()


#Associating the ENQT normalized values with the leucpoenia 
## Considering the qualitative values are similar to one normalixed 

## Testing for ENQT normalized value
obj<-SKAT_Null_Model(phenotype$ENQT_Lpk ~ 1, out_type="C")

##SKAT 
SKAT_ENQT_Unadj_Leu<-SKAT.SSD.All(SSD.INFO, obj)
SKAT_ENQT_Unadj_Leu$results[order(SKAT_ENQT_Unadj_Leu$results$P.value),] [1:15,]
qq(SKAT_ENQT_Unadj_Leu$results$P.value,
   main ="Quantitative SKAT result - ENQT normalized Leu")

SKAT_ENQT_adj_Leu<-SKAT.SSD.All(SSD.INFO, obj,weights.beta=c(1,1))
SKAT_ENQT_adj_Leu$results[order(SKAT_ENQT_adj_Leu$results$P.value),] [1:15,]
SKAT_ENQT_adj_Leu$results$p_adjust_BH<-p.adjust((SKAT_ENQT_adj_Leu$results$P.value),
                                               method ="BH")
SKAT_ENQT_adj_Leu$results$p_adjust_Bonf<-p.adjust((SKAT_ENQT_adj_Leu$results$P.value),
                                                 method ="bonferroni")

write.table(SKAT_ENQT_adj_Leu$results[order(SKAT_ENQT_adj_Leu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKAT_adj_ENQT_Leu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKAT_Leu_ENQT.pdf", width=4, height=4)
qq(SKAT_ENQT_adj_Leu$results$P.value, 
   main ="Quantitative SKAT ENQT LPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

################################################################
qq(SKAT_ENQT_adj_Leu$results$P.value, 
   main ="Quantitative weights adjusted SKAT result - ENQT normalized Leu")
########################################################
pdf("SKAT_results_Neu_ENQT_Quantitative.pdf")
qq(SKAT_ENQT_Unadj_Leu$results$P.value,
   main ="Quantitative SKAT result - ENQT normalized Leu")
qq(SKAT_ENQT_adj_Leu$results$P.value, 
   main ="Quantitative adjusted SKAT result - ENQT normalized Leu")
dev.off()


## Burden test

Burden_ENQT_Unadj_Leu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1)
Burden_ENQT_Unadj_Leu$results[order(Burden_ENQT_Unadj_Leu$results$P.value),] [1:15,]
qq(Burden_ENQT_Unadj_Leu$results$P.value, 
   main = "Burden result ENQT Non-adjusted")

Burden_ENQT_adj_Leu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1,weights.beta=c(1,1))
Burden_ENQT_adj_Leu$results[order(Burden_ENQT_adj_Leu$results$P.value),] [1:15,]
Burden_ENQT_adj_Leu$results$p_adjust_BH<-p.adjust((Burden_ENQT_adj_Leu$results$P.value),
                                                method ="BH")
Burden_ENQT_adj_Leu$results$p_adjust_Bonf<-p.adjust((Burden_ENQT_adj_Leu$results$P.value),
                                                  method ="bonferroni")

write.table(Burden_ENQT_adj_Leu$results[order(Burden_ENQT_adj_Leu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/Burden_adj_ENQT_Leu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("Burden_Leu_ENQT.pdf", width=4, height=4)
qq(Burden_ENQT_adj_Leu$results$P.value, 
   main ="Quantitative Burden ENQT LPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

####################################################################################
qq(Burden_ENQT_adj_Leu$results$P.value, 
   main ="Burden result Weight Adjusted ENQT Neu")

pdf("Burden_results_Leu_Quantitative_ENQT.pdf")
qq(Burden_ENQT_Unadj_Leu$results$P.value, 
   main = "Burden result ENQT Non-adjusted")
qq(Burden_ENQT_adj_Leu$results$P.value, 
   main ="Burden result Weight Adjusted ENQT Neu")
dev.off()

##SKAT-O
SKATO_ENQT_Unadj_Leu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
SKATO_ENQT_Unadj_Leu$results[order(SKATO_ENQT_Unadj_Leu$results$P.value),] [1:15,]
qq(SKATO_ENQT_Unadj_Leu$results$P.value,
   main ="SKATO ENQT Leu Quantitative DATA UNADJUSTED")

SKATO_ENQT_adj_Leu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj",weights.beta=c(1,1))
SKATO_ENQT_adj_Leu$results[order(SKATO_ENQT_adj_Leu$results$P.value),] [1:15,]
SKATO_ENQT_adj_Leu$results$p_adjust_BH<-p.adjust((SKATO_ENQT_adj_Leu$results$P.value),
                                                  method ="BH")
SKATO_ENQT_adj_Leu$results$p_adjust_Bonf<-p.adjust((SKATO_ENQT_adj_Leu$results$P.value),
                                                    method ="bonferroni")

write.table(SKATO_ENQT_adj_Leu$results[order(SKATO_ENQT_adj_Leu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKATO_adj_ENQT_Leu_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKATO_Leu_ENQT.pdf", width=4, height=4)
qq(SKATO_ENQT_adj_Leu$results$P.value, 
   main ="Quantitative SKATO ENQT LPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

############################################################################>33

qq(SKATO_ENQT_adj_Leu$results$P.value, 
   main ="SKATO ENQT Quantitative DATA ADJUSTED")

pdf("SKATO_results_Leu_Quantitative_ENQT.pdf")
qq(SKATO_ENQT_Unadj_Leu$results$P.value,
   main ="SKATO ENQT Leu Quantitative DATA UNADJUSTED")
qq(SKATO_ENQT_adj_Leu$results$P.value, 
   main ="SKATO ENQT Quantitative DATA ADJUSTED")
dev.off()

## Doing the analysis without the extreme of the outliers S0164

File.Bed <-"Common_rare_S0164.bed"
File.Bim <- "Common_rare_S0164.bim"
File.Fam <- "Common_rare_S0164.fam"
File.SetID<-"../Gene_list_plink_files/Exon_6bp_sai_list.txt"
File.SSD<- "Common_rare.SSD"
File.Info<- "Common_rare.info"

Generate_SSD_SetID(File.Bed,File.Bim,
                   File.Fam,File.SetID,
                   File.SSD,File.Info)

SSD.INFO<-Open_SSD(File.SSD, File.Info)

Open_SSD(File.SSD,File.Info)
obj<-SKAT_Null_Model(pheno_S0164$LPK_Nadir_log~ 1, out_type="C")


##SKAT 
SKAT_Log_Unadj_Leu<-SKAT.SSD.All(SSD.INFO, obj)
SKAT_Log_Unadj_Leu$results[order(SKAT_Log_Unadj_Leu$results$P.value),] [1:15,]
qq(SKAT_Log_Unadj_Leu$results$P.value,
   main ="Quantitative SKAT result - log normalized Leu")

SKAT_Log_adj_Leu<-SKAT.SSD.All(SSD.INFO, obj,weights.beta=c(1,1))
SKAT_Log_adj_Leu$results[order(SKAT_Log_adj_Leu$results$P.value),] [1:15,]
SKAT_Log_adj_Leu$results$p_adjust_BH<-p.adjust((SKAT_Log_adj_Leu$results$P.value),
                                                 method ="BH")
SKAT_Log_adj_Leu$results$p_adjust_Bonf<-p.adjust((SKAT_Log_adj_Leu$results$P.value),
                                                   method ="bonferroni")

write.table(SKAT_Log_adj_Leu$results[order(SKAT_Log_adj_Leu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKAT_adj_Log_Leu_S0164_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKAT_Leu_Log_S0164.pdf", width=4, height=4)
qq(SKATO_Log_adj_Leu$results$P.value, 
   main ="Quantitative SKAT Log LPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()


############################################################

qq(SKAT_Log_adj_Leu$results$P.value, 
   main ="Quantitative weights adjusted SKAT result - log normalized Leu")


pdf("SKAT_results_Leu_log_normalized_Quantitative.pdf")
qq(SKAT_Log_Unadj_Leu$results$P.value,
   main ="Quantitative SKAT result - log normalized Leu")
qq(SKAT_Log_adj_Leu$results$P.value, 
   main ="Quantitative weights adjusted SKAT result - log normalized Leu")
dev.off()
###################################################

## Burden test

Burden_Log_Unadj_Leu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1)
Burden_Log_Unadj_Leu$results[order(Burden_Log_Unadj_Leu$results$P.value),] [1:15,]
qq(Burden_Log_Unadj_Leu$results$P.value, 
   main = "Burden result Log Non-adjusted")

Burden_Log_adj_Leu<-SKAT.SSD.All(SSD.INFO, obj, r.corr=1,weights.beta=c(1,1))
Burden_Log_adj_Leu$results[order(Burden_Log_adj_Leu$results$P.value),] [1:15,]
Burden_Log_adj_Leu$results$p_adjust_BH<-p.adjust((Burden_Log_adj_Leu$results$P.value),
                                               method ="BH")
Burden_Log_adj_Leu$results$p_adjust_Bonf<-p.adjust((Burden_Log_adj_Leu$results$P.value),
                                                 method ="bonferroni")

write.table(Burden_Log_adj_Leu$results[order(Burden_Log_adj_Leu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/Burden_adj_Log_Leu_S0164_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("Burden_Leu_Log_S0164.pdf", width=4, height=4)
qq(Burden_Log_adj_Leu$results$P.value, 
   main ="Quantitative Burden Log LPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

##########################################################
qq(Burden_Log_Unadj_Leu$results$P.value, 
   main ="Burden result Weight Adjusted Log Leu")

pdf("Burden_results_Leu_Quantitative_log.pdf")
qq(Burden_Log_Unadj_Leu$results$P.value, 
   main = "Burden result Log Non-adjusted")
qq(Burden_Log_Unadj_Leu$results$P.value, 
   main ="Burden result Weight Adjusted Log Leu")
dev.off()

##SKAT-O
SKATO_Log_Unadj_Leu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj")
SKATO_Log_Unadj_Leu$results[order(SKATO_Log_Unadj_Leu$results$P.value),] [1:15,]
qq(SKATO_Log_Unadj_Leu$results$P.value,
   main ="SKATO Log Leu Quantitative DATA UNADJUSTED")

SKATO_Log_adj_Leu<-SKAT.SSD.All(SSD.INFO, obj, method="optimal.adj",weights.beta=c(1,1))
SKATO_Log_adj_Leu$results[order(SKATO_Log_adj_Leu$results$P.value),] [1:15,]
SKATO_Log_adj_Leu$results$p_adjust_BH<-p.adjust((SKATO_Log_adj_Leu$results$P.value),
                                                 method ="BH")
SKATO_Log_adj_Leu$results$p_adjust_Bonf<-p.adjust((SKATO_Log_adj_Leu$results$P.value),
                                                   method ="bonferroni")

write.table(SKATO_Log_adj_Leu$results[order(SKATO_Log_adj_Leu$results$P.value),] [1:15,],
            "~/Dropbox/Result_From_R/SKATO_adj_Log_Leu_S0164_top15.txt",
            sep="\t", quote = F, row.names = F)

pdf("SKATO_Leu_Log_S0164.pdf", width=4, height=4)
qq(SKATO_Log_adj_Leu$results$P.value, 
   main ="Quantitative SKATO Log LPK", 
   cex.lab =0.70, cex.main= 0.70)
dev.off()

#################################################
qq(SKATO_Log_adj_Leu$results$P.value, 
   main ="SKATO LOG Quantitative DATA ADJUSTED")

pdf("SKATO_results_Leu_Quantitative_LOG_S0164.pdf")
qq(SKATO_Log_Unadj_Leu$results$P.value,
   main ="SKATO Log Leu Quantitative DATA UNADJUSTED")
qq(SKATO_Log_adj_Leu$results$P.value, 
   main ="SKATO LOG Quantitative DATA ADJUSTED")
dev.off()


#######################################################
##### VENN DIAGRAM OF THE ABOVE RESULTS FOR BETTER VISUALIZATION
LPK_SKAT_ENQT<-as.character((SKAT_ENQT_adj_Leu$results[(which(SKAT_ENQT_adj_Leu$results$P.value <= 1.00e-03)),])$SetID)
LPK_SKAT_LOG<-as.character((SKAT_Log_adj_Leu$results[(which(SKAT_Log_adj_Leu$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(LPK_SKAT_ENQT=LPK_SKAT_ENQT, LPK_SKAT_LOG= LPK_SKAT_LOG),
                  lty = rep("blank", 2), fill = c("light pink", " yellow"), 
                  alpha = rep(0.5, 2),cat.pos = c(0,0), 
                  cat.cex = 1.0, cex=0.5,
                  ,filename=NULL, scaled = FALSE)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(setdiff(NPK_SKAT_LOG,LPK_SKAT_ENQT), collapse="\n") 
v[[6]]$label <- paste(setdiff(LPK_SKAT_ENQT, NPK_SKAT_LOG), collapse="\n")
v[[7]]$label <- paste(intersect(NPK_SKAT_LOG, LPK_SKAT_ENQT), collapse="\n")

pdf("SKAT_Leu_Genebased.pdf", width=4, height=4)


grid.newpage()
grid.draw(v)
dev.off()


###########################################################################
LPK_Burden_ENQT<-as.character((Burden_ENQT_adj_Leu$results[(which(Burden_ENQT_adj_Leu$results$P.value <= 1.00e-03)),])$SetID)
LPK_BURDEN_LOG<-as.character((Burden_Log_adj_Leu$results[(which(Burden_Log_adj_Leu$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(LPK_Burden_ENQT=LPK_Burden_ENQT, LPK_BURDEN_LOG=LPK_BURDEN_LOG),
                  lty = rep("blank", 2), fill = c("light pink", " yellow"), 
                  alpha = rep(0.5, 2),cat.pos = c(0,0), 
                  cat.cex = 1.0, cex=0.5,
                  ,filename=NULL, scaled = FALSE)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(setdiff(LPK_BURDEN_LOG,LPK_Burden_ENQT), collapse="\n") 
v[[6]]$label <- paste(setdiff(LPK_Burden_ENQT, LPK_BURDEN_LOG), collapse="\n")
v[[7]]$label <- paste(intersect(LPK_Burden_ENQT, LPK_BURDEN_LOG), collapse="\n")

pdf("BURDEN_Leu_Genebased.pdf", width=8, height=8)
grid.newpage()
grid.draw(v)
dev.off()


#########################################################################################
LPK_SKATO_ENQT<-as.character((SKATO_ENQT_adj_Leu$results[(which(SKATO_ENQT_adj_Leu$results$P.value <= 1.00e-03)),])$SetID)
LPK_SKATO_LOG<-as.character((SKATO_Log_adj_Leu$results[(which(SKATO_Log_adj_Leu$results$P.value <= 1.00e-03)),])$SetID )
v <- venn.diagram(list(LPK_SKATO_ENQT=LPK_SKATO_ENQT, LPK_SKATO_LOG=LPK_SKATO_LOG),
                  lty = rep("blank", 2), fill = c("light pink", " yellow"), 
                  alpha = rep(0.5, 2),cat.pos = c(0,0), 
                  cat.cex = 1.0, cex=0.5,
                  ,filename=NULL, scaled = FALSE)
grid.newpage()
grid.draw(v)
lapply(v,  names)
lapply(v, function(i) i$label)
v[[5]]$label  <- paste(setdiff(LPK_SKATO_LOG, LPK_SKATO_ENQT), collapse="\n") 
v[[6]]$label <- paste(setdiff(LPK_SKATO_ENQT, LPK_SKATO_LOG), collapse="\n")
v[[7]]$label <- paste(intersect(LPK_SKATO_ENQT, LPK_SKATO_LOG), collapse="\n")

pdf("SKATO_Leu_Genebased.pdf", width=8, height=8)
grid.newpage()
grid.draw(v)
dev.off()

