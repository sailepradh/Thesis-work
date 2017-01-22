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
 
 ```R
summaires <- map(models, summary) %>%
map_dbl("r.squared")
 ```

#### Advanced inputs and output in function


It is essential to map over multiple dataset and function. For this purpose, purr package provides with pmap which can iterate over multiple arguments be it dataset of function. For generalized purpose of 2 it mave provided map2

In the following examples, we use this principle to solve the problems
```R
# Create a list n containing the values: 5, 10, and 20
n = list(5, 10, 20)

# Call map() on n with rnorm() to simulate three samples
map(n, rnorm)
```

Similarly, we would like to mapping for two arguments for example simulate different dataset with differnt elements and differnt mean
```R
# Initialize n
n <- list(5, 10, 20)

# Create a list mu containing the values: 1, 5, and 10
mu <- list(1, 5, 10)

# Edit to call map2() on n and mu with rnorm() to simulate three samples
map2(n, mu, rnorm)
```

Again, if we consider rnorm function, it does take other arguments such as mean and standard deviations. However we can use pmap function in purr package to find the mean and standard deviations
```R
# Initialize n and mu
n <- list(5, 10, 20)
mu <- list(1, 5, 10)

# Create a sd list with the values: 0.1, 1 and 0.1
sd <- list(0.1, 1, 0.1)

# Edit this call to pmap() to iterate over the sd list as well
pmap(list(n, mu, sd), rnorm)

## more clever way is done as follows
pmap(list(mean = mu, n = n, sd = sd), rnorm)
```

Case : Next

Sometimes it's not the arguments to a function you want to iterate over, but a set of functions themselves. Imagine that instead of varying the parameters to rnorm() we want to simulate from different distributions, say, using rnorm(), runif(), and rexp(). How do we iterate over calling these functions
```R
# Define list of functions
f <- list("rnorm", "runif", "rexp")

# Parameter list for rnorm()
rnorm_params <- list(mean = 10)

# Add a min element with value 0 and max element with value 5
runif_params <- list(min = 0, max = 5)

# Add a rate element with value 5
rexp_params <- list(rate = 5)

# Define params for each function
params <- list(
  rnorm_params,
  runif_params,
  rexp_params
)

# Call invoke_map() on f supplying params as the second argument
invoke_map(f, n = 5, params)
```
##### Lecture : map with side effects

Some function in R have return value which might be either saved in disk. SO in ordet to use map function in purr this might be undesirable so we can use walk function which handles these side effects. As have been explained in the lectures these are useful when we use them in pipleines such that they can handle the intermediate result and pipe them to map function

 From thee exercise: walk() operates just like map() except it's designed for functions that don't return anything. You use walk() for functions with side effects like printing, plotting or saving.         
  
 For example in following examples we have created a histogram of all the functions in R with the simulated data set.
 ```R
# Define list of functions
f <- list(Normal = "rnorm", Uniform = "runif", Exp = "rexp")

# Define params
params <- list(
  Normal = list(mean = 10),
  Uniform = list(min = 0, max = 5),
  Exp = list(rate = 5)
)
```

use of walk2 with historam function however changing the breaks for diferent simulation
```R
# Replace "Sturges" with reasonable breaks for each sample
breaks_list <- list(
  Normal = seq(6, 16, 0.5),
  Uniform = seq(0, 5, 0.25) ,
  Exp = seq(0, 1.5, 0.1)
)

# Use walk2() to make histograms with the right breaks
walk2 (sims, breaks_list, hist)
```

making a function and using it for our dataset
```R
# Turn this snippet into find_breaks()

find_breaks <- function (x) {
  rng <- range(x, na.rm = TRUE)
  vec <- seq(rng[1], rng[2], length.out = 30)
  return(vec)
}

# Call find_breaks() on sims[[1]]
find_breaks(sims[[1]])
```

Using this customary breaks in our walk function
```R
# Use map() to iterate find_breaks() over sims: nice_breaks
nice_breaks <- map (sims, find_breaks)

# Use nice_breaks as the second argument to walk2()
walk2 (sims, nice_breaks, hist)
```

