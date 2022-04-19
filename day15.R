# wide format 과 long format
install.packages("tidyr")
install.packages("dplyr")

library(tidyr)
library(dplyr)

gap_wide <- read.csv("data/gapminder_wide.csv", stringsAsFactors = FALSE)
str(gap_wide)
View(gap_wide)

gap_long1 <- gap_wide %>%
  gather(obstype_year, obs_values, starts_with('pop'),
         starts_with('lifeExp'), starts_with('gdpPercap'))
str(gap_long1)
View(gap_long1)

gap_long2 <- gap_wide %>% gather(obstype_year,obs_values,-continent,-country)
str(gap_long2)
View(gap_long2)

gap_long3 <- gap_long1 %>% separate(obstype_year,into=c('obs_type','year'),sep="_")
gap_long3$year <- as.integer(gap_long3$year)
str(gap_long3)
View(gap_long3)

# [문제1]
# gap_long3를 사용해서, 각 대륙별로 평균 기대수명, 인구, 1인당 GDP를 계산한다.

gap_long3 %>% group_by(continent,obs_type) %>%
  summarize(means=mean(obs_values))






View(mtcars)
mtcars$name = rownames(mtcars)
rownames(mtcars) = NULL
View(mtcars)
mtcars %>% select(name, mpg, cyl, disp) -> mtcars01
head(mtcars01)

mtcars01 %>% gather(key='key', value='value', mpg, cyl, disp) -> mtcarsLong
head(mtcarsLong)
View(mtcarsLong)

mtcarsLong %>% spread(key='key', value='value') -> mtcars02
head(mtcars02)


all.equal(mtcars01, mtcars02)

all.equal(mtcars01 %>% arrange(name), mtcars02 %>% select(name, mpg, cyl, disp) %>% arrange(name))


# GOOD

my_data <- USArrests[c(1, 10, 20, 30), ]
my_data
my_data <- cbind(state = rownames(my_data), my_data)
my_data


my_data2 <- gather(my_data,
                   key = "arrest_attribute",
                   value = "arrest_estimate",
                   -state)
my_data2


my_data2 <- gather(my_data,
                   key = "arrest_attribute",
                   value = "arrest_estimate",
                   Murder, Assault)
my_data2


my_data2 <- gather(my_data,
                   key = "arrest_attribute",
                   value = "arrest_estimate",
                   Murder:UrbanPop)
my_data2


my_data3 <- spread(my_data2, 
                   key = "arrest_attribute",
                   value = "arrest_estimate"
)
my_data3



my_data4 <- unite(my_data,
                  col = "Murder_Assault",
                  Murder, Assault,
                  sep = "_")
my_data4



separate(my_data4,
         col = "Murder_Assault",
         into = c("Murder", "Assault"),
         sep = "_")





my_data %>% gather(key = "arrest_attribute",
                   value = "arrest_estimate",
                   Murder:UrbanPop) %>%
  unite(col = "attribute_estimate",
        arrest_attribute, arrest_estimate)

names(gap_wide)

##############################

library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

install.packages("proxy") # 유사도 분석 
install.packages("tm") # 텍스트 마이닝 지원 패키지
install.packages("qgraph") # 네트워크 그래프
install.packages("SnowballC") # 어근 추출
library(proxy)
library(tm)
library(qgraph)
library(SnowballC)

# 행렬곱

m1=matrix(1:4,2)
m1
m1 %*% m1

m2=matrix(1:6,2)
m2
m3=matrix(1:9,3)
m3
m2 %*% m3


getSources()
getTransformations()

# 다섯명의 동료가 점심시간에 선택한 메뉴들이다.

lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
           "커피 우동 소고기김밥 귤",
           "참치김밥 커피 오뎅",
           "샐러드 피자 파스타 콜라",
           "티라무슈 햄버거 콜라",
           "파스타 샐러드 커피"
)
lunch

cps <- VCorpus(VectorSource(lunch))
cps
tdm <- TermDocumentMatrix(cps)
tdm
as.matrix(tdm)

tdm <- TermDocumentMatrix(cps, control=list(wordLengths = c(1, Inf)))
tdm
inspect(tdm)
(m <- as.matrix(tdm))


