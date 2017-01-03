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


## Apply with self made function

# temp is already defined in the workspace

# Finish function definition of extremes_avg
extremes_avg <- function(x) {
  ( min(x) + max(x) )/ 2
}

# Apply extremes_avg() over temp using sapply()
sapply(temp, extremes_avg)

# Apply extremes_avg() over temp using lapply()
lapply(temp, extremes_avg)


## More examples

# temp is already available in the workspace

# Create a function that returns min and max of a vector: extremes
extremes <- function(x) {
  c(min = min(x), max = max(x))
}

# Apply extremes() over temp with sapply()
sapply(temp, extremes)

# Apply extremes() over temp with lapply()
lapply(temp, extremes)

## Example of anomyous function used in apply

sapply(list(runif (10), runif (10)), 
        function(x) c(min = min(x), mean = mean(x), max = max(x)))
          
          
## Basic understanding of apply function
          
          ## apply function enables useer to  avoid using for loop in data objects in R
          ## we have learned to used lapply function that generates list of elements after applyinf of function in either matrix or list.
          ## Mind you these function always generates list of elements
          ## It can be however sinplified to matrix or array objects based on the use of sapply.
          ## with vapply you can specifically tell what kind of data output you would like to return
          
## Examples of vapply function in R
# temp is already available in the workspace

# Definition of basics()
basics <- function(x) {
  c(min = min(x), mean = mean(x), max = max(x))
}

# Apply basics() over temp using vapply()
vapply(temp, basics, numeric(3))
          
################################
# temp is already defined in the workspace

# Convert to vapply() expression
vapply(temp, max, numeric(1))

# Convert to vapply() expression
vapply(temp, function(x, y) { mean(x) > y }, y = 5, logical(1))
          
          
#################LAST CHAPTER OF INTERMEDIATE R###############
   ## Regular expresssions
          ## searh pattern exicts or not  / replace, extract data
          
# The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for "edu"
grepl("edu", emails)

# Use grep() to match for "edu", save result to hits
hits <- grep ("edu", emails)

# Subset emails using hits
         
emails[hits]
         
 
# @, because a valid email must contain an at-sign.
# .*, which matches any character (.) zero or more times (*). Both the dot and the asterisk are metacharacters. You can use them to match any character between the at-sign and the ".edu" portion of an email address.
# \\.edu$, to match the ".edu" part of the email at the end of the string. The \\ part escapes the dot: it tells R that you want to use the . as an actual character.

 # The emails vector has already been defined for you
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", 
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")

# Use grepl() to match for .edu addresses more robustly
grepl ("@.*\\.edu$", emails)

# Use grep() to match for .edu addresses more robustly, save result to hits
hits <- grep("@.*\\.edu$", emails)

# Subset emails using hits
emails[hits]
   
          
          
          
##  .*: A usual suspect! It can be read as "any character that is matched zero or more times".
## \\s: Match a space. The "s" is normally a character, escaping it (\\) makes it a metacharacter.
## [0-9]+: Match the numbers 0 to 9, at least once (+).
## we([0-9]+): The parentheses are used to make parts of the matching string available to define the replacement. The \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+.

          
          
          
          
          
          ###########Dates and time
          
          # Definition of character strings representing times
str1 <- "May 23, '96 hours:23 minutes:01 seconds:45"
str2 <- "2012-3-12 14:23:08"

# Convert the strings to POSIXct objects: time1, time2
time1 <- as.POSIXct(str1, format = "%B %d, '%y hours:%H minutes:%M seconds:%S")
time2 <- as.POSIXct(str2, format = "%Y-%m-%d %H:%M:%S")

# Convert times to formatted strings
 format (time1,"%M")
format(time2, "%I:%M %p")
          
          
# day1, day2, day3, day4 and day5 are already available in the workspace

# Difference between last and first pizza day
day5 - day1

# Create vector pizza
pizza <- c(day1, day2, day3, day4, day5)

# Create differences between consecutive pizza days: day_diff
days_diff <- diff(pizza)

# Average period between two consecutive pizza days
mean(days_diff)
          
          
# Convert astro to vector of Date objects: astro_dates
astro_dates <- as.Date(astro,"%d-%b-%Y")
astro_dates
# Convert meteo to vector of Date objects: meteo_dates
meteo_dates <- as.Date(meteo,"%B %d, %y")
meteo_dates

# Calculate the maximum absolute difference between astro_dates and meteo_dates
max((abs(meteo_dates-astro_dates)))

          ############################################LOOP for further understanding
          
 # me, my_class and last_5 are preloaded