use of pwalk function to iterate over list of function' argument and list
```R
 # Increase sample size to 1000
sims <- invoke_map(f, params, n = 1000)

# Compute nice_breaks (don't change this)
nice_breaks <- map(sims, find_breaks)

# Create a vector nice_titles
nice_titles <- c("Normal(10, 1)" , "Uniform(0, 5)", "Exp(5)")


# Use pwalk() instead of walk2()
pwalk(list(x = sims, breaks = nice_breaks, main =nice_titles), hist,xlab="")
```

Piping the arguments of the previous results
```R
# Pipe this along to map(), using summary() as .f
sims %>%
  walk(hist) %>%
  map(summary)
```

#### robust functions

Robust function are interesting class as they help to find error in codes. In the lecture he talks about two kind of function that are present in R namely, interactive function and programming function. As interactiver function are useful they can cause error in pipleline of codes as they would except and give certian types of data input/output. 

One common recepie for checking these errors are using stopifnot functions
```R
stopifnot(is.character(x))

for example  could be
 if (!is.charcter(x)) {
 stop ("x should be character function" call.=FALSE)
 }
 ```
 
 Example 1: Using stopifnot arrangment in previous function that we made to check whether length of vector we provide are of same length or not.
 
 ```R
 # Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

both_na <- function(x, y) {
  stopifnot (length(x)==length(y))
  # Add stopifnot() to check length of x and y
  sum(is.na(x) & is.na(y))
}

# Call both_na() on x and y
both_na(x, y)
```

Another example of using good error messages in our function that we made
```R
# Define troublesome x and y
x <- c(NA, NA, NA)
y <- c( 1, NA, NA, NA)

both_na <- function(x, y) {
  # Replace condition with logical
  if (length(x) != length (y)) {
    # Replace "Error" with better message
    stop("x and y must have same length", call. = FALSE)
  }  
  
  sum(is.na(x) & is.na(y))
}

# Call both_na() 
both_na(x, y)
```


'' straight from the exercise:
Side effects describe the things that happen when you run a function that alters the state of your R session. If foo() is a function with no side effects (a.k.a. pure), then when we run x <- foo(), the only change we expect is that the variable x now has a new value. No other variables in the global environment should be changed or created, no output should be printed, no plots displayed, no files saved, no options changed. We know exactly the changes to the state of the session just by reading the call to the function.''
```R
replace_missings <- function(x, replacement) {
  x[is.na(x)] <- replacement
  x
}
```

#### Unstable functions

As going with the discussions, we are not into unstable function which upon calling would give ud different or maybe in conistent type of data structures. One of the example she talked was subsetting with [] function in R. However in most of cases it seems to work to get the vectore, problem ouccurs when we are trying to use in single column dataframe. we might except to get dataframe but due to its structure it might get us vector output. So in order to avoid these functions in programming would be a viable options to choose and additionally, we might have to work hard to get a vocabulary of functions that would behave consistently.

sapply() is another common offender returning unstable types. The type of output returned from sapply() depends on the type of input.

See the following example
```R

df <- data.frame(
  a = 1L,
  b = 1.5,
  y = Sys.time(),
  z = ordered(1)
)

A <- sapply(df[1:4], class) 
B <- sapply(df[3:4], class)

A --> list of all the elements
B -->  character matrix of 3 and 4 
```

Using differnt function such as map would help somehow to eliminate the problem faced
```R
# sapply calls
A <- sapply(df[1:4], class) 
B <- sapply(df[3:4], class)
C <- sapply(df[1:2], class) 

# Demonstrate type inconsistency
str(A)
str(B)
str(C)

# Use map() to define X, Y and Z
X <- map(df[1:4], class) 
Y <- map(df[3:4], class)
Z <- map(df[1:2], class) 

# Use str() to check type consistency
str(X)
str(Y)
str(Z)
```

This was something I didn't understood. I did almost the same except for subsetting with the []. thus my understanding was there was something theat subsetting mightt cause problem with thus it is better use this setting
```R
col_classes <- function(df) {
  # Assign list output to class_list
  class_list <- map(df, class)
  
  # Use map_chr() to extract first element in class_list
  map_chr(class_list, 1)
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()
```

