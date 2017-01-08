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