# Embedded control structure: fix the error
if (mean(my_class) < 75) {
  if (mean(my_class) > me) {
    print("average year, but still smarter than me")
  } else {
    print("average year, but I'm not that bad")
  }
} else {
  if (mean(my_class) > me) {
    print("smart year, even smarter than me")
  } else {
    print("smart year, but I am smarter")
  }
}
          
          
 ### This is interesting way to acess list files
 logs[[1]]$timestamp

          
          
          
# logs is available in your workspace

# Initialize the iterator i to be 1
i <- 1

# Code the while loop
while ( logs[[i]]$success == TRUE ) {
  print (i)
  i <- i+1
}
          
## use of loop function in R to get lis elements
# logs is available in your workspace

### for loop to extract timestamp; put this inside function body below
info <- c()
for (log in logs) {
 info <- c(info, log$timestamp)
}

# Build a function extract_info(): use for loop, add return statement
extract_info <- function(x) {
info <- c()
  for (log in x) {
    info <- c(info, log$timestamp)
  }
return (info)
}

# Call extract_info() on logs
extract_info(logs)

          
          
### use of multiple arguments in R to get informatio from list
# logs is available in your workspace

# Adapt the extract_info() function.
extract_info <- function(x, property) {
  info <- c()
  for (log in x) {
   info <- c(info, log[[property]])
  }
  return(info)
}

# Call extract_info() on logs, set property to "timestamp"
extract_info(logs, "timestamp")

# Call extract_info() on logs, set property to "success"
extract_info(logs, "success")
          
          
          
## setting a default values in function 
          
# logs is available in your workspace

# Add default value for property argument
extract_info <- function(x, property="success") {
  info <- c()
  for (log in x) {
   info <- c(info, log[[property]])
  }
  return(info)
}

# Call extract_info() on logs, don't specify property
extract_info (logs)

# Call extract_info() on logs, set property to "timestamp"
extract_info (logs, "timestamp")

          
          
 # logs is available in your workspace

# Adapt extract_info():
# - add argument with default value
# - change function body
extract_info <- function(x, property = "success", include_all=TRUE) {
  info <- c()
  for (log in x) { 

   # add if construct around the line below'
   if ((include_all) || (!log$success)){
     info <- c(info, log[[property]])
    }
  }
  return(info)
}

# Call extract_info() on logs, no additional arguments
extract_info(logs)

          
 ### this is such a cool way to extract informtion from  list elements suh that you can access elements fucha as from list of list
 ### 
 x <- list(a = 1, b = list(r = 2, s = 3))
x[[c("b", "r")]]
## Putting this in realization
          
# logs is available in your workspace

# Defition of the extract_info() function
extract_info <- function(x, property = "success", include_all = TRUE) {
  info <- c()
  for (log in x) {
    if (include_all || !log$success) {
     info <- c(info, log[[property]])
    }
  }
  return(info)
}

# Generate vector of messages
extract_info(logs, property = c("details", "message"))

# Generate vector of locations for failed log entries
extract_info(logs, property = c("details", "location"), include_all =FALSE)
          
          
          
          
## using of functions 
          
# logs is available in your workspace

# Write the function compute_fail_pct
compute_fail_pct <- function(x, property = "success", include_all=FALSE) {
  info <- c()
  for (log in x) { 

   # add if construct around the line below'
   if ((include_all) || (!log$success)){
     info <- c(info, log[[property]])
    }
  pct <- (length(info)/length(x)) *100
  }
  return(pct)
}


# Call compute_fail_pct on logs
compute_fail_pct(logs)
# Call extract_info() on logs, set include_all to FALSE
extract_info(logs, include_all=FALSE)
          
          
          
### Extra pracitse for apply function in R
# logs is available in your workspace

# Call length() on each element of logs
lapply(logs, length)

# Call class() on each element of logs
lapply(logs, class)
          
          
 # logs is available in your workspace

# Define get_timestamp()
get_timestamp <- function(x) {
  x$timestamp
}

# Apply get_timestamp() over all elements in logs
lapply(logs, get_timestamp)
 
          
          
 ## Anonymous function::
 ## for example defiining a function that gives two times of a 
  
 a <- list(3, 2, 5)
 lapply(a, function(x) { 2 * x })
  
## Anomyous function assignment
lapply(logs, function(x) {x$timestamp})

          
## The anomyous argument can also be passed as ´[[`can be used as function  
x <- list(a = 1, b = 2, c = 3)
x[["a"]]
`[[`(x, "a")
          
## this is equivalent to
lapply(logs, function(x) {`[[`(x, "timestamp")})
          
 ######### sapply function is used to get the vector matrices of same logs
 # logs is available in your workspace

# Call length() on each element of logs using sapply()
sapply(logs, length)

