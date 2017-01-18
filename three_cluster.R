#################################################################################################
#################################################################################################
## CLUSTERING IN THREE CLUSTERS

# Scale
data2 <- data.frame(scale(data))
my_data_2 <- data.frame(scale(my_data))
plot(sapply(my_data_2, var))
# Proceed with principal components
pc <- princomp(data2)


pc2<- princomp(my_data_2)
plot(pc2)
plot(pc2, type='l')
summary(pc2)


# Get principal component vectors using prcomp instead of princomp
pc2 <- prcomp(my_data_2)

# First for principal components
comp2 <- data.frame(pc2$x[,1:3])
# Plot

plot(comp2, pch=16, col=rgb(0,0,0,0.5))

library(rgl)
# Multi 3D plot
plot3d(comp2$PC1, comp2$PC2, comp2$PC3)

# K-means clustering
# Determine the correct number of clusters via weighted sum of squares
# (from R in Action: http://www.statmethods.net/advstats/cluster.html)

wss1 <- (nrow(comp2)-1)*sum(apply(comp2,2,var))
for (i in 2:15) wss1[i] <- sum(kmeans(comp2, centers=i, nstart=100, iter.max=1000)$withinss)
plot(1:15, wss1, type="b", xlab="Number of Clusters",
     ylab="Within groups sum of squares")


# From scree plot elbow occurs at k = 2/3... (to be discussed)
# Apply k-means with k=3
## at K=3 

k3 <- kmeans(comp2, 3, nstart=25, iter.max=1000)
library(RColorBrewer)
library(scales)
palette(alpha(brewer.pal(9,'Set1'), 0.5))
plot(comp2, col=k3$clust, pch=16)

# 3D plot

plot3d(comp2$PC1,comp2$PC2, comp2$PC3, col=k3$clust)

# Cluster sizes
sort(table(k3$clust))
clust <- names(sort(table(k3$clust)))

# First cluster
row.names(my_data_2[k3$clust==clust[1],])
# Second Cluster
row.names(my_data_2[k3$clust==clust[2],])
# three Cluster
row.names(my_data_2[k3$clust==clust[3],])



Clustered_ID <- as.data.frame(cbind(k2$cluster, as.character(Phe_WGS$FID)))
Clustered_ID$Group <- ifelse(Clustered_ID$V1==1,"LowTox","HighTox")
Clustered_ID$WGS_sam <- which(Clustered_ID$V2 %in% WGS_sample$V2)
WGS_sample <- read.table("~/Desktop/RNAseq/WGS2WES.txt", header=FALSE)
WGS_sample$V2 <- as.character(WGS_sample$V2)
WGS_sample$V1 <- as.character(WGS_sample$V1)
Clustered_ID$V2 <- as.character(Clustered_ID$V2)
WGS_Sample_Reordered <- WGS_sample[order(WGS_sample$V2),]
Clustered_ID$WGS_sam <- WGS_Sample_Reordered[which(Clustered_ID$V2 %in% WGS_Sample_Reordered$V2),][,1]


Clustered_ID$CTC_combined <- CTC[which(as.character(Clustered_ID$V2)  %in%  CTC$IID),][,5]
dim(Clustered_ID[which(Clustered_ID$Group=="HighTox" & Clustered_ID$CTC_combined=="HighTox"),])
dim(Clustered_ID[which(Clustered_ID$Group=="LowTox" & Clustered_ID$CTC_combined=="LowTox"),])
dim(Clustered_ID[which(Clustered_ID$Group=="HighTox" & Clustered_ID$CTC_combined=="LowTox"),])
dim(Clustered_ID[which(Clustered_ID$Group=="LowTox" & Clustered_ID$CTC_combined=="HighTox"),])













#################################################################################################
#################################################################################################
TPK_cluster <- kmeans ((my_data_2 [,1:2]), 3)
TPK_cluster
table(TPK_cluster$cluster,Phe_WGS$TPK_CTC)
##    0  1  2  3  4
## 1 17  8  7  0  0
## 2  0  0  5 20 20
## 3 10  4  2  3  0
par(mar=c(5,5,5,5)+0.2)
plot(my_data_2[,1],my_data_2[,2], col=TPK_cluster$cluster, pch =16, 
     xlab="TPK_Baseline", ylab="TPK_Nadir", main="Clustering on 3 clustering in TPK phenotype")
points(TPK_cluster$centers, col =1:3, pch =15, cex=3)
text (my_data_2[,1],my_data_2[,2],labels  = Phe_WGS$TPK_CTC, pos = 3,cex=0.75)


LPK_cluster <- kmeans ((my_data_2 [,3:4]), 3)
LPK_cluster
table(LPK_cluster$cluster,Phe_WGS$LPK_CTC)
##    0  1  2  3  4
## 1 14  0  0  0  0
## 2 25  6  9  1  0
## 3  0  1 13 23  4

par(mar=c(5,5,5,5)+0.2)
plot(my_data_2[,3],my_data_2[,4], col=LPK_cluster$cluster, pch =16,
     xlab="LPK_Baseline", ylab="LPK_Nadir", main="Clustering on 2 clustering in LPK phenotype")
points(LPK_cluster$centers, col =1:3, pch =15, cex=3)
text (my_data_2[,3],my_data_2[,4],labels  = Phe_WGS$LPK_CTC, pos = 3,cex=0.75)


NPK_cluster <- kmeans ((my_data_2 [,5:6]), 3)
NPK_cluster
table(NPK_cluster$cluster,Phe_WGS$Neutrophiles_CTC)
##    0  2  3  4
## 1 18  0  0  0
## 2  0  2 18 28
## 3 26  4  0  0


par(mar=c(5,5,5,5)+0.2)
plot(my_data_2[,5],my_data_2[,6], col=NPK_cluster$cluster, pch =16,
     xlab="NPK_Baseline", ylab="NPK_Nadir", main="Clustering on 2 clustering in NPK phenotype")
points(NPK_cluster$centers, col =1:3, pch =15, cex=3)
text (my_data_2[,5],my_data_2[,6],labels  = Phe_WGS$Neutrophiles_CTC, pos = 3,cex=0.75)
