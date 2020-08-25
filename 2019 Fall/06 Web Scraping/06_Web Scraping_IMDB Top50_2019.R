# Part 3: Web Scraping (IMDB Top 50 Movies) -----------------------------------------
install.packages("dplyr")
install.packages("stringr")
install.packages("httr")
install.packages("rvest")

library(dplyr)
library(stringr)
library(httr)
library(rvest)

url <- 'https://www.imdb.com/search/title/?groups=top_250&sort=user_rating'

start <- proc.time()
imdb_top_50 <- data.frame()
cnt <- 1

tmp_list <- read_html(url) %>% html_nodes('h3.lister-item-header') %>% 
  html_nodes('a[href^="/title"]') %>% html_attr('href')

for( i in 1:50){
  
  tmp_url <- paste('http://imdb.com', tmp_list[i], sep="")
  tmp_content <- read_html(tmp_url)
  
  # Extract title and year
  title_year <- tmp_content %>% html_nodes('div.title_wrapper > h1') %>% html_text %>% str_trim
  tmp_title <- substr(title_year, 1, nchar(title_year)-7)
  tmp_year <- substr(title_year, nchar(title_year)-4, nchar(title_year)-1)
  tmp_year <- as.numeric(tmp_year)
  
  # Average rating
  tmp_rating <- tmp_content %>% html_nodes('div.ratingValue > strong > span') %>% html_text
  tmp_rating <- as.numeric(tmp_rating)
  
  # Rating counts
  tmp_count <- tmp_content %>% html_nodes('span.small') %>% html_text
  tmp_count <- gsub(",", "", tmp_count)
  tmp_count <- as.numeric(tmp_count)
  
  # Summary
  tmp_summary <- tmp_content %>% html_nodes('div.summary_text') %>% html_text %>% str_trim
   
  # Director, Writers, and Stars
  tmp_dws <- tmp_content %>% html_nodes('div.credit_summary_item') %>% html_text
  tmp_director <- tmp_dws[1] %>% str_trim
  tmp_director <- sub("Director:\n", "", tmp_director)
  
  tmp_writer <- tmp_dws[2] %>% str_trim
  tmp_writer <- sub("Writers:\n", "", tmp_writer)
  
  tmp_stars <- tmp_dws[3] %>% str_trim
  tmp_stars <- strsplit(tmp_stars, "\nSee")[[1]][1]
  tmp_stars <- sub("Stars:\n", "", tmp_stars)
  tmp_stars <- substr(tmp_stars, 1, nchar(tmp_stars)-1) %>% str_trim
  
  # Extract the first 25 reviews
  title_id <- strsplit(tmp_list[i], "/")[[1]][3]
  review_url <- paste("https://www.imdb.com/title/", title_id, "/reviews?ref_=tt_urv", sep="")
  tmp_review <- read_html(review_url) %>% html_nodes('div.review-container')
  
  
  for(j in 1:25){
    
    cat("Scraping the", j, "-th review of the", i, "-th movie. \n")
    
    tryCatch({
      
      # Review rating 
      tmp_info <- tmp_review[j] %>% html_nodes('span.rating-other-user-rating > span') %>% html_text
      tmp_review_rating <- as.numeric(tmp_info[1])
      
      # Review title
      tmp_review_title <- tmp_review[j] %>% html_nodes('a.title') %>% html_text
      tmp_review_title <- tmp_review_title %>% str_trim
      
      # Review text
      tmp_review_text <- tmp_review[j] %>% html_nodes('div.text.show-more__control') %>% html_text
      tmp_review_text <- gsub("\\s+", " ", tmp_review_text)
      tmp_review_text <- gsub("\"", "", tmp_review_text) %>% str_trim
      
      # Store the results
      imdb_top_50[cnt,1] <- tmp_title
      imdb_top_50[cnt,2] <- tmp_year
      imdb_top_50[cnt,3] <- tmp_rating
      imdb_top_50[cnt,4] <- tmp_count
      imdb_top_50[cnt,5] <- tmp_summary
      imdb_top_50[cnt,6] <- tmp_director
      imdb_top_50[cnt,7] <- tmp_writer
      imdb_top_50[cnt,8] <- tmp_stars
      imdb_top_50[cnt,9] <- tmp_review_rating
      imdb_top_50[cnt,10] <- tmp_review_title
      imdb_top_50[cnt,11] <- tmp_review_text
      
      cnt <- cnt+1
      }, error = function(e){print("An error occurs, skip the review")})
    }
  Sys.sleep(1) # Pretending not a bot
}

names(imdb_top_50) <- c("Title", "Year", "Avg.Rating", "RatingCounts", "Summary", "Director",
                        "Writer", "Stars", "Review.Rating", "Review.Title", "Review.Text")

end <- proc.time()
end - start # Total Elapsed Time

# Export the result
save(imdb_top_50, file = "imdb_top_50.RData")
write.csv(imdb_top_50 , file = "imdb_top_50.csv")

