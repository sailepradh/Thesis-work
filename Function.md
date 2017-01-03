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
``` R
# 2nd element in tricky_list
typeof(tricky_list [[2]])

# Element called x in tricky_list
typeof((tricky_list [["x"]]))

# 2nd element inside the element called x in tricky_list
typeof(tricky_list [["x"]] [[2]]```
  
