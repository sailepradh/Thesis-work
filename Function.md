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