rowSums(m)
colSums(m)
names(sort(rowSums(m), decreasing=T)[1])

m
t(m)


# Co-occurrence matrix - 동시 발생 행렬 -
# 6명이 각각 먹은 점심 메뉴에서 함께 먹은 메뉴 즉 함께 선택되는 메뉴들을 알 수 있다.
menucom <- m %*% t(m)  
menucom

old <- par(family = "maple")
# 텍스트 분석 시각화 : 네트워크 그래프
qgraph(menucom, labels=rownames(menucom), diag=F, 
       layout='spring',  edge.color='blue', color=rainbow(7), 
       vsize=log(diag(menucom)*10000), title="함께 선택한 메뉴들", title.cex=2.5, title.color='red')

qgraph(menucom, labels=rownames(menucom), diag=F, shape='square',
       layout='spring',  edge.color='blue', color=topo.colors(7), 
       vsize=log(diag(menucom)*10000), title="함께 선택한 메뉴들", title.cex=2.5, title.color='red')
par(family = "dog")
qgraph(menucom, labels=rownames(menucom), diag=F, shape='diamond',
       layout='spring',  edge.color='blue', color='green', 
       vsize=log(diag(menucom)*10000), title="함께 선택한 메뉴들", title.cex=2.5, title.color='red')
par(old)


# Document Term Matrix
dtm <- DocumentTermMatrix(cps, control=list(wordLengths = c(1, Inf)))
dtm
(m <- as.matrix(dtm))

partnercom <- m %*% t(m)  
partnercom

# 유사도 거리(코사인, 유클리디언)
dist(partnercom, method = "cosine")
dist(partnercom, method = "Euclidean")



# 문서(문장)의 유사도 분석을 간단하게 알아보자
dd <- NULL
d1 <- c("aaa bbb ccc")
d2 <- c("aaa bbb ddd")
d3 <- c("aaa bbb ccc")
d4 <- c("xxx yyy zzz")
dd <- c(d1, d2, d3, d4)
cps <- VCorpus(VectorSource(dd))
dtm <- DocumentTermMatrix(cps)
as.matrix(dtm)

m <- as.matrix(dtm)
doccom <- m %*% t(m)
doccom
# 거리로 구하는 함수
dist(doccom, method = "cosine")
dist(doccom, method = "Euclidean")
# 유사성으로 구하는 함수
simil(doccom, method = "cosine")
simil(doccom, method = "Euclidean")
?dist



# TF & TFIDF


A <- c('포도 바나나 딸기 맥주 비빔밥 여행 낚시 떡볶이 분홍색 듀크 귤 딸기')
B <- c('사과 와인 스테이크 배 포도 여행 등산 짜장면 냉면 삼겹살 파란색 듀크 귤 귤')
C <- c('백숙 바나나 맥주 여행 피자 콜라 햄버거 비빔밥 파란색 듀크 귤 귤')
D <- c('귤 와인 스테이크 배 포도 햄버거 등산 갈비 냉면 삼겹살 녹색 듀크')
data <- c(A,B,C,D)
cps <- VCorpus(VectorSource(data))
tdm <- TermDocumentMatrix(cps, control=list(wordLengths = c(1, Inf)))
inspect(tdm)
(m <- as.matrix(tdm))
(v <- sort(rowSums(m), decreasing=T))

m1 <- as.matrix(weightTf(tdm))
m2 <- as.matrix(weightTfIdf(tdm))
m1;m2





library(KoNLP)
useSejongDic()
library(jsonlite)
library(httr)
library(tm)
library(qgraph)

