# Install necessary packages
install.packages("tm", dependencies = TRUE)
install.packages("wordcloud", dependencies = TRUE)
install.packages("plyr", dependencies = TRUE)
install.packages("igraph", dependencies = TRUE)

library(tm)
library(wordcloud)
library(plyr)
library(igraph)

# Load the dataset
ObamaSpeech <- read.csv("speechBylineTable_utf8.csv", stringsAsFactors = FALSE)

# Select the first five speeches
idx1 <- which(ObamaSpeech$idx <= 5)
Speech1 <-as.data.frame(ObamaSpeech$contents[idx1])
names(Speech1) <- "sentence"

# Select the last five speeches
idx2 <- which(ObamaSpeech$idx > 97)
Speech2 <-as.data.frame(ObamaSpeech$contents[idx2])
names(Speech2) <- "sentence"

# Construct a corpus
# VectorSource specifies that the source is character vectors.
myCorpus1 <- Corpus(VectorSource(Speech1$sentence))
myCorpus1[[1]][1]

myCorpus2 <- Corpus(VectorSource(Speech2$sentence))
myCorpus2[[1]][1]

# Data preprocessing
# 1: to lower case
myCorpus1 <- tm_map(myCorpus1, content_transformer(tolower))
myCorpus1[[1]][1]

myCorpus2 <- tm_map(myCorpus2, content_transformer(tolower))
myCorpus2[[1]][1]

# 2: remove puntuations
myCorpus1 <- tm_map(myCorpus1, content_transformer(removePunctuation))
myCorpus1[[1]][1]

myCorpus2 <- tm_map(myCorpus2, content_transformer(removePunctuation))
myCorpus2[[1]][1]

# 3. remove numbers
myCorpus1 <- tm_map(myCorpus1, content_transformer(removeNumbers))
myCorpus1[[1]][1]

myCorpus2 <- tm_map(myCorpus2, content_transformer(removeNumbers))
myCorpus2[[1]][1]

# 4. remove stopwords (SMART stopwords list)
# Add "obama" to the stopwords list
myStopwords <- c(stopwords("SMART"), "obama")

myCorpus1 <- tm_map(myCorpus1, removeWords, myStopwords)
myCorpus1[[1]][1]

myCorpus2 <- tm_map(myCorpus2, removeWords, myStopwords)
myCorpus2[[1]][1]

# 5. Stemming
stemCorpus1 <- tm_map(myCorpus1, stemDocument)
myCorpus1[[1]][1]

stemCorpus2 <- tm_map(myCorpus2, stemDocument)
myCorpus2[[1]][1]

# Construct Term-Document Matrix
myTDM1 <- TermDocumentMatrix(stemCorpus1, control = list(minWordLength = 1))
myTDM2 <- TermDocumentMatrix(stemCorpus2, control = list(minWordLength = 1))

# Check the Term-Document Matrix
myTDM1
myTDM2

as.matrix(myTDM1)[11:30,11:30]
as.matrix(myTDM2)[11:30,11:30]

# High frequent words
findFreqTerms(myTDM1, lowfreq=15)
findFreqTerms(myTDM2, lowfreq=15)

# Which words are associated with "freedom"?
findAssocs(myTDM1, 'freedom', 0.35)
findAssocs(myTDM2, 'freedom', 0.35)

# Which words are associated with "american"?
findAssocs(myTDM1, 'america', 0.3)
findAssocs(myTDM2, 'america', 0.3)

# Construct a Word Cloud for the first 5 speeches
wcmat1 <- as.matrix(myTDM1)

# calculate the frequency of words
word_freq1 <- sort(rowSums(wcmat1), decreasing=TRUE)
myNames1 <- names(word_freq1)
wcdat1 <- data.frame(word=myNames1, freq=word_freq1)

pal <- brewer.pal(8, "Dark2")
wordcloud(wcdat1$word, wcdat1$freq, min.freq=3, scale = c(5, 0.1), 
          rot.per = 0.1, col=pal, random.order=F)

# Construct a Word Cloud for the last 5 speeches
wcmat2 <- as.matrix(myTDM2)
word_freq2 <- sort(rowSums(wcmat2), decreasing=TRUE)
myNames2 <- names(word_freq2)
wcdat2 <- data.frame(word=myNames2, freq=word_freq2)

pal <- brewer.pal(8, "Dark2")
wordcloud(wcdat2$word, wcdat2$freq, min.freq=3, scale = c(5, 0.1), 
          rot.per = 0.1, col=pal, random.order=F)

# Construct a word network for the first five speeches
# Change it to a Boolean matrix
wcmat1[wcmat1 >= 1] <- 1

# find the words that are used more than 15 times
freq_idx1 <- which(rowSums(wcmat1) > 15)
freq_wcmat1 <- wcmat1[freq_idx1,]

# Transform into a term-term adjacency matrix
termMatrix1 <- freq_wcmat1 %*% t(freq_wcmat1)
# inspect terms numbered 5 to 10
termMatrix1[1:10,5:10]

# Build a graph from the above matrix
g1 <- graph.adjacency(termMatrix1, weighted=T, mode = "undirected")
# remove loops
g1 <- simplify(g1)
# set labels and degrees of vertices
V(g1)$label <- V(g1)$name
V(g1)$degree <- degree(g1)
g1 <- delete.edges(g1, which(E(g1)$weight <= 3))

# set seed to make the layout reproducible
set.seed(3952)
layout1 <- layout.fruchterman.reingold(g1)
plot(g1, layout=layout1)
# Another layout
plot(g1, layout=layout.kamada.kawai)

# Make the network look better
V(g1)$label.cex <- 2*V(g1)$degree/max(V(g1)$degree)+0.2
V(g1)$label.color <- rgb(0, 0, 0.2, 0.8)
V(g1)$frame.color <- NA
egam1 <- 3*(log(E(g1)$weight+1))/max(log(E(g1)$weight+1))
E(g1)$color <- rgb(0.5, 0.5, 0)
E(g1)$width <- egam1
# plot the graph in layout1
plot(g1, layout=layout.kamada.kawai)

# Construct a word network for the last five speeches
# Change it to a Boolean matrix
wcmat2[wcmat2 >= 1] <- 1
# find the words that are used more than 15 times
freq_idx2 <- which(rowSums(wcmat2) > 10)
freq_wcmat2 <- wcmat1[freq_idx2,]

# Transform into a term-term adjacency matrix
termMatrix2 <- freq_wcmat2 %*% t(freq_wcmat2)
# inspect terms numbered 5 to 10
termMatrix2[1:10,5:10]

# Build a graph from the above matrix
g2 <- graph.adjacency(termMatrix2, weighted=T, mode = "undirected")
# remove loops
g2 <- simplify(g2)
# set labels and degrees of vertices
V(g2)$label <- V(g2)$name
V(g2)$degree <- degree(g2)

# set seed to make the layout reproducible
set.seed(3952)
layout2 <- layout.fruchterman.reingold(g2)
plot(g2, layout=layout2)
# Another layout
plot(g2, layout=layout.kamada.kawai)

# Make the network look better
V(g2)$label.cex <- 2*V(g2)$degree/max(V(g2)$degree)+1
V(g2)$label.color <- rgb(0, 0, 0.2, 0.8)
V(g2)$frame.color <- NA
egam2 <- E(g2)$weight/max(E(g2)$weight)
E(g2)$color <- rgb(0.5, 0.5, 0)
E(g2)$width <- egam2
# plot the graph in layout1
plot(g2, layout=layout.kamada.kawai)
