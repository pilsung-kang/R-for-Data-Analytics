# 03-4 Handling Strings ----------------------------------------------

S <- "Welcome to Data Science!"
length(S)
nchar(S)

S1 <- "My name is"
S2 <- "Pilsung Kang"
paste(S1, S2)
paste(S1, S2, sep="-")
paste(S1, S2, sep="")

paste("The value of log10 is", log(10))

S1 <- c("My name is", "Your name is")
S2 <- c("Pilsung")
S3 <- c("Pilsung", "Younho", "Hakyeon")
paste(S1,S2)
paste(S1,S3)

stooges <- c("Dongmin", "Sangkyum", "Junhong")
paste(stooges, "loves", "R.")
paste(stooges, "loves", "R", collapse = ", and ")

substr("Data Science", 1, 4)
substr("Data Science", 6, 10)

stooges <- c("Dongmin", "Sangkyum", "Junhong")
substr(stooges, 1,3)

cities <- c("New York, NY", "Los Angeles, CA", "Peoria, IL")
substr(cities, nchar(cities)-1, nchar(cities))

path <- "C:/home/mike/data/trials.csv"
strsplit(path,"/")

path <- c("C:/home/mike/data/trials1.csv",
          "C:/home/mike/data/errors2.txt",
          "C:/home/mike/data/report3.doc")
strsplit(path,"/")

strsplit(path, "om")
strsplit(path, "[hm]")
strsplit(path, "i.e")
strsplit(path, "\\.")
strsplit(path, "r{2}")
strsplit(path, "[[:digit:]]")

tmpstring <- "Kim is stupid and Kang is stupid too"
sub("stupid", "smart", tmpstring)
gsub("stupid", "smart", tmpstring)

grep("mike", path)
grep("errors", path)
