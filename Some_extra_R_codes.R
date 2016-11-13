## Making subset from the dataset based conditions for example

subset(planets_df, subset=diameter <1)

## Here considering planets_df as a dataframe with different variables, I made a subset of data based on diameter that are less than 1

## Making list for the different vector, matrix, and dataframe
# Vector with numerics from 1 up to 10
my_vector <- 1:10 

# Matrix with numerics from 1 up to 9
my_matrix <- matrix(1:9, ncol = 3)

# First 10 elements of the built-in data frame mtcars
my_df <- mtcars[1:10,]

# Adapt list() call to give the components names
my_list <- list(my_vector, my_matrix, my_df)
names(my_list) <- c("vec", "mat", "df")

# Print out my_list
my_list
