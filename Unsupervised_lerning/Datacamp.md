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
