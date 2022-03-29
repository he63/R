# [ YES24의 명견만리 댓글 읽어오기 ]

library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost", port = 4445, browserName = "chrome")
remDr$open()

remDr$navigate("http://www.yes24.com/24/goods/40936880")

webElem <- remDr$findElement("css selector", "body")
remDr$executeScript("scrollTo(0, 0)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0, 3200)", args = list(webElem))
Sys.sleep(3)
repl_v = NULL
endFlag <- FALSE
page <- 3

repeat {
  for(index in 3:7) {
    fullContentLinkcss <- paste("#infoset_reviewContentList > div:nth-child(",index,") > div.reviewInfoBot.crop > a", sep='')
    fullContentLink<-remDr$findElements(using='css selector',  fullContentLinkcss)
    if (length(fullContentLink) == 0) {
      cat("종료\n")
      endFlag <- TRUE
      break
    }
    remDr$executeScript("arguments[0].click();",fullContentLink);
    Sys.sleep(1)
    fullContentcss <- paste("#infoset_reviewContentList > div:nth-child(",index,") > div.reviewInfoBot.origin > div.review_cont > p", sep='')
    fullContent<-remDr$findElements(using='css selector', fullContentcss)
    repl <-sapply(fullContent,function(x){x$getElementText()})    
    print(repl)
    cat("---------------------\n")
    repl_v <- c(repl_v, unlist(repl))
  }
  if(endFlag)
    break;  
  
  if(page == 10){
    page <- 3
    nextPagecss <- "#infoset_reviewContentList > div.review_sort.sortTop > div.review_sortLft > div > a.bgYUI.next"
  }
  else{
    page <- page+1;
    nextPagecss <- paste("#infoset_reviewContentList > div.review_sort.sortBot > div.review_sortLft > div > a:nth-child(",page,")",sep="")
  }
  remDr$executeScript("scrollTo(0, 0)", args = list(webElem))
  nextPageLink<-remDr$findElements(using='css selector',nextPagecss) 
  remDr$executeScript("arguments[0].click();",nextPageLink);
  #sapply(nextPageLink,function(x){x$clickElement()})  
  Sys.sleep(3)
  print(page)
}
write(repl_v, "output/yes24.txt")




# [스타벅스 서울 전체 매장 정보 크롤링&스크래핑]

library(RSelenium)

#remDr <- remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
#remDr$open()

site <- paste("https://www.istarbucks.co.kr/store/store_map.do?disp=locale")
remDr$navigate(site)

Sys.sleep(3)

#서울 클릭
btn1css <- "#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step1 > div.loca_step1_cont > ul > li:nth-child(1) > a"
btn1Page <- remDr$findElements(using='css selector',btn1css)
sapply(btn1Page,function(x){x$clickElement()})
Sys.sleep(3)

#전체 클릭
btn2css <- "#mCSB_2_container > ul > li:nth-child(1) > a"
btn2Page <- remDr$findElements(using='css selector',btn2css)
sapply(btn2Page,function(x){x$clickElement()})
Sys.sleep(3)

index <- 0
starbucks <- NULL
total <- sapply(remDr$findElements(using='css selector',"#container > div > form > fieldset > div > section > article.find_store_cont > article > article:nth-child(4) > div.loca_step3 > div.result_num_wrap > span"),function(x){x$getElementText()})

repeat{
  index <- index + 1
  print(index)
  
  storecss <- paste0("#mCSB_3_container > ul > li:nth-child(",index,")")
  storePage <- remDr$findElements(using='css selector',storecss)
  if(length(storePage) == 0) 
    break
  storeContent <- sapply(storePage,function(x){x$getElementText()})
  
  #스타벅스 정보 추출
  #strsplit(storeContent, split="\n")
  storeList <- strsplit(unlist(storeContent), split="\n")
  shopname <- storeList[[1]][1]
  addr <- storeList[[1]][2]
  addr <- gsub(",", "", addr)
  telephone <- storeList[[1]][3]
  
  #스타벅스 위도 경도 추출
  lat <- sapply(storePage,function(x){x$getElementAttribute("data-lat")})
  lng <- sapply(storePage,function(x){x$getElementAttribute("data-long")})
  
  #병합
  starbucks <- rbind(starbucks ,cbind(shopname, addr, telephone, lat, lng))
  
  #스크롤 다운
  if(index %% 3 == 0 && index != total)
    remDr$executeScript("var dom=document.querySelectorAll('#mCSB_3_container > ul > li')[arguments[0]]; dom.scrollIntoView();", list(index))
}
write.csv(starbucks, "output/starbucks.csv")



# 텍스트 분석
# 한국어 형태소 분석 패키지 설치
# Rtools 설치
# https://cran.r-project.org/bin/windows/Rtools/index.html
install.packages("Sejong")
install.packages("hash")
install.packages("tau")
install.packages("devtools") # 시간이 오래 걸림

# github 버전 설치
# 64bit 에서만 동작합니다.
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)
# Checking user denied dictionary -- 이 메시지가 출력되면 정상적으로 로딩된 것
# 일부 패키지의 버전 문제로 업데이트 설치 요구함. 1번 선택하고 계속 진행할 것
useSejongDic()
#Sys.getenv("JAVA_HOME")

