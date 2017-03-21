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


### READING TWO FILE WITH read.delim, read.csv
read.table ("states2.txt",
              header = TRUE,
              sep ="/",
              stringAsFactors = FALSE)

# Import hotdogs.txt: hotdogs
hotdogs <- read.delim("hotdogs.txt", header = FALSE)

# Summarize hotdogs
summary(hotdogs)


### something new with path file

# Path to the hotdogs.txt file: path
path <- file.path("data", "hotdogs.txt")

# Import the hotdogs.txt file: hotdogs
hotdogs <- read.table(path, 
                      sep = "\t", 
                      col.names = c("type", "calories", "sodium"))

# Call head() on hotdogs
head(hotdogs)

```




```R


```




```R


```
