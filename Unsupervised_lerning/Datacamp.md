#### Chapter 1:


```R

# Initialize total within sum of squares error: wss
wss <- 0

# For 1 to 15 cluster centers
for (i in 1:15) {
  km.out <- kmeans(x, centers = i, nstart = 20)
  # Save total within sum of squares to wss variable
  wss[i] <- km.out$tot.withinss
}

# Plot total within sum of squares vs. number of clusters
plot(1:15, wss, type = "b", 
     xlab = "Number of Clusters", 
     ylab = "Within groups sum of squares")

# Set k equal to the number of clusters corresponding to the elbow location
k <-3

### Some examples of kmeans methods


using pokemon dataset to practise clustering with k 

# Initialize total within sum of squares error: wss


wss <- 0

# Look over 1 to 15 possible clusters
for (i in 1:15) {
  # Fit the model: km.out
  km.out <- kmeans(pokemon, centers = i, nstart = 20, iter.max = 50)
  # Save the within cluster sum of squares
  wss[i] <- km.out$tot.withinss
}

# Produce a scree plot


plot(1:15, wss, type = "b", 
     xlab = "Number of Clusters", 
     ylab = "Within groups sum of squares")

# Select number of clusters
k <- 3

# Build model with k clusters: km.out
km.out <- kmeans(pokemon, centers = k, nstart = 20, iter.max = 50)

# View the resulting model
km.out

# Plot of Defense vs. Speed by cluster membership
plot(pokemon[, c("Defense", "Speed")],
     col = km.out$cluster,
     main = paste("k-means clustering of Pokemon with", k, "clusters"),
     xlab = "Defense", ylab = "Speed")
```
Learned




##### Hierarchical clustering
mean and stadndard variation of each features need to chaded 
```R

# Cluster using complete linkage: hclust.complete
hclust.complete <- hclust(dist(x), method="complete")

# Cluster using average linkage: hclust.average
hclust.average <- hclust(dist(x), method="average")

# Cluster using single linkage: hclust.single
hclust.single <- hclust(dist(x), method="single")

# Plot dendrogram of hclust.complete
plot(hclust.complete, main ="Complete")

# Plot dendrogram of hclust.average
plot(hclust.average, main ="Average")

# Plot dendrogram of hclust.single
plot(hclust.single, main ="Single")


#######################################################
### Using complete linkage analysis in pokemon dataset
# View column means
colMeans(pokemon)

# View column standard deviations
apply(pokemon, 2, sd)

# Scale the data
pokemon.scaled <- scale(pokemon)

# Create hierarchical clustering model: hclust.pokemon
hclust.pokemon <- hclust(dist(pokemon.scaled), method="complete")
```
```R
## comparing two methods

# Apply cutree() to hclust.pokemon: cut.pokemon
cut.pokemon <- cutree(hclust.pokemon, k =3)

# Compare methods
table(cut.pokemon, km.pokemon$cluster)
```


#### PCA


Visualization model for PCA

```R

 # Mean of each variable
colMeans(pokemon)

# Standard deviation of each variable
apply(pokemon, 2, sd)

# PCA model with scaling: pr.with.scaling
pr.with.scaling <- prcomp(x = pokemon, scale = TRUE)

# PCA model without scaling: pr.without.scaling
pr.without.scaling <- prcomp(x = pokemon, scale = FALSE)

# Create biplots of both for comparison

biplot(pr.with.scaling)
biplot(pr.without.scaling)

```
#### Example with a real dataset
```R

#### Reading the data in R


url <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1903/datasets/WisconsinCancer.csv"

# Download the data: wisc.df
wisc.df <- read.csv (url, sep =",", header = TRUE)

# Convert the features of the data: wisc.data
wisc.data <- as.matrix(wisc.df[, c(3:32)])

# Set the row names of wisc.data
row.names(wisc.data) <- wisc.df$id

# Create diagnosis vector
diagnosis <- as.numeric(wisc.df$diagnosis == "M")


#### Perforimg PCA in the dataset

# Check column means and standard deviations
colMeans(wisc.data)
apply(wisc.data, 2, sd )


# Execute PCA, scaling if appropriate: wisc.pr
wisc.pr <- prcomp (x = wisc.data, scale =TRUE)

# Look at summary of results
summary(wisc.pr)


#### Interpreting PCA
# Create a biplot of wisc.pr
biplot(wisc.pr)


# Scatter plot observations by components 1 and 2
plot(wisc.pr$x[, c(1, 2)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC2")

# Repeat for components 1 and 3
plot(wisc.pr$x[, c(1, 3)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC3")

# Do additional data exploration of your choosing below (optional)
plot(wisc.pr$rotation[, c(1, 4)], col = (diagnosis + 1), 
     xlab = "PC1", ylab = "PC4")
     
     
 ### Understanding variance explained in the dataset using screeplot
 
 par(mfrow = c(1, 2))

# Calculate variability of each component
pr.var <-  wisc.pr$sdev^2

# Variance explained by each principal component: pve
pve  <-  pr.var/ sum (pr.var)

# Plot variance explained for each principal component
plot(pve, xlab = "Principal Component", 
     ylab = "Proportion of Variance Explained", 
     ylim = c(0, 1), type = "b")

# Plot cumulative proportion of variance explained
plot(cumsum(pve), xlab = "Principal Component", 
     ylab = "Cummulative Proportion of Variance Explained", 
     ylim = c(0, 1), type = "b")
     
     
     
 ### Doing some hierarchial clustering data
 
 # Scale the wisc.data data: data.scaled
data.scaled <- scale (wisc.data)

# Calculate the (Euclidean) distances: data.dist
data.dist  <- dist(data.scaled)

# Create a hierarchical clustering model: wisc.hclust
wisc.hclust <- hclust(data.dist, method ="complete")



## Finding the clusters to be K= 4 and doing some rudimentary cutting
# Cut tree so that it has 4 clusters: wisc.hclust.clusters
wisc.hclust.clusters <- cutree(wisc.hclust, k =4)

# Compare cluster membership to actual diagnoses
table (wisc.hclust.clusters, diagnosis)



### Comparing between hclustering and kmeans

# Create a k-means model on wisc.data: wisc.km
wisc.km = kmeans ((scale(wisc.data)), centers = 2, nstart = 20)


# Compare k-means to actual diagnoses
table (wisc.km$cluster, diagnosis)

# Compare k-means to hierarchical clustering
table (wisc.km$cluster, wisc.hclust.clusters)











 Create a hierarchical clustering model: wisc.pr.hclust
wisc.pr.hclust <- hclust(dist(wisc.pr$x[, 1:7]), method = "complete")

# Cut model into 4 clusters: wisc.pr.hclust.clusters
wisc.pr.hclust.clusters <- cutree (wisc.pr.hclust, k = 4)

# Compare to actual diagnoses
table ( wisc.hclust.clusters, diagnosis)
table ( wisc.pr.hclust.clusters, diagnosis)

# Compare to k-means and hierarchical
table(wisc.km$cluster, diagnosis)
