## Object-oriented programming from Data Camp

#### Lecture -1  What is Objected - Oriented Programming(OOP)
Most of the data analysis so far has been dused for functional programming that means we use a function in adataset to get a new data which is further manipulated. However, in the object oriented programming thr focus is now shifted to how the complex objects are manipulated in progrmamming. The lecturere has tried to explain this concept using packages sucha as biocinductor where the main focus is representing limited genomic features, secondly with APIs such as webbased application such as facebook and twitter we want to created tool for better data visulaization , and lastly with shy application in R we can create a new we based application for the data.

Some application for OOP could be :
* Writing an interface to the Internet Movie Database API.
* Creating objects to work with cartographic data for spatial analysis

Thus, it can be said that OOP is suitable for workflows where you can describe a limited number of objects. In R if you consider vector, numeric, character, dataframe as objects then there are around 20 objects to work with.

See below an example of different objects that are made in R and also summary function works differently on these objects based on thier characterstics.
```R
# Create these variables
a_numeric_vector <- rlnorm(50)
a_factor <- factor(
  sample(c(LETTERS[1:5], NA), 50, replace = TRUE)
)
a_data_frame <- data.frame(
  n = a_numeric_vector,
  f = a_factor
)
a_linear_model <- lm(dist ~ speed, cars)

# Call summary() on the numeric vector
summary(a_numeric_vector)

# Do the same for the other three objects
summary(a_factor)
summary(a_data_frame)
summary(a_linear_model)
```

#### Lecture The nine system for OOP in R

In R actually there are 9 systems of which S3 is the most fundamental one R6 is advannced version and covers almost everything. But since I am workfing with genomics data S4 is also should be in my priority. Thus S3 and R6 should be your first choices. S4 and ReferenceClasses have niche uses too.

Important consideration :
class () gives us what type of data structure in R the data is--> used to determine kind of variable in R
typeof() what is the data made up of  --> occassional used to find the variable type in R

The following example is such a cool way to eplore function in list
```R
# Look at the definition of type_info()
type_info

# Create list of example variables
some_vars <- list(
  an_integer_vector = rpois(24, lambda = 5),
  a_numeric_vector = rbeta(24, shape1 = 1, shape2 = 1),
  an_integer_array = array(rbinom(24, size = 8, prob = 0.5), dim = c(2, 3, 4)),
  a_numeric_array = array(rweibull(24, shape = 1, scale = 1), dim = c(2, 3, 4)),
  a_data_frame = data.frame(int = rgeom(24, prob = 0.5), num = runif(24)),
  a_factor = factor(month.abb),
  a_formula = y ~ x,
  a_closure_function = mean,
  a_builtin_function = length,
  a_special_function = `if`
)

# Loop over some_vars calling type_info() on each element to explore them
lapply(some_vars, type_info)
```
class(), typeof(), mode(), and storage.mode() can take different values for the same variable type.

## Lecture 4 :Assigning Classes and Implicit Classes

Class can be changed with attribute assignation however typeof is intrinsic propterty and cannot be overridden and is fundamental property.
```R
class(x) <- "some_class"
# Assigning class in some object x in R
```
This is particularly useful for lists, since lists can be used to combine other variables into more complex variables. (Remember the Lego analogy: individual variables are like Lego pieces, and you can use lists to build whatever you like.)

Example below is nice visualization of how chess can be combined in list form and unlist to observe the number of pieces in chess

```R
# Explore the structure of chess
str(chess)

# Override the class of chess
class(chess) <- "chess_game"

# Is chess still a list?
is.list(chess)

# How many pieces are left on the board?
length(unlist(chess))

typeof(chess)
```

#### Creating a generic function with S3

Usually in R while creating function for OOP there are two types of function in practise namely, geenric function and method functin which have their own naming convenction. Generally preferred names for the function are based on Simple_sample_convention with the use of _ while in other case caseSpecificFunction are also in use.

