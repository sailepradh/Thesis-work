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

## ENd of intermediate level  on loops in data camp

## 5 writting a function in R

## writing function receipe

## my_fun <- function(arg1, arg2){
##           body
##           }

## 5.1 
# Create a function pow_two()
pow_two <- function(x){
        x*x
}

# Use the function
pow_two(12)

# Create a function sum_abs()
sum_abs <- function (x ,y){
  abs(x)+abs (y)
}

# Use the function
sum_abs(-2,-3)

## Random assignment of function
throw_dice <- function() {
  number <- sample(1:6, size = 1)
  number
}

throw_dice()

## 5.2
# Define the function hello()
hello <- function () {
  print ("Hi there!")
  return(TRUE)
}

# Call the function hello()
hello()

## adding function with extra optional arguments

pow_two <- funtion (x, printinfo = TRUE){
                    y <- x^2
                    if (printinfo==TRUE){
                          print (paste("The number is ", y))
                        }      
                    return(y)
                    }


## Passing function such that you can add numbers to it 

increment <- function(x, inc = 1) {
  x <- x + inc
  x
}


## Some Functional programming in R

## Given the two vectors in R we are trying to find what should he do based on the following function num_views

# The linkedin and facebook vectors have already been created for you

# Define the interpret function
# The linkedin and facebook vectors have already been created for you

# Define the interpret function
interpret <- function(num_views) {
  if (num_views > 15) {
    print ("You're popular!")
      return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Call the interpret function twice
interpret(linkedin[1])
interpret(facebook[2])


## Calling two functions together 

# The linkedin and facebook vectors have already been created for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# The interpret() can be used inside interpret_all()
interpret <- function(num_views) {
  if (num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}

# Define the interpret_all() function
# views: vector with data to interpret
# return_sum: return total number of views on popular days?
interpret_all <- function(views, return_sum = TRUE) {
  count <- 0

  for (v in views) {
    count <- count + interpret(v)
  }

  if (return_sum == TRUE) {
    return(count)
  } else {
    return(NULL)
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(linkedin)
interpret_all(facebook)


### search ()





#### lappy function with anomoyous function for example

# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Transform: use anonymous function inside lapply

names <- lapply(split_low, function (x) {x[1]})

years <- lapply(split_low, function (x){x[2]})

## Function with muliple additional arguments
# Definition of split_low
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split <- strsplit(pioneers, split = ":")
split_low <- lapply(split, tolower)

# Generic select function
select_el <- function(x, index) {
  x[index]
}

# Use lapply() twice on split_low: names and years

names <- lapply (split_low , select_el, index = 1)
years <- lapply (split_low , select_el, index = 2)
