install.packages("tm", dependencies = TRUE)
install.packages("wordcloud", dependencies = TRUE)
install.packages("arules", dependencies = TRUE)
install.packages("arulesViz", dependencies = TRUE)
install.packages("igraph", dependencies = TRUE)

library(tm)
library(wordcloud)
library(arules)
library(arulesViz)
library(igraph)

# Load the data
load("SpeechData.RData")

# 1. Wordcloud ----------------------------------------------------
# Transform the data into Obama and Romney
obama.idx <- which(SpeechData$Speaker == "Obama")
romney.idx <- which(SpeechData$Speaker == "Romney")

obama.speech <- SpeechData[obama.idx, 2]
romney.speech <- SpeechData[romney.idx, 2]

obama.speech <- paste(obama.speech, collapse = " ")
romney.speech <- paste(romney.speech, collapse = " ")

obama.sentence <- strsplit(obama.speech, ".", fixed = TRUE)
obama.sentence <- as.data.frame(obama.sentence, stringsAsFactors = FALSE)
names(obama.sentence) <- "sentence"

romney.sentence <- strsplit(romney.speech, ".", fixed = TRUE)
romney.sentence <- as.data.frame(romney.sentence, stringsAsFactors = FALSE)
names(romney.sentence) <- "sentence"

# Construct corpuses
# VectorSource specifies that the source is character vectors.
obamaCorpus <- Corpus(VectorSource(obama.sentence$sentence))
romneyCorpus <- Corpus(VectorSource(romney.sentence$sentence))

# Preprocessing
# 1: to lower case
obamaCorpus <- tm_map(obamaCorpus, content_transformer(tolower))
romneyCorpus <- tm_map(romneyCorpus, content_transformer(tolower))

# 2: remove puntuations
obamaCorpus <- tm_map(obamaCorpus, content_transformer(removePunctuation))
romneyCorpus <- tm_map(romneyCorpus, content_transformer(removePunctuation))

# 3. remove numbers
obamaCorpus <- tm_map(obamaCorpus, content_transformer(removeNumbers))
romneyCorpus <- tm_map(romneyCorpus, content_transformer(removeNumbers))

# 4. remove stopwords (SMART stopwords list)
myStopwords <- c(stopwords("SMART"), "american", "america")

obamaCorpus <- tm_map(obamaCorpus, removeWords, myStopwords)
romneyCorpus <- tm_map(romneyCorpus, removeWords, myStopwords)

# 5. Stemming
obamaCorpus <- tm_map(obamaCorpus, stemDocument)
romneyCorpus <- tm_map(romneyCorpus, stemDocument)

myStopwords <- c("american", "america")
obamaCorpus <- tm_map(obamaCorpus, removeWords, myStopwords)
romneyCorpus <- tm_map(romneyCorpus, removeWords, myStopwords)

# Term-Document Matrix
obamaTDM <- TermDocumentMatrix(obamaCorpus, control = list(minWordLength = 1))
romneyTDM <- TermDocumentMatrix(romneyCorpus, control = list(minWordLength = 1))

# Term-Document Matrix
obamaTDM
romneyTDM

as.matrix(obamaTDM)[11:30,11:30]
as.matrix(romneyTDM)[11:30,11:30]

# Frequently used words
findFreqTerms(obamaTDM, lowfreq=15)
findFreqTerms(romneyTDM, lowfreq=15)

# Construct a Word Cloud with Obama's speeches
obama.wcmat <- as.matrix(obamaTDM)

# calculate the frequency of words
obama.word.freq <- sort(rowSums(obama.wcmat), decreasing=TRUE)
obama.keywords <- names(obama.word.freq)
obama.wcdat <- data.frame(word = obama.keywords, freq = obama.word.freq)

pal <- brewer.pal(8, "Dark2")
wordcloud(obama.wcdat$word, obama.wcdat$freq, min.freq=3, scale = c(5, 0.1), 
          rot.per = 0.1, col=pal, random.order=F)

# Construct a Word Cloud with Romney's speeches
romney.wcmat <- as.matrix(romneyTDM)

# calculate the frequency of words
romney.word.freq <- sort(rowSums(romney.wcmat), decreasing=TRUE)
romney.keywords <- names(romney.word.freq)
romney.wcdat <- data.frame(word = romney.keywords, freq = romney.word.freq)

pal <- brewer.pal(8, "Dark2")
wordcloud(romney.wcdat$word, romney.wcdat$freq, min.freq=3, scale = c(5, 0.1), 
          rot.per = 0.1, col=pal, random.order=F)

# Association Rules for Obama Speeches
obama.tran <- as.matrix(t(obamaTDM))
obama.tran <- as(obama.tran, "transactions")

obama.rules <- apriori(obama.tran, parameter=list(minlen=2,supp=0.007, conf=0.7))
inspect(obama.rules)

# Plot the rules
plot(obama.rules, method="graph")

# Association Rules for Romney's speeches
romney.tran <- as.matrix(t(romneyTDM))
romney.tran <- as(romney.tran, "transactions")

romney.rules <- apriori(romney.tran, parameter=list(minlen=2,supp=0.0045, conf=0.7))
inspect(romney.rules)

# Plot the rules
plot(romney.rules, method="graph")
