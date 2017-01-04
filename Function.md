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

* x,y and z: vectors
* df; a dataframe
* i , j: numeric indices (typically rows and columns)
* n: length or number of rows

##### Argument order

* two types of arguments

Data arguments--> specifiy data to compute  
Detail arguments --> apply arguments that control details of the computation


So in the end it is as follows:

- Use good names for functions and arguments
- Use an intutuve argument order and resonable default
- Make it clear what ther function returns
- Use good style inside the body of the function

Example:
```R
# Alter the arguments to mean_ci
mean_ci <- function(x,level = 0.95) {
  se <- sd(x) / sqrt(length(x))
  alpha <- 1 - level
  mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
}
```

altering different ways to improve function 
```R
# Alter the mean_ci function
mean_ci <- function(x, level = 0.95) {
  if (length(x) == 0){
    return( c(-Inf, Inf))
  }else{
    se <- sd(x) / sqrt(length(x))
    alpha <- 1 - level
    mean(x) + se * qnorm(c(alpha / 2, 1 - alpha / 2))
  }    
}
```

Examples of good function 
```R

# Rename the function f() to replace_missings()

replace_missings <- function(x, replacement) {
  # Change the name of the y argument to replacement
  x[is.na(x)] <- replacement
  cat(sum(is.na(x)), replacement, "\n")
  x
}

# Rewrite the call on df$z to match our new names
df$z <- replace_missings(df$z, 0)
```
Evolving function 
```R
replace_missings <- function(x, replacement) {
  # Define is_miss
  is_miss <- is.na(x)
  
  # Rewrite rest of function to refer to is_miss
  x[is_miss] <- replacement
  cat(sum(is_miss), replacement, "\n")
  x
}
```


providng with message for user
```R
replace_missings <- function(x, replacement) {
  is_miss <- is.na(x)
  x[is_miss] <- replacement
  
  # Rewrite to use message()
  message("sum(is_miss) missing replaced by value replacement.")
  x
}

# Check your new function by running on df$z
replace_missings(df$z ,0)
```

#### Functional programming in R 

Functional programming is the concept that feeds on idea of using specific mathematical functions to be used in defining functions in a programming language. While giving an example of making a cup-cake the lecture have provided a scenaraio where for -loops are unefficient to loop throgh the problem. Although it is explict to use thr for loop in detailed way, howver doing the same thing again and again would not able to find the nitty gritty details.  Using purr package we will use functional programming.

Providing a basic example of for loop
```R
# Initialize output vector
output <- vector("double", ncol(df))  

# Fill in the body of the for loop
for (i in seq_along(df)) {            
output[i] <- median(df[[i]])
}

# View the result
output 
```

Scaling up for different dataframe we can do the same while changing the dataframe. However a cleverer way is we could change it to function
```R
# Turn this code into col_median()
col_median <- function (df){
  output <- numeric(length(df)) 
  for (i in seq_along(df)) {            
    output[[i]] <- median(df[[i]])      
  }
  output
}
```

Now lets compare it to the premise he made in the earlier lecture and calculate mean in earlier formulation
```R
# Create col_mean() function to find column means
col_mean <- function(df) {
  output <- numeric(length(df))
  for (i in seq_along(df)) {
    output[[i]] <- mean(df[[i]])
  }
  output
}
```

Now when you compare the both functions it is clear that both have same formulation except for use of mean function
```R
# Define col_sd() function
col_sd <- function(df) {
  output <- numeric(length(df))
  for (i in seq_along(df)) {
    output[[i]] <- sd(df[[i]])
  }
  output
}
```

Continuing with the slight recap of the function argument
```R
f <- function(x,y) {
    # Edit the body to return absolute deviations raised to power
    abs(x - mean(x))^y
}
```

###### Lecture 2 Function can be argument as well

So in the lecture we are taught how could the above all the col_means, col_median and col_sd function have same similarity and difference. Connecting the argument with the intial premise we can see that we have only diffrence in calling of function mean, median and sd. So if we are able to provide it as argument then we can easily change to function into argument
```R
# Define col_sd() function
col_summary <- function(df, fun) {
  output <- vector("numeric", length(df))
  for (i in seq_along(df)) {
    output[[i]] <- fun(df[[i]])
  }
  output
}
```
###### Lecture 3 Passing function as arguments


talking about different map function in purr

map() returns a list or data frame
map_lgl() returns a logical vector
map_int() returns a integer vector
map_dbl() returns a double vector
map_chr() returns a character vector


this was kinda of hard to understand but I think i got it

###### Find the columns that are numeric
map_lgl(df3, is.numeric)

###### Find the type of each column
map_chr(df3, typeof)

###### Find a summary of each column
map(df3, summary)


Extra information

Snippet of code that would do the linear regression in our dataset for example
```R
fit_reg <- function(df) {
  lm(mpg ~ wt, data = df)
}
```

Going with the anomyous function as this is done only once so we can give it as
```R
map(cyl, function(df) lm (mpg ~ wt, data =df))
```

Here now the lecture is more tailored to purr package and its utility in calling of function 
for example if we want to find the mean displacement (from cyl package in R) we can write a function as
```R
 map_dbl(cyl, function(df) mean(df$disp))
```
However if this has to be done with shortcuts in purr package we can do using less words as
```R
map_dbl(cyl, ~ mean(.$disp))
```

We can do the same as for the above statement

```R
map(cyl, function(df) lm (mpg ~ wt, data =df))
map(cyl, ~ lm (.$mpg ~ .$wt, data = .))
```

This is such a cool way to manipulate list in R

```R
# Save the result from the previous exercise to the variable models
models <- map(cyl, ~ lm(mpg ~ wt, data = .))

# Use map and coef to get the coefficients for each model: coefs
coefs <- map (models, coef)

# Use string shortcut to extract the wt coefficient 
map (coefs, "wt")
map_dbl (coefs, 2)
```

Interesting operator called as pipe oerator '%>%' is the one wehich is used for shortcut ancd saves typing. 

interpretation :

x %>% f(y) is another way of writing f (x, y) that means "the left hand side of the pipe, x, becomes the first argument to the function, f(), on the right hand side of the pipe." 

See the following clever use of %>%

Normal routine
```R
cyl <- split(mtcars, mtcars$cyl) 
map(cyl, ~ lm(mpg ~ wt, data = .))
```

We split the data frame mtcars and save it as the variable cyl. We then pass cyl as the first argument to map to fit the models. We could rewrite this using the pipe operator as:

```R
split(mtcars, mtcars$cyl) %>% 
 map(~ lm(mpg ~ wt, data = .))
 ```

This reminds of how pipe can be used in R such that it is similar to one in Unix
```R
mtcars %>% 
  split(mtcars$cyl) %>%
  map(~ lm(mpg ~ wt, data = .)) %>%
  map(coef) %>% 
  map_dbl("wt")
 ```
 
 
 For example it ca be written an exaple of pipes as
 
 ```
 summaires <- map(models, summary) %>%
map_dbl("r.squared")```
 ```