searchUrl<- "https://openapi.naver.com/v1/search/blog.json"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("봄") ; 
url <- paste0(searchUrl, "?query=", query, "&display=100")
response <- GET(url, add_headers("Content_Type" = "application/json",
                                 "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

json_data <- httr::content(response, type='text', encoding="UTF-8")
json_obj <- fromJSON(json_data)
df <- data.frame(json_obj)
head(df)
blogtext <- df$items.description
blogtext
blogtext <- gsub("</?b>", "", blogtext) 
blogtext <- gsub("&.+;", "", blogtext)
blogtext <- gsub("[[:digit:][:punct:][:lower:][:upper:]]", "", blogtext)
blogtext <- gsub("\\s{2,}", " ", blogtext)
blogtext

extractednoun <- extractNoun(blogtext)
extractednoun[[100]] 
keyword <- sapply(extractednoun, function(d) paste(d, collapse = " "))
keyword[[100]]

corpus <- VCorpus(VectorSource(keyword))
stopWord <- c("텍스트", "분석")
tdm <- TermDocumentMatrix(corpus, control=list(stopwords=stopWord, wordLengths=c(2, Inf)))
(tdm.matrix <- as.matrix(tdm))

word.count <- rowSums(tdm.matrix)
word.order <- order(word.count, decreasing=TRUE)
freq.words <- tdm.matrix[word.order[1:30], ]

co.matrix <- freq.words %*% t(freq.words)


old <- par(family = "maple")
qgraph(co.matrix, labels=rownames(co.matrix),
       diag=FALSE, layout='spring', threshold=1,
       vsize=log(diag(co.matrix)) * 3)
par(old)


library(rvest)
library(XML)
html.parsed <- htmlParse("data/TextofSteveJobs.html")
text <- xpathSApply(html.parsed, path="//p", xmlValue)
text

text <- text[4:30]
text
docs <- VCorpus(VectorSource(text))
docs


toSpace <- content_transformer(function(x, pattern){return(gsub(pattern, " ", x))})
docs <- tm_map(docs, toSpace, ":")
docs <- tm_map(docs, toSpace, ";")
docs <- tm_map(docs, toSpace, "'")

docs[[17]]
docs[[19]]
docs[[17]]$content
docs[[19]]$content

docs <- tm_map(docs, removePunctuation)
text[17]
docs[[17]]$content


docs <- tm_map(docs, content_transformer(tolower))
docs[[17]]$content
docs <- tm_map(docs, removeNumbers)     # 숫자 삭제
docs[[17]]$content
docs <- tm_map(docs, removeWords, stopwords("english"))   # 불용어 설정
docs[[17]]$content
docs <- tm_map(docs, stripWhitespace)   # 공백을 한개만 남기고 삭제
docs[[17]]$content
docs <- tm_map(docs, stemDocument)
docs[[17]]$content

tdm <- TermDocumentMatrix(docs)
tdm

inspect(tdm[50:60, 1:5])

termFreq <- rowSums(as.matrix(tdm))
head(termFreq)
termFreq[head(order(termFreq, decreasing=T))]

# 텍스트 분석 시각화 : 바 그래프
barplot(termFreq[termFreq >= 7], 
        horiz=T, las=1, cex.names=0.8, 
        col=rainbow(16), xlab="word Frequency", ylab="Words")



?stopwords


# tm 패키지를 활용한 숫자, 특수문자, 불용어 삭제하기

mystopwords <- readLines("data/stopwords_ko.txt", encoding="UTF-8")
text <- readLines("data/stopwords_testdata.txt", encoding="UTF-8")
docs <- VCorpus(VectorSource(text))
inspect(docs)
docs <- tm_map(docs, removeNumbers)
inspect(docs)
docs <- tm_map(docs, removePunctuation)
inspect(docs)
docs <- tm_map(docs, removeWords, mystopwords)
inspect(docs)

tdm <- TermDocumentMatrix(docs, control=list(wordLengths = c(1, Inf)))
as.matrix(tdm)

docs2 <- VCorpus(VectorSource(text))
tdm1 <- TermDocumentMatrix(docs2, control=list(wordLengths = c(1, Inf)))
as.matrix(tdm1)

tdm2 <- TermDocumentMatrix(docs2, control=list(
  removePunctuation = T, 
  removeNumbers = T,
  wordLengths = c(1, Inf),
  stopwords=mystopwords))
as.matrix(tdm2)



# 한국어 불용어
# https://www.rdocumentation.org/packages/stopwords/versions/2.2
library(stopwords)
stopwords::stopwords()
stopwords_getsources()
st <- head(stopwords::stopwords("ko", source = "marimo"), 100)
dd <- c("저는 유니코입니다", "우리 모두 건강하게 보내요")
docs <- VCorpus(VectorSource(dd))
docs
r <- tm_map(docs,removeWords,st) 
str(r)
r$dmeta
r[[1]]$content
r[[2]]$content

