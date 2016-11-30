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

## while loop examples from datacamp

# Initialize the speed variable
speed <- 64

# Code the while loop
while (speed >30) {
  print ("Slow down!")
  speed <- speed -7
}
# Print out the speed variable
speed


####################################
speed <- 64

# Extend/adapt the while loop
while (speed > 30) {
  print(paste("Your speed is",speed))
  if (speed > 48) {
    print ("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6 
  }
}

#####################################
## Using break in if loop

speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))

  # Break the while loop when speed exceeds 80
  if (speed >80 ) {
  print ("The hurricane is near!!")  
  }
  break
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}


####################################################
## Using break and while loop
## prints out the triple of i, so 3 * i, at each run.
## is abandoned with a break if the triple of i is divisible by 8, but still prints out this triple before breaking.
i <- 1

# Code the while loop
while (i <= 10) {
  print(3*i)
  if ((i*3) %% 8 == 0) {
    break
  }
  i <- i + 1
}
