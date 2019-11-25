install.packages("textstem")
install.packages("tm")
install.packages("wordcloud")
install.packages("plyr")
install.packages("igraph")
install.packages("treemap")

library(textstem)
library(tm)
library(wordcloud)
library(plyr)
library(igraph)
library(dplyr)
library(treemap)

load("arxiv_NLP.RData")
load("arxiv_Image_Processing.RData")

nlp_papers <- paste(arxiv_nlp$title, arxiv_nlp$abstract)
nlp_papers[1]

image_papers <- paste(arxiv_image_processing$title, arxiv_image_processing$abstract)
image_papers[1]

# Remove invalid characters
nlp_papers <- sapply(nlp_papers,function(row) iconv(row, "latin1", "ASCII", sub=""))
image_papers <- sapply(image_papers,function(row) iconv(row, "latin1", "ASCII", sub=""))

nlp_lemma <- NULL
image_lemma <- NULL

# Lemmatization
for (i in 1:length(nlp_papers)){
  
  cat("Lemmatizing", i, "-th paper. \n")
  nlp_lemma[i] <- lemmatize_strings(nlp_papers[i])
  
}

for (j in 1:length(image_papers)){
  
  cat("Lemmatizing", j, "-th paper. \n")
  image_lemma[j] <- lemmatize_strings(image_papers[j])
  
}

# Construct a corpus
# VectorSource specifies that the source is character vectors.
nlp_corpus <- Corpus(VectorSource(nlp_lemma))
nlp_corpus[[1]][1]

image_corpus <- Corpus(VectorSource(image_lemma))
image_corpus[[1]][1]

# Data preprocessing
# 1: to lower case
nlp_corpus <- tm_map(nlp_corpus, content_transformer(tolower))
nlp_corpus[[1]][1]

image_corpus <- tm_map(image_corpus, content_transformer(tolower))
image_corpus[[1]][1]

# 2: remove puntuations
nlp_corpus <- tm_map(nlp_corpus, content_transformer(removePunctuation))
nlp_corpus[[1]][1]

image_corpus <- tm_map(image_corpus, content_transformer(removePunctuation))
image_corpus[[1]][1]

# 3. remove numbers
nlp_corpus <- tm_map(nlp_corpus, content_transformer(removeNumbers))
nlp_corpus[[5]][1]

image_corpus <- tm_map(image_corpus, content_transformer(removeNumbers))
image_corpus[[1]][1]

# 4. remove stopwords (SMART stopwords list)
arxiv_stopwords <- c("process", "paper", "model", "learn", "propose", "task", "method",
                     "show", "approach", "result", "system")
myStopwords <- c(stopwords("SMART"), arxiv_stopwords)

nlp_corpus <- tm_map(nlp_corpus, removeWords, myStopwords)
nlp_corpus[[1]][1]

image_corpus <- tm_map(image_corpus, removeWords, myStopwords)
image_corpus[[1]][1]

# Construct Term-Document Matrix
nlpTDM <- TermDocumentMatrix(nlp_corpus, control = list(minWordLength = 2))
imageTDM <- TermDocumentMatrix(image_corpus, control = list(minWordLength = 2))

# Check the Term-Document Matrix
as.matrix(nlpTDM)[11:30,11:30]
as.matrix(imageTDM)[11:30,11:30]

# High frequent words
nlpTDM_matrix <- as.matrix(nlpTDM)
nlp_word_count <- rowSums(nlpTDM_matrix)
nlp_word_count <- sort(nlp_word_count, decreasing = TRUE)
nlp_word_count[1:30]

imageTDM_matrix <- as.matrix(imageTDM)
image_word_count <- rowSums(imageTDM_matrix)
image_word_count <- sort(image_word_count, decreasing = TRUE)
image_word_count[1:30]

nlp_freq_words <- findFreqTerms(nlpTDM, lowfreq=100)
image_freq_words <- findFreqTerms(imageTDM, lowfreq=100)

intersect(nlp_freq_words, image_freq_words)
setdiff(nlp_freq_words, image_freq_words)
setdiff(image_freq_words, nlp_freq_words)

# Which words are associated with "image"?
findAssocs(nlpTDM, 'image', 0.2)
findAssocs(imageTDM, 'image', 0.2)

# Word cloud
pal <- brewer.pal(12, "Paired")
wordcloud(names(nlp_word_count)[1:200], nlp_word_count[1:200], min.freq=10, scale = c(3, 1), 
          rot.per = 0.1, col=pal, random.order=F)

pal <- brewer.pal(12, "Paired")
wordcloud(names(image_word_count)[1:200], image_word_count[1:200], min.freq=10, scale = c(3, 1), 
          rot.per = 0.1, col=pal, random.order=F)