# Definition of get_timestamp
get_timestamp <- function(x) {
  x$timestamp
}

# Get vector of log entries' timestamps
sapply(logs, get_timestamp)
 
 ### using sapply in different scenarios
# logs is available in your workspace

# Use sapply() to select the success element from each log: results
results <- sapply(logs, function(x) {`[[`(x, "success")})

# Call mean() on results
mean(results)

# Use sapply() to select the details element from each log
 sapply(logs, function(x) {`[[`(x, "details")})
 ##### Use if sapply function with function making
  # logs is available in your workspace

# Implement function get_failure_loc
get_failure_loc <- function(x) {
  if (x$success == TRUE) {
    return(NULL)
  } else {
    return(x$details$location)
  }
}

# Use sapply() to call get_failure_loc on logs
sapply(logs, get_failure_loc)

## For many of the log entries, get_failure_loc() returns NULL, for others, it returns a character string. R does not know how to simplify a list with this information…
          

          
 ### vapply function in practise: a mild reminder in vapply--> it is the simplification of sapply. Howver, we have to ascertain the type of element to be supplied in vapply. --> doing like this would be the receipe: vapply(X, FUN, FUN.VALUE).. FUN.VALUE must be a template for the output FUN generates. You can use functions such as integer(), numeric(), character() and logical() to do this.
          
 # logs is available in your workspace

# Convert the sapply call to vapply
vapply(logs, length,integer(1))

# Convert the sapply call to vapply
vapply(logs, `[[`, "success",FUN.VALUE = logical(1))
          
 ############
 sapply(logs, `[[`, c("details", "message"))
  vapply(logs, `[[`, c("details", "message"), FUN.VALUE= character(1))

 sapply(logs, function(x) { x$details })
 lapply(logs, function(x) { x$details }) 
 
  ### output in upper letters
  # logs is available in your workspace

# Return vector with uppercase version of message elements in log entries
 toupper(vapply(logs, `[[`, c("details", "message"), FUN.VALUE= character(1)))
  
          
          
          
## using grepl function to get the logical vector

          # Extract the name column from titanic
pass_names <- titanic$Name

# Create the logical vectror is_man
is_man <- grepl(", Mr\\.", pass_names)

# Count the number of men
sum(is_man)

# Count number of men based on gender
sum(titanic$Sex == "male")

          
## using grep to find pattern
gsub("^.*, (.*?)\\..*$", "\\1", pass_names)
          
          
### Cool use of vapply with other utility function 
pass_names <- titanic$Name
titles <- paste(",", c("Mr\\.", "Master", "Don", "Rev", "Dr\\.", "Major", "Sir", "Col", "Capt", "Jonkheer"))

# Finish the vapply() command
hits <- vapply(titles,
               FUN = grepl,
               FUN.VALUE = logical(length(pass_names)),
               pass_names)

# Calculate the sum() of hits
sum (hits)

# Count number of men based on gender
sum(titanic$Sex == "male")
 
          
 ### Cool use of function with regular expression
 # pass_names is available in your workspace

convert_name <- function(name) {
  # women: take name from inside parentheses
  if (grepl("\\(.*?\\)", name)) {
    gsub("^.*?\\((.*?)\\)$", "\\1", name)
  # men: take name before comma and after title
  } else {
    # Finish the gsub() function
    gsub("^(.*?),\\s[a-zA-Z\\.]*?\\s(.*?)$", "\\2 \\1", name)
  }
}

# Call convert_name on name
clean_pass_names <- vapply(pass_names, FUN = convert_name,
                           FUN.VALUE = character(1), USE.NAMES = FALSE)

# Print out clean_pass_names
clean_pass_names

          
## Some more examples with utilities
# titanic, dob1 and dob2 are preloaded

# Have a look at head() of dob1 and dob2
head(dob1)
head(dob2)

# Convert dob1 to dob1d, convert dob2 to dob2d
dob1d <- as.Date(dob1, format ="%Y-%m-%d")
dob2d <- as.Date(dob2, format ="%B %d, %Y")

# Combine dob1d and dob2d into single vector: birth_dates
birth_dates <- c(dob1d,dob2d)

          
# titanic, dob1 and dob2 are preloaded
dob1d <- as.Date(dob1)
dob2d <- as.Date(dob2, format = "%B %d, %Y")
birth_dates <- c(dob1d, dob2d)
disaster_date <- as.Date("1912-04-15")

# Add birth_dates to titanic (column Birth)
titanic$Birth <- birth_dates

# Create subset: survivors
survivors <- subset(titanic, Survived == 1)

# Calculate average age of survivors
mean (disaster_date - survivors$Birth, na.rm=TRUE)
