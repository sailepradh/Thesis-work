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


###################################3##########################
## 1) practising for loops in 2 ways

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for (l in linkedin){
  print(l)
}

# Loop version 2

for (i in 1:length(linkedin)){
  print (linkedin[i])
}


# 2)  for loop in list
# The nyc list is already specified
nyc <- list(pop = 8405837, 
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"), 
            capital = FALSE)

# Loop version 1
for (i in nyc){
  print(i)
}


# Loop version 2
for (i in 1:length(nyc)){
  print(nyc[[i]])
}

## 3 Using nested loop with matrix

# The tic-tac-toe matrix ttt has already been defined for you

ttt <- some matrix
# define the double for loop
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
  }
}

## 4 Importang information about break and next
## The break statement abandons the active loop: the remaining code in the loop is skipped and the loop is not iterated over anymore.
## The next statement skips the remainder of the code in the loop, but continues the iteration.

# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  # Add if statement with break
  if (li > 16){
    print ("This is ridiculous, I'm outta here!")
    break
  }
  # Add if statement with next
  if (li < 5){
    print ("This is too embarrassing!")
    next
  }
  print(li)
}


## 5 Building R loop from scratch
# Pre-defined variables

rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]]

# Initialize rcount
rcount <- 0

# Finish the for loop
for (char in chars) {
  if (char =="r"){
    rcount = rcount + 1
  }else if (char == "u"){
    break
  }
}

# Print out rcount
print(rcount)


## ENd of intermediate level data camp
