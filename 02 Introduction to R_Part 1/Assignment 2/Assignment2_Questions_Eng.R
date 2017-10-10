# Fill the blank (marked with ???) based on the instruction.

# Question 1  
# 1-1)
# Create the vector v1 as follows:
# the first element is 2
# each element is increased by 2
# the total number of element is 10
v1 <- seq(from=???,???=10,by=3)
print(v1)

# 1-2) 
# Create the vector v3 by selecting the elements greater than 20 from the vector 2
v2 <- c(10,2,6,4,11,92,67,23,20,15,28,39,17) 
v3 <- v2[???(v2>20)]
print(v3)

# 1-3) 
# Creat an empty matrix C with the following size
# colume size: the length of v1
# row size: 2
C <- ???(nrow = 2, ncol = ???(v1))
print(C)

# 1-4) 
# Assign the values of v1 to the first row of C
# Assign the values of v3 to the thrid row of C
# Caution!: Leave the NAs
# Compute the average of all elements of C
C[???] <- v1
C[???] <- v3
mean(???)
print(C)

# 1-5) 
# Conduct the matrix multiplication of the following matrices
# First matrix: Submatrix of C with all rows and the first five columns
# Second matrix: the following matrix D
set.seed(12345)
D <- matrix(sample(1:30,10,replace = FALSE),nrow = 5, ncol = 2)
# Create the matrix E by concatenating the matrix D 
# and the result of the above matrix multiplication using rbind() function
E <- rbind(D,???)
# Change the column name of E to "var1" and "var2" and print E
???(E) <- c(???)
print(E)

# Question 2
# data import
DSBA <- read.csv("DSBA.csv",header=TRUE,sep=",",stringsAsFactors = FALSE)

# 2-1) 
# Split the initial into the first character(family name) and the remaining two charaters (given name)
familyname_initial <- ???(DSBA$initial,???,???)
givenname_initial <- ???(DSBA$initial,???,???)
# Remove the initial variable
# Add the following variables
# variable 1: familyname_initial
# variable 2: givenname_initial
# variable 3 ~ :other variables in the original dataset
DSBA <- ???(familyname_initial,???,???)
print(DSBA)

# 2-2) 
# Create the table that counts the members according to the gender and age
tab <- ???(DSBA$course,???)
print(tab)

# 2-3) 
# Convert the type of "familyname_initial" variable to factor type
DSBA$familyname_initial <- ???(???)
print(DSBA$familyname_initial)

# 2-4) 
# Convert the type of "age" variable to factor type
DSBA$age <- as.factor(???)
print(DSBA$age)

# 2-5) 
# Conver the type of "age" variable to numeric type again
# See what happens if you convert the numeric to factor and convert it to numeric again
DSBA$age <- as.numeric(???)
print(DSBA)

# Question 3
#data import
data("iris")

# 3-1) 
# Compute the average of "Sepal.Length" for each species
mean_of_species <- ???(iris$Sepal.Length,???,???)
print(mean_of_species)

# 3-2) 
# Find the indices of observations whose "Sepal.Length" value is greater than 
# the average value of the same species
idx_setosa <- ???(??? & ???)
idx_versicolor <- ???(??? & ???)
idx_virginica <- ???(??? & ???)
# Create a new dataframe named "iris_new" with the selected indices
# Set the row names of iris_new dataframe to the current observation order
iris_new <- iris[???]
rownames(iris_new) <- ???:???
print(iris_new)

# 3-3) 
# Add one row below the iris_new dataset
# The elements of the new row are the average value of each variable
# Set the average of the variable "Species" to NA
# Assign "mean" to the name of the last row
mean_of_variables <- c(???,NA)
iris_new <- ???(???)
???(iris_new)[???] <- "mean"
print(iris_new)

# 3-4) 
# Find the indices that satisfy the following condiditon
# The value of "Petal.Length" is greater than 1.5*(average of Petal.Length)
idx <- which(???)
print(idx)

