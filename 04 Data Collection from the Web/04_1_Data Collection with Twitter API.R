# Case 1-1: Collect Texts using Twitter API ---------------------------------
install.packages("twitteR", "ROAuth", "RCurl", "streamR")
install.packages("rjson", "base64enc", "httr")

library(twitteR)
library(ROAuth)
library(RCurl)
library(streamR)
library(rjson)
library(base64enc)
library(httr)

consumer_key= "Your consumer_key"
consumer_secret= "Your consumer_secret"
access_token = "Your access_token"
access_secret = "Your access_secret"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

# Retrieve the first 100 tweets (or all tweets if fewer than 100)
# from the user timeline of @IBMWatson
WatsonTweets <- userTimeline("IBMWatson", n=100)
WatsonTweets[1:10]

# search research for the hashtag #AlphaGo
AlphaGoTweets <- searchTwitter("#AlphaGo", n=100)
AlphaGoTweets[1:10]

# search research for the hashtag #AlphaGo with time constraints
AlphaGoTweets2 <- searchTwitter("#AlphaGo", n=1000, 
                           since = '2017-08-01', until = '2017-08-17')
AlphaGoTweets2[1:10]

# Twitter stream data collection
download.file(url="http://curl.haxx.se/ca/cacert.pem", destfile="cacert.pem")

reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
apiKey <- "Your apiKey"
apiSecret <- "Your apiSecret"

twitCred <- OAuthFactory$new(consumerKey=apiKey, consumerSecret=apiSecret, 
                             requestURL=reqURL, accessURL=accessURL, authURL=authURL)

twitCred$handshake(cainfo ="cacert.pem")

filterStream(file="AI.json", track="Artificial Intelligence", language = "en", timeout=30, oauth=twitCred)

readFile <- file("AI.json", "r")
streamTweets <- readLines(readFile, -1L)

dfMentions <- data.frame()

for (i in 1:length(streamTweets)){
  dfMentions <- rbind(dfMentions, as.data.frame(fromJSON(streamTweets[i])$text))
}
