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

# Finish the read.delim() call
hotdogs <- read.delim("hotdogs.txt", header = FALSE, col.names = c("type", "calories", "sodium"))

# Select the hot dog with the least calories: lily
lily <- hotdogs[which.min(hotdogs$calories), ]

# Select the observation with the most sodium: tom
tom <- hotdogs[which.max(hotdogs$sodium), ]

# Print lily and tom
print(lily)
print (tom)

#### Reading with the new col.cass
# Previous call to import hotdogs.txt
hotdogs <- read.delim("hotdogs.txt", header = FALSE, col.names = c("type", "calories", "sodium"))

# Display structure of hotdogs
str(hotdogs)

# Edit the colClasses argument to import the data correctly: hotdogs2
hotdogs2 <- read.delim("hotdogs.txt", header = FALSE, 
                       col.names = c("type", "calories", "sodium"),
                       colClasses = c("factor", "NULL", "numeric"))


# Display structure of hotdogs2
str(hotdogs2)


## read .table is the original files and read.csf files and read.delim are wrapper function of all
## read.csv2 and read.delim2 are used which are seperated by ","  than "." 

```




```R


```




```R


```
