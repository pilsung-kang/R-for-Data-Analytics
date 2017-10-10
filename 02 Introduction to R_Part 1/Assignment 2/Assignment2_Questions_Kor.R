# ??? 부분이 빈칸입니다.

# Question 1  
# 1-1) 초항이 2이고 공차가 3인 등차수열의 첫번째 원소부터 10번째 원소까지의 값을 
# element로 갖는 벡터 v1을 만드시오.

v1 <- seq(from=???,???=10,by=3)
print(v1)


# 1-2) 벡터 v2에서 20보다 큰 값을 element로 갖는 벡터 v3를 만드시오.

v2 <- c(10,2,6,4,11,92,67,23,20,15,28,39,17) 
v3 <- v2[???(v2>20)]
print(v3)

# 1-3) v1의 길이를 column 갯수로, 2를 row 갯수로 갖는 빈 matrix C를 만드시오.
C <- ???(nrow = 2, ncol = ???(v1))
print(C)

# 1-4) C의 첫번째 row가 v1값을, 두번째 row가 v3값을 갖게 하시오 (주의 : NA값은 남겨 놓으시오). 
# C의 모든 원소의 평균을 구하시오.
C[???] <- v1
C[???] <- v3
mean(???)
print(C)

# 1-5) C의 5번째 column 까지의 값을 갖는 행렬과 아래의 행렬 D와의 
# matrix multiplication을 수행한 행렬을 matrix D 밑에 붙인 행렬 E를 구하시오.
# 행렬 E의 column name을 var1, var2로 바꾸고 E를 출력하시오.
set.seed(12345)
D <- matrix(sample(1:30,10,replace = FALSE),nrow = 5, ncol = 2)

E <- rbind(D,???)
???(E) <- c(???)
print(E)

# Question 2
# data import
DSBA <- read.csv("DSBA.csv",header=TRUE,sep=",",stringsAsFactors = FALSE)

# 2-1) initial로부터 성과 이름을 분리한 후(맨 앞이 성, 뒤에가 이름 initial) initial 
# 변수를 제거한 뒤 성과 이름의 initial 변수를 추가하시오.
# 순서는 성, 이름, 나머지 변수들 순으로
familyname_initial <- ???(DSBA$initial,???,???)
givenname_initial <- ???(DSBA$initial,???,???)
DSBA <- ???(familyname_initial,???,???)
print(DSBA)

# 2-2) 성별과 course에 따른 count를 산출하는 표를 추출하시오.
tab <- ???(DSBA$course,???)
print(tab)

# 2-3) familyname_initial 변수를 factor로 변환하시오.
DSBA$familyname_initial <- ???(???)
print(DSBA$familyname_initial)

# 2-4) age 변수를 factor로 변환하시오.
DSBA$age <- as.factor(???)
print(DSBA$age)

# 2-5) factor로 변환한 age 변수를 다시 numeric 으로 변환하시오.
DSBA$age <- as.numeric(???)
print(DSBA)

# Question 3
#data import
data("iris")

# 3-1) iris data의 각 Species별 Sepal.Length의 평균을 구하시오
mean_of_species <- ???(iris$Sepal.Length,???,???)
print(mean_of_species)

# 3-2) Species별로 Species의 평균 Sepal.Length보다 큰 index를 추출하여 
# 새로운 data frame iris_new를 생성하시오.(for문 사용하지 말고)
# iris_new data frame의 row 이름을 관측치 순서로 재설정하시오.
idx_setosa <- ???(??? & ???)
idx_versicolor <- ???(??? & ???)
idx_virginica <- ???(??? & ???)

iris_new <- iris[???]
rownames(iris_new) <- ???:???
print(iris_new)

# 3-3) iris_new data의 가장 마지막 row에 각 변수별 평균값을 추가하고 
# row의 이름을 mean으로 바꾸시오.(Species column의 평균은 NA로 지정하시오)
mean_of_variables <- c(???,NA)
iris_new <- ???(???)
???(iris_new)[???] <- "mean"
print(iris_new)

# 3-4) iris_new dataframe에서 Petal.Length가 평균의 1.5배보다 큰 observation들의 index를 추출하시오
idx <- which(???)
print(idx)

