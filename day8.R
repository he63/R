# [ 예제3 ]
# 단일 페이지(rvest 패키지 사용)
library(rvest)
# 영화 제목과 평점 읽기
url<- "http://movie.naver.com/movie/point/af/list.nhn"
text <- read_html(url)
text
# 영화제목
nodes <- html_nodes(text, ".movie")
title <- html_text(nodes)
title
# 영화평점
nodes <- html_nodes(text, ".list_netizen_score > em")
point <- html_text(nodes)
point
page <- data.frame(title, point)
print(page)


# [ 예제4 ]
# 단일 페이지(rvest 패키지 사용)

# 영화 제목, 평점, 리뷰글 읽기
text<- NULL 
title<-NULL 
point<-NULL 
review<-NULL 
page<-NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn"
text <- read_html(url)
text
#save(text, file="imsi.rda")
# 영화제목
nodes <- html_nodes(text, ".movie")
title <- html_text(nodes)
title
# 영화평점
nodes <- html_nodes(text, ".title em")
point <- html_text(nodes)
point
# 영화리뷰

review <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()")
review <- html_text(review, trim=TRUE)
review <- review[nchar(review) > 0]
review
page <- data.frame(title, point, review) # 리뷰글이 생략된 경우 오류 발생!!!
print(page)


# [ 예제5 ]
# 여러 페이지1
site<- "http://movie.naver.com/movie/point/af/list.nhn?page="
text <- NULL
movie.review <- NULL
for(i in 1: 100) {
  url <- paste(site, i, sep="")
  text <- read_html(url)
  nodes <- html_nodes(text, ".movie")
  title <- html_text(nodes)
  nodes <- html_nodes(text, ".title em")
  point <- html_text(nodes)
  nodes <- html_nodes(text, xpath="//*[@id='old_content']/table/tbody/tr/td[2]/text()")
  imsi <- html_text(nodes, trim=TRUE)
  review <- imsi[nchar(imsi) > 0] 
  if(length(review) == 10) {
    page <- data.frame(title, point, review)
    movie.review <- rbind(movie.review, page)
  } else {
    cat(paste(i," 페이지에는 리뷰글이 생략된 데이터가 있어서 수집하지 않습니다.ㅜㅜ\n"))
  }
}
write.csv(movie.review, "output/movie_reviews1.csv")


# [ 예제6 ]
# 영화 제목, 평점, 리뷰글 읽기
text<- NULL; vtitle<-NULL; vpoint<-NULL; vreview<-NULL; page=NULL
url<- "http://movie.naver.com/movie/point/af/list.nhn"
text <- read_html(url)
text

for (index in 1:10) {
  # 영화제목
  node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index, ") > td.title > a.movie.color_b"))
  title <- html_text(node)
  vtitle[index] <- title
  # 영화평점
  node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index,") > td.title > div > em"))
  point <- html_text(node)
  vpoint <- c(vpoint, point)
  # 영화리뷰 
  node <- html_nodes(text, xpath=paste0('//*[@id="old_content"]/table/tbody/tr[', index,"]/td[2]/text()"))
  node <- html_text(node, trim=TRUE)
  print(node)
  review = node[4] # 리뷰글이 생략된 경우에 대한 처리를 위해...
  vreview <- append(vreview, review)
}
page <- data.frame(vtitle, vpoint, vreview)
View(page)
write.csv(page, "output/movie_reviews2.csv")


# [ 예제7 ]
# 여러 페이지2
site<- "http://movie.naver.com/movie/point/af/list.nhn?page="
text <- NULL
movie.review <- NULL
for(i in 1: 100) {
  url <- paste(site, i, sep="")
  print(url)
  text <- read_html(url)
  vtitle <- NULL
  vpoint <- NULL 
  vreview <- NULL
  for (index in 1:10) {
    # 영화제목
    node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index, ") > td.title > a.movie.color_b"))
    title <- html_text(node)
    vtitle[index] <- title
    # 영화평점
    node <- html_node(text, paste0("#old_content > table > tbody > tr:nth-child(", index,") > td.title > div > em"))
    point <- html_text(node)
    vpoint <- c(vpoint, point)
    # 영화리뷰 
    node <- html_nodes(text, xpath=paste0('//*[@id="old_content"]/table/tbody/tr[', index,"]/td[2]/text()"))
    node <- html_text(node, trim=TRUE)
    #print(node)
    review = node[4] 
    vreview <- append(vreview, review)
  }
  page <- data.frame(vtitle, vpoint, vreview)
  movie.review <- rbind(movie.review, page)
}
View(movie.review)
str(movie.review)
write.csv(movie.review, "output/movie_reviews3.csv")