SimplePos09("오늘 비가 내린다.") # 9가지 품사로 형태소 분석
SimplePos22("오늘 비가 내린다.") # 22가지 품사로 형태소 분석
extractNoun("오늘 비가 내린다.") # 명사만 추출

extractNoun("아버지가방에들어가셨다.")

extractNoun("아버지가방에들어가셨다.", autoSpacing = T)

extractNoun("할리우드 톱스타 레오나르도 디카프리오는 '선행 전도사'다운 행보를 이어갔다.")

buildDictionary(user_dic=data.frame("디카프리오", "ncn"),replace_usr_dic = T)

extractNoun("할리우드 톱스타 레오나르도 디카프리오는 '선행 전도사'다운 행보를 이어갔다.")



word_data <- readLines("data/애국가(가사).txt")
word_data

word_data2 <- sapply(word_data, extractNoun, USE.NAMES = F) # 이전 버전은 sapply 를 통해 실행시켜야하는 경우가 있었다.
word_data2
word_data3 <- extractNoun(word_data)  # 현재는 그냥 이렇게해도 된다.
word_data3

add_words <- c("백두산", "남산", "철갑", "가을", "달")
buildDictionary(user_dic=data.frame(add_words, rep("ncn")), replace_usr_dic=T)

word_data3 <- extractNoun(word_data)
word_data3

undata <- unlist(word_data3)
undata

word_table <- table(undata)
word_table

undata2 <- Filter(function(x) {nchar(x) >= 2}, undata)
word_table2 <- table(undata2)
word_table2

final <- sort(word_table2, decreasing = T)

head(final, 10)

extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
SimplePos09("대한민국의 영토는 한반도와 그 부속도서로 한다")
SimplePos22("대한민국의 영토는 한반도와 그 부속도서로 한다")




# 워드 클라우드
install.packages("wordcloud")
install.packages("wordcloud2")
library(wordcloud)
library(wordcloud2)

(words <- read.csv("data/wc.csv"))
head(words)
?windowsFonts
windowsFonts(lett=windowsFont("휴먼옛체"))
windowsFonts(dog=windowsFont("THE개이득"))
wordcloud(words$keyword, words$freq)
wordcloud(words$keyword, words$freq,family="lett")
wordcloud(words$keyword, words$freq,family="dog")
wordcloud(words$keyword, words$freq, 
          min.freq = 2, 
          random.order = F, 
          rot.per = 0.5, scale = c(4, 1), 
          colors = rainbow(7))

wordcloud(words$keyword, words$freq, 
          min.freq = 2, 
          random.order = F, 
          rot.per = 0.5, scale = c(4, 1), 
          colors = rainbow(20), family="lett")

wordcloud2(words, fontFamily = "휴먼옛체")
wordcloud2(words,rotateRatio = 1)
wordcloud2(words,rotateRatio = 0.5)
wordcloud2(words,rotateRatio = 0)
wordcloud2(words,size=0.5,col="random-dark")
wordcloud2(words,size=0.7,col="random-light",backgroundColor = "black")
wordcloud2(data = demoFreq) # str(demoFreq)
wordcloud2(data = demoFreq, shape = 'diamond')
wordcloud2(data = demoFreq, shape = 'star')
wordcloud2(data = demoFreq, shape = 'cardioid')
wordcloud2(data = demoFreq, shape = 'triangle-forward')
wordcloud2(data = demoFreq, shape = 'triangle')
result<-wordcloud2(data = demoFreq, shape = 'pentagon')
library(htmlwidgets)
saveWidget(result,"output/tmpwc1.html",selfcontained = T) #오동작
saveWidget(result,"output/tmpwc2.html",selfcontained = F)
htmltools::save_html(result,"output/tmpwc3.html")


head(demoFreq)
str(demoFreq)

wordcloud(names(final),final)
wordcloud(names(final),final, min.freq = 1)
wordcloud2(final)


# 네이버 블로그 글 워드클라우드
library(XML)
library(httr)
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("봄")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 블로그 내용에 대한 리스트 만들기		
doc2 <- xmlParse(doc, encoding="UTF-8")
spring <- xpathSApply(doc2, "//item/description", xmlValue)
spring <- gsub("</?b>", "", spring) 
spring <- gsub("&[a-z];", "", spring) 
spring

word <- extractNoun(spring)
cdata <- unlist(word)

cdata <- Filter(function(x) {nchar(x) < 6 & nchar(x) >= 2} ,cdata)
wordcount <- table(cdata) 
wordcount <- head(sort(wordcount, decreasing=T),30)

par(mar=c(1,1,1,1))
wordcloud(names(wordcount),freq=wordcount,scale=c(3,0.5),rot.per=0.35,min.freq=1,
          random.order=F,random.color=T,colors=rainbow(20), family="dog")

wordcloud2(wordcount, fontFamily = "맑은고딕", size=0.5,
           color="random-light", backgroundColor="black")

wordcloud2(wordcount, fontFamily = "THE개이득", size=0.5,
           color="random-light", backgroundColor="black")

wordcloud2(wordcount, size=0.5,
           color="random-light")