The major receipe for creating a geenric function in R is
```R
an_s3_generic <- function(x, maybe = "some", other = "arguments", ...) {
  UseMethod("an_s3_generic")
}
```
The generic calls UseMethod() with its own name.

Then there is another type of function call, namely method function in S3 which has receipe as
```R
generic.class <- function(some, arguments, ...) {
  # Do something
}
```


Use of this receipe to find the elements of data.frame
```R
# View get_n_elements
get_n_elements

# Create a data.frame method for get_n_elements
get_n_elements.data.frame <- function(x, ...){
  nrow(x) * ncol(x)
}

# Call the method on the sleep dataset
n_elements_sleep <- get_n_elements.data.frame(sleep)

# View the result
n_elements_sleep

```
```R
# View pre-defined objects
ls.str()

# Create a default method for get_n_elements
get_n_elements.default <- function(x, ...){
  length(unlist(x))
}

# Call the method on the ability.cov dataset
n_elements_ability.cov <- get_n_elements.default(ability.cov)
```

#### Methodlogical thinking

In order to find generic functiona and their methodical counter part it is sually method() with some argument is enough,
```R
# Find methods for print
methods("print")
```

The methods() function can also find the number of methods available for variables with a given class.
In order to get the complete list type 
```R
 methods(class = "data.frame")
 methods(class = "lm")
 methods(class = "factor")
methods(class = "POSIXct")
```

#### S3 and primitive function
So the major point of the whole lecture is to give the impression that some of the function in R are written in C and called in C. These are called as primitive function and have their advantage of not being changed although some class i sassigned. One of the example of primitive function is  length which if not any class is called will invoke C function typeof to give the length,

"Straight from exercise:  Some core functionality of R is defined using primitive functions, which use a special technique for accessing C-code, for performance reasons. Examples of primitive functions include language elements, like if and for, operators like + and $, and mathematical functions like exp and sin. Primitive functions include S3 generics; the complete list of S3 primitive generics can be found using .S3PrimitiveGenerics."

see the usage of function exists that checks whether the data element is present of not.
```R
# View the structure of hair
str(hair)

# What primitive generics are available?
.S3PrimitiveGenerics

# Does length.hairstylist exist?
exists("length.hairstylist")

# What is the length of hair?
length(hair)
```

#### Lecture: Too much class

variables could have multiple classes. With decreasing specificity we can assign the class in the variables.  inherits function is used to check the class in variables. In making these function first, we have to define the generic class variables and then chain together in method using NextMethod("what_am_i") formulation.

"Striaght from exercise ; Variables can have more than one class. In this case, class() returns a character vector of length greater than one.

Likewise you can set multiple classes by assigning a character vector to class(). The classes should be ordered from more specific to more general as you move left to right, since you want to begin with the behavior most targetted to your object. For example:"
```R
x <- c("a", "e", "i", "o", "u")
class(x) <- c("vowels", "letters", "character")

### Checking for other variables
inherits(x, "vowels")
```
```R
# View the kitty
kitty

# Assign classes
class(kitty) <- c("cat", "mammal", "character")

# Does kitty inherit from cat/mammal/character vector?
inherits(kitty,"cat" )
inherits(kitty,"mammal" )
inherits(kitty, "character" )

# Is kitty a character vector?
is.character(kitty)

# Does kitty inherit from dog?
inherits(kitty, "dog")
```

When objects have multiple classes, you may wish to call methods for several of these classes. This is done using NextMethod().

The S3 methods now take the form:
```R
an_s3_method.some_class <- function(x, ...)
{
  # Act on some_class, then
  NextMethod("an_s3_method")
}
```


example of it
```R
# Inspect your workspace
ls.str()

# cat method
what_am_i.cat <- function(x, ...)
{
  message("I'm a cat")
  NextMethod("what_am_i")
}

# mammal method
what_am_i.mammal <- function(x, ...)
{
  message("I'm a mammal")
  NextMethod("what_am_i")
}

# character method
what_am_i.character <- function(x, ...)
{
  # Write a message
  message("I'm a character vector")
}

 what_am_i(kitty)
 
 ```
 
