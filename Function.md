# Function lecture of Data-Camp 

Function has three parts 
* one in which you give name for specifiied function
* execution part where it is supposed to do / optionally it also could have return valie
* usually the enviroment where it is being executed

Clearly it is also an obect in R environment

```R
my_fun <- function(arg1, arg2) {
  # body
}
```

###### Example-1

```R
# Define ratio() function
my_fun <- function(arg1, arg2) {
  # 
  arg1/arg2
}

# Call ratio() with arguments 3 and 4
my_fun(3,4)
```
###### Example-2 

In this example we see that the condition is always evaluted and ther function returns early without even running the x
```R
f <- function(x) {
  if (TRUE) {
    return(x + 1)
  }
  x
}
```

#### Lecture 2 Enviroments in R

Functions are called in new clean environment which is locally available to this function. In this environment arguments and variables for this particular function are called upon and body is called upon. However, if objects are not called upon the variables are looked upon one upper environment as in global environment.


#### Data Types in R

* Atomic Vector
* List

Atomic vector usually contains the homogenous data-type in it. These could be numeric vector or logical vector or character vector. In most of the circumstances they would work just fine with data type to store it in form of vector or matrix. However, to increase effciency of data storage we might have to go beyond normal vector method of storing and in these condition lists are handy.

In the following snippet of codes it is preseneted the ways to access data in list
```R
# 2nd element in tricky_list
typeof(tricky_list [[2]])

# Element called x in tricky_list
typeof((tricky_list [["x"]]))

# 2nd element inside the element called x in tricky_list
typeof(tricky_list [["x"]] [[2]]
```

In order to get the list element we can use the double bracelets that can be done 
```R
# Guess where the regression model is stored
names(tricky_list)

# Use names() and str() on the model element
names(tricky_list$model)
str(tricky_list$model)

# Subset the coefficients element
tricky_list$model$coefficients

# Subset the wt element
tricky_list$model$coefficients[["wt"]]
```

#### For loops

Review and new basic concept of for loops

For loops are important looping structure in R. The basic receipe of for loops can be seen as here
```R
df <- data.frame()
1:ncol(df)

for (i in 1:ncol(df)) {
  print(median(df[[i]]))
}

``` 
 
Here we can see three basic structures to for loop which are :-
 
* sequence --> start to end of loop
* body --> what is supposed to do
* output --> defination of where to store the loop


Important note: While creating a empty vector of given vector use the function vector with type of element it is stored with. Use two arguments: the type of vectors ("logical", "integer", "double", "character") and the length of vector


#### Lecture 2 "when to write function"

Repeating same command on and on is not clever way to do an operations. Repeation of the commands make is hard to understand what it is doing as well it also hampers decoding scheme for mistake finding. Thats why we write a function. Basic rule of thumb is when you have copied-and-pasted twice its time to write a function. This would helps in making more updates in coding.


In a real hand example we are trying with rescaling a column between 0 and 1

For example we have a rescale logic as seen below

```R
(df$a - min(df$a, na.rm = TRUE)) /  
  (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
```

Now we would like to make a function out of this logic so that it coule be used a general function that could be used for generality
```R
# Define example vector x
x <- c(1:10)

# Rewrite this snippet to refer to x
(x- min(x, na.rm = TRUE)) /
  (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
```
 
 In this example what we are doing is trying to make a generality of vector
 
 After some inspection with snippet of code, we found that range can do us good to find the maximun and minimum of our vector. We find assign the range and use it in following way
 ```R
 # Define example vector x
x <- 1:10

# Define rng
rng <- range(x, na.rm=TRUE)

# Rewrite this snippet to refer to the elements of rng
(x - rng[[1]])/
  (rng[[2]]- rng[[1]])
 ``` 
 
 Finally, putting all of these codes together to get the function rescale01 as below:
 
 ```R
 # Define example vector x
x <- 1:10 

# Use the function template to create the rescale01 function

rescale01 <- function(x) {
  rng <- range(x, na.rm=TRUE)
  (x - rng[[1]] )/ (rng[[2]]- rng[[1]])
}

# Test your function, call rescale01 using the vector x as the argument
rescale01(x) 
```


So in the end did the following things to convert into function:

* Start with simple problem
* Get the working snippet of code
* Rewrite to use temporary variables
* Rewrite for clarity
* Finally, turn into a function

#### Extra practise sessions

Problem identification: Here we want to write a function both_na() that counts at how many positions two vectors , x and y, both have a missing value
```R
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)

sum(is.na(x) & is.na(y))
## Snippet of code that works to find postion where there is missing values
```

Using this snippet to get function
```R
# Define example vectors x and y
x <- c( 1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3,  4)

# Turn this snippet into a function: both_na()
 
 both_na <- function (x,y){
  sum(is.na(x) & is.na(y))
}
``` 

testing with some examples
```R
# Define x, y1 and y2
x <-  c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)

# Call both_na on x, y1
both_na(x, y1)

# Call both_na on x, y2
both_na(x, y2)
## here in the second example we encounter an error which telss us that object length is not equal hence we have to change this
```

#### Write a good understandable function that can be universally implemented

Elements of good function

* Sovles problem correctlly
* understandable to others


Good names helping in understanding function clearly 

##### Naming a function
* make a conistent style function
* Dont override existing variable or functions
* should generally function
* should be descriptive

##### Naming an argument

* should be nouns
* use the common short names when appropriate

*** x,y and z: vectors
*** df; a dataframe
*** i , j: numeric indices (typically rows and columns)
*** n: length or number of rows


