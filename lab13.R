# 문제1
library(KoNLP)
word_data <- readLines("output/movie_reviews3.csv")
word_data <- sort(word_data, decreasing = T)
word_data <-gsub("[[:digit:]]|[[:punct:]] ", "", word_data)
word_data <-gsub("[A-Za-z]", "", word_data)
word_data <-gsub("[ㄱ-ㅎ|ㅏ-ㅣ]", "", word_data)
word_Noun <- extractNoun(word_data)
undata <- unlist(word_Noun)
word_table <- table(undata)
word_table <- sort(word_table, decreasing = T)
top_word <- head(word_table, 10)
imsi <- data.frame(top_word)
wname <- imsi$undata
wcount <- imsi$Freq
result <- data.frame(wname, wcount)

write.csv(result, "output/movie_top_word.csv")



# 문제2
library(wordcloud2)
yes_data <- readLines("output/yes24.txt")
yes_data <-gsub("[^가-힣]", " ", yes_data)

yes_noun <- extractNoun(yes_data)

undata <- unlist(yes_noun)

undata2 <- Filter(function(x) {nchar(x) >= 2}, undata)
undata2 <- Filter(function(x) {nchar(x) <= 4}, undata2)
word_table <- table(undata2)
word_table <- sort(word_table, decreasing = T)
data.frame(word_table)

result <- wordcloud2(word_table, fontFamily = "휴먼옛체")

htmltools::save_html(result,"output/yes24.html")