##### Import data in 

From different files from different types

dir() is used in R to find directory path in R

```R
### Reading from the path
path <- path.files ("~", "datasets", "states.csv")
path
read.csv(path, stringsAsFactors = FALSE)

###
# Import swimming_pools.csv: pools
pools <- read.csv("swimming_pools.csv", stringsAsFactor = FALSE)
# Print the structure of pools
str(pools)

```




```R


```




```R


```