Some interesting observation from the exercise below. We came across a logical operator called any which checks given a set of logical vectors, is at least one of the values true? (cool na!!) Additionally we also used map_dbl to check whether there is any vector with logical operator.
```R
col_classes <- function(df) {
  class_list <- map(df, class)
  
  # Add a check that no element of class_list has length > 1
  if (any(map_dbl(class_list, length) > 1)) {
    stop("Some columns have more than one class", call. = FALSE)
  }
  
  # Use flatten_chr() to return a character vector
  flatten_chr(class_list)
}

# Check that our new function is type consistent
df %>% col_classes() %>% str()
df[3:4] %>% col_classes() %>% str()
df[1:2] %>% col_classes() %>% str()
```

#### Non standard evaluation

These are another type of function in R which can cause problem in making function in R. As these function are premade, they are great in analysis as they would lessen the typing effort but problem occurs when you have to assign the exact names in the function whihc when you are writinga function, you are not sure of. Hence it is better to avoid this functions in function development.
example : Cool use of dplyr package and respective function

```R
big_x <- function(df, threshold) {
  dplyr::filter(df, x > threshold)
}

## use of the function in a dataset with threshold of 7
big_x(diamonds_sub, 7)
```
the problem with non standard evaluation can be observed in the following codes
```R
 # Remove the x column from diamonds
diamonds_sub$x <- NULL

# Create variable x with value 1
x <- 1

# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, 7)

# Create a threshold column with value 100
diamonds_sub$threshold <- 100

# Use big_x() to find rows in diamonds_sub where x > 7
big_x(diamonds_sub, 7)
```

This kinda of screwed me a lot.. one thing I learned was
!"x" %in% names(df) --> not in names 
```R
big_x <- function(df, threshold) {
  # Write a check for x not being in df
  if (!"x" %in% names(df)) {
    stop("df must contain variable called x", call. = FALSE)
  }
  

  # Write a check for threshold being in df
   if ("threshold" %in% names(df)) {
    stop("df must not contain variable called threshold", call. = FALSE)
  }
  

  
  dplyr::filter(df, x > threshold)
}
```

#### Use of options in R can help to find the global setting in R. The followund example sets the stage for the use of options in R
```R
# Read in the swimming_pools.csv to pools
pools <- read.csv("swimming_pools.csv")

# Examine the structure of pools
str(pools)

# Change the global stringsAsFactor option to FALSE
options(stringsAsFactors = FALSE)

# Read in the swimming_pools.csv to pools2
pools2<- read.csv("swimming_pools.csv")

# Examine the structure of pools2
str(pools2)
```

Straight from the exercise
"In general, you want to avoid having the return value of your own functions depend on any global options. That way, you and others can reason about your functions without needing to know the current state of the options."```R
```R
 # Fit a regression model
fit <- lm(mpg ~ wt, data = mtcars)

# Look at the summary of the model
summary(fit)

# Set the global digits option to 2
options(digit = 2)

# Take another look at the summary
summary(fit)
```
```R
for (i in seq(1,nrow(Common_NC_LT_all_tox))){
  Ref[i] <- ((Common_NC_LT_all_tox[i,4])*2)+(Common_NC_LT_all_tox[i,5])+(Common_NC_LT_all_tox[i,6]*2)+(Common_NC_LT_all_tox[i,7])+(Common_NC_LT_all_tox[i,8])+(Common_NC_LT_all_tox[i,9]*2)+(Common_NC_LT_all_tox[i,10])+(Common_NC_LT_all_tox[i,11])+(Common_NC_LT_all_tox[i,12]*2)
  Alt[i] <- (Common_NC_LT_all_tox[i,5])+(Common_NC_LT_all_tox[i,6]*2)+(Common_NC_LT_all_tox[i,7])+(Common_NC_LT_all_tox[i,8])+(Common_NC_LT_all_tox[i,9]*2)+(Common_NC_LT_all_tox[i,10])+(Common_NC_LT_all_tox[i,11])+(Common_NC_LT_all_tox[i,12]*2)
  output2[i] <- Alt[i]/Ref[i]
}```