# [ 예제8 ]
# W3C의 HTTP 프로토콜 스팩에서 Table of Contents 읽기
title2 = html_nodes(read_html('http://www.w3.org/Protocols/rfc2616/rfc2616.html'), 'div.toc > h2')
title2 = html_text(title2)
title2

title2 = html_nodes(read_html('http://www.w3.org/Protocols/rfc2616/rfc2616.html'), 'body > div > h2')
title2 = html_text(title2)
title2

title2 = html_nodes(read_html('http://www.w3.org/Protocols/rfc2616/rfc2616.html'), xpath='/html/body/div/h2')
title2 = html_text(title2)
title2

title2 = html_nodes(read_html('http://www.w3.org/Protocols/rfc2616/rfc2616.html'), xpath='//div/h2')
title2 = html_text(title2)
title2


# [ 예제9 ]
# YES24에서 IT신간 정보 추출(도서명, 출판사명)
site<- "http://www.yes24.com/24/Category/NewProductList/001001003?sumGb=04&PageNumber="
itbooks <- NULL
i <- 1
while(TRUE) {
  nodes <- NULL
  url <- paste0(site, i)
  doc <- read_html(url)
  # 도서명
  nodes <- html_nodes(doc, 'td.goodsTxtInfo > p:nth-child(1) > a:nth-child(1)')
  print(length(nodes))
  if (length(nodes) == 0){
    break
  }
  title.books <- html_text(nodes)
  # 출판사명
  nodes <- html_nodes(doc, 'td.goodsTxtInfo > div > a:last-child')
  publisher.books <- html_text(nodes)
  
  page <- data.frame(title.books, publisher.books)
  itbooks <- rbind(itbooks, page)
  i <- i+1
}
View(itbooks)
write.csv(itbooks, "output/yes24_new_itbooks.csv")


# [ 예제10 ]
# 한겨레 페이지(XML 패키지 사용)
library(XML)
library(rvest)
imsi <- read_html("http://www.hani.co.kr/")
t <- htmlParse(imsi)
content<- xpathSApply(t,'//*[@id="main-top01-scroll-in"]/div/div/h4/a', xmlValue); 
content



# [ 예제11 ]
# 뉴스, 게시판 등 글 목록에서 글의 URL만 뽑아내기 
htxt = read_html("https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001")
link = html_nodes(htxt, 'div.list_body a')
length(link)
link
article.href = unique(html_attr(link, 'href'))
article.href

# [ 예제12 ]
# 이미지, 첨부파일 다운 받기 
# pdf
library(httr)
res = GET('http://cran.r-project.org/web/packages/httr/httr.pdf')
writeBin(content(res, 'raw'), 'c:/Temp/httr.pdf')

# [ 예제13 ]
# jpg
h = read_html('http://unico2013.dothome.co.kr/productlog.html')
imgs = html_nodes(h, 'img')
img.src = html_attr(imgs, 'src')
for(i in 1:length(img.src)){
  res = GET(paste('http://unico2013.dothome.co.kr/',img.src[i], sep=""))
  writeBin(content(res, 'raw'), paste('c:/Temp/', img.src[i], sep=""))
} 

# [ 예제14 ]
# SNS의 Open API 활용
library(httr)
library(rvest)
library(XML)

# URLEncode() : 주어진 문자열을 URL Encoding 규칙(=Query 문자열 인코딩)으로 변환하는 기능 제공
# '가' - 코드값 - UTF-8 : 0xEAB080, EUC-KR(CP949,ANSI) : 0xB0A1
URLencode('ABC')
URLencode('가나다')
URLencode("ABC123 가나다")

searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("봄")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 블로그 내용에 대한 리스트 만들기		
doc2 <- xmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
text
text <- gsub("</?b>", "", text) # </?b> --> <b> 또는 </b>
text <- gsub("&.+t;", "", text) # &.+t; --> &at;, &abct;, &lt;, &lllt; ... &lt;, &gt;, &quot;,
text <- gsub("&.[A-Za-z]+t;", "", text) # &.+t; --> &at;, &abct;, &lt;, &lllt; ... &lt;, &gt;, &quot;, 
text[75]
text

# [ 예제15 ]
# 네이버 뉴스 연동  
searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode("코로나")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

# 네이버 뉴스 내용에 대한 리스트 만들기		
doc2 <- xmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue); 
text
text <- gsub("</?b>", "", text)
text <- gsub("&.+t;", "", text)
text

# [ 예제16 ]
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "146"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
url
doc <- xmlParse(url, encoding="UTF-8")
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
str(df)
View(df)

busRouteId <- df[df$busRouteNm == 146, "busRouteId"]
busRouteId


url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
url
doc <- xmlParse(url, encoding="UTF-8")
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
View(df)
str(df)

# [ 예제17 ]
# 서울시 빅데이터- XML 응답 처리
# http://openapi.seoul.go.kr:8088/796143536a756e69313134667752417a/xml/LampScpgmtb/1/100/

library(XML)
key = '796143536a756e69313134667752417a'
contentType = 'xml'
startIndex = '1'
endIndex = '200'
url = paste0('http://openapi.seoul.go.kr:8088/',key,'/',contentType,'/LampScpgmtb/',startIndex,'/',endIndex,'/')
url
t <- xmlParse(url, encoding="UTF-8")
upNm<- xpathSApply(t,"//row/UP_NM", xmlValue) 
pgmNm<- xpathSApply(t,"//row/PGM_NM", xmlValue)
targetNm<- xpathSApply(t,"//row/TARGET_NM", xmlValue)
price<- xpathSApply(t,"//row/U_PRICE", xmlValue)

df <- data.frame(upNm, pgmNm, targetNm, price)
View(df)
write.csv(df, "output/edu.csv")

# [ 예제18 ]

# 고속도로 공공데이터 포털 Open API - XML 응답 처리
library(rvest)
library(XML)
API_key <- "4062158448"
sdate <- "20210824"
stdHour <- "10"
type <- "xml"
url <- paste0("http://data.ex.co.kr/openapi/restinfo/restWeatherList?key=", API_key, "&type=", type, "&sdate=", sdate, "&stdHour=", stdHour)
url
# case 1
doc <- xmlParse(url, encoding="UTF-8")
unitName <- xpathSApply(doc,"//list/unitName", xmlValue) 
unitCode <- xpathSApply(doc,"//list/unitCode", xmlValue)
routeName <- xpathSApply(doc,"//list/routeName", xmlValue)
addr <- xpathSApply(doc,"//list/addr", xmlValue)
weatherContents <- xpathSApply(doc,"//list/weatherContents", xmlValue)
tempValue <- xpathSApply(doc,"//list/tempValue", xmlValue)

df <- data.frame(unitName, unitCode, routeName, addr, weatherContents, tempValue )
View(df)

# case 2
doc <- xmlParse(url, encoding="UTF-8")
df <- xmlToDataFrame(getNodeSet(doc, "//list"))
df
View(df)
names(df)
df_new <- df[c('unitName', 'unitCode', 'routeName', 'addr', 'weatherContents', 'tempValue')]
View(df_new)

?read_html


# [ 예제19 ]
# 고속도로 공공데이터 포털 Open API - JSON 응답 처리

library(jsonlite)
library(httr)
url <- 'https://data.ex.co.kr/openapi/restinfo/restWeatherList?key=4062158448&type=json&sdate=20210821&stdHour=10'
url
response <- GET(url)
json_data <- content(response, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
class(json_obj)
df <- data.frame(json_obj)
View(df)
df_new <- df[c('list.unitName', 'list.unitCode', 'list.routeName', 'list.addr', 'list.weatherContents', 'list.tempValue')]
View(df_new)