# Treemap
nlp_treemap_data <- data.frame(names(nlp_word_count), nlp_word_count, nchar(names(nlp_word_count)))
names(nlp_treemap_data) <- c("word", "frequency", "nchar")
str(nlp_treemap_data)

treemap(nlp_treemap_data[1:200,], index = "word", vSize = "frequency", vColor = "nchar", 
        type = "value", palette = brewer.pal(12, "Paired"))

# Treemap
image_treemap_data <- data.frame(names(image_word_count), image_word_count, nchar(names(image_word_count)))
names(image_treemap_data) <- c("word", "frequency", "nchar")
str(image_treemap_data)

treemap(image_treemap_data[1:200,], index = "word", vSize = "frequency", vColor = "nchar", 
        type = "value", palette = brewer.pal(12, "Set3"))

# Construct a word network for the nlp papers
# Change it to a Boolean matrix
nlpTDM_matrix[nlpTDM_matrix >= 1] <- 1
nlp_adj_mat <- nlpTDM_matrix %*% t(nlpTDM_matrix)

# inspect terms numbered 1 to 10
nlp_adj_mat[1:10,1:10]

# Build a graph from the above matrix
nlp_graph <- graph.adjacency(nlp_adj_mat, weighted=T, mode = "undirected")

# remove loops
nlp_graph <- simplify(nlp_graph)

# set labels and degrees of vertices
V(nlp_graph)$label <- V(nlp_graph)$name
nlp_graph <- delete.edges(nlp_graph, which(E(nlp_graph)$weight <= 50))
nlp_graph <- delete.vertices(nlp_graph, which(degree(nlp_graph) == 0))
V(nlp_graph)$degree <- degree(nlp_graph)

# set seed to make the layout reproducible
set.seed(3952)
plot(nlp_graph, layout=layout.fruchterman.reingold)
plot(nlp_graph, layout=layout.kamada.kawai, vertex.size = 10, vertex.color = 8, vertex.label.cex = 1)

# Make the network look better
V(nlp_graph)$label.cex <- 2*V(nlp_graph)$degree/max(V(nlp_graph)$degree)+1
V(nlp_graph)$label.color <- rgb(0, 0, 0.2, 0.8)
V(nlp_graph)$frame.color <- NA
egam1 <- 300*(exp(E(nlp_graph)$weight/100))/sum(exp(E(nlp_graph)$weight/100))
E(nlp_graph)$color <- rgb(0.5, 0.5, 0)
E(nlp_graph)$width <- egam1

# plot the graph in layout1
plot(nlp_graph, layout=layout.kamada.kawai)

nlp_community <- walktrap.community(nlp_graph, steps = 3)
modularity(nlp_community)
membership(nlp_community)
plot(nlp_community, nlp_graph)

# Construct a word network for the image papers
# Change it to a Boolean matrix
imageTDM_matrix[imageTDM_matrix >= 1] <- 1
image_adj_mat <- imageTDM_matrix %*% t(imageTDM_matrix)

# inspect terms numbered 1 to 10
image_adj_mat[1:10,1:10]

# Build a graph from the above matrix
image_graph <- graph.adjacency(image_adj_mat, weighted=T, mode = "undirected")

# remove loops
image_graph <- simplify(image_graph)

# set labels and degrees of vertices
V(image_graph)$label <- V(image_graph)$name
image_graph <- delete.edges(image_graph, which(E(image_graph)$weight <= 50))
image_graph <- delete.vertices(image_graph, which(degree(image_graph) == 0))
V(image_graph)$degree <- degree(image_graph)

# set seed to make the layout reproducible
set.seed(3952)
plot(image_graph, layout=layout.fruchterman.reingold)
plot(image_graph, layout=layout.kamada.kawai, vertex.size = 10, vertex.color = 8, vertex.label.cex = 1)

# Make the network look better
V(image_graph)$label.cex <- 2*V(image_graph)$degree/max(V(image_graph)$degree)+1
V(image_graph)$label.color <- rgb(0, 0, 0.2, 0.8)
V(image_graph)$frame.color <- NA
egam2 <- 300*(exp(E(image_graph)$weight/100))/sum(exp(E(image_graph)$weight/100))
E(image_graph)$color <- rgb(0.5, 0.5, 0)
E(image_graph)$width <- egam2

# plot the graph in layout1
plot(image_graph, layout=layout.kamada.kawai)

image_community <- walktrap.community(image_graph, steps = 3)
modularity(image_community)
membership(image_community)
plot(image_community, image_graph)
