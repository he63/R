# 벡터에 새로운 원소 추가하기
# CASE1 
newv1 <- NULL
newv1 <- c(newv1, "둘리")
newv1
newv1 <- c(newv1, "또치")
newv1
newv1 <- c(newv1, "도우너")
newv1
newv1 <- c(newv1, c("고길동", "희동이"))
newv1
# CASE2 
newv2 <- NULL
newv2 <- append(newv2, "둘리")
newv2
newv2 <- append(newv2, "또치")
newv2
newv2 <- append(newv2, "도우너")
newv2
newv2 <- append(newv2, c("고길동", "희동이"))
newv2

# 동적 웹 페이지의 수집
install.packages("RSelenium")
library(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" , 
                      port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://www.google.com/")
class(remDr)
str(remDr)

webElem <- remDr$findElement(using = "css", "[name = 'q']")
webElem$sendKeysToElement(list("PYTHON", key = "enter"))

remDr$navigate("http://www.naver.com/")

webElem <- remDr$findElement(using = "css selector", "#query")
webElem$sendKeysToElement(list("PYTHON", key = "enter"))
str(webElem)

# 다음에 제시된  URL의 웹 페이지는 정적 방법으로 충분히 가능하지만
# 이해를 돕기 위해 간단한 웹페이지를 크롤링하고 스크래핑 함
url <- "http://unico2013.dothome.co.kr/crawling/tagstyle.html"
remDr$navigate(url)

#단수형으로 노드 추출 using=css selector 
one<-remDr$findElement(using='css selector', 'div') # 노드 한 개 리턴(WebElement 객체)
one$getElementTagName()
one$getElementText()
one$getElementAttribute("style")

# 단수형으로 없는 노드 추출
one<-NULL
one<-remDr$findElement(using='css selector', 'p') # 없으면 오류 발생
print(one)
print(length(one))


# 만일 오류 발생을 무시하고 싶어서 사용하지만 소용없음, 외부 라이브러리 사용 때문이라 추정(^^)
# 없을 수도 있으면 복수형(findElements()) 사용할것
one<-NULL
try(one<-remDr$findElement(using='css selector', 'p'))
print(one)
print(length(one))


#복수형으로 노드 추출
more<-remDr$findElements(using='css selector', 'div')
sapply(more, function(x) x$getElementTagName())
sapply(more, function(x) x$getElementText())

#복수형으로 없는 추출
more<-remDr$findElements(using='css selector', 'p') # 없으면 오류가 발생하지 않음 비어있는 리스트 리턴
print(more)  
if(length(more) == 0) 
  cat("<p> 태그는 없슈\n")
sapply(more, function(x) x$getElementTagName())
sapply(more, function(x) x$getElementText())



url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
remDr$navigate(url)
# 수행1
one<-remDr$findElement(using='css selector', 'a:nth-of-type(4)')
# 수행2
one$getElementTagName()
# 수행3
one$getElementText()
# 수행4(클릭 이벤트 처리)
one$clickElement()


url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
remDr$navigate(url)

one<-remDr$findElement(using='css selector', 'a:nth-of-type(3)')
one$getElementTagName()
one$getElementText()
# 클릭 이벤트 처리하는 또 다른 방법
remDr$executeScript("arguments[0].click()",list(one))

# [ 네이버 웹툰 댓글 읽기 ]
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)

#단수형으로 노드 추출(전체댓글이라는 링크텍스트를 출력하는 <A> 태그를 찾자)
more<-remDr$findElement(using='css selector', '#cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a')
more$getElementTagName()
more$getElementText() # 전체댓글
#클릭이벤트 처리
more$clickElement()


# 2페이지부터 10페이지까지 링크 클릭하여 페이지 이동하기 
for (i in 4:12) {
  nextCss <- paste0("#cbox_module>div>div.u_cbox_paginate>div> a:nth-child(",i,") > span")
  nextPage<-remDr$findElement(using='css selector', nextCss)
  nextPage$clickElement()
  Sys.sleep(2)
}


#베스트 댓글 내용 읽어오기
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)

bestReviewNodes<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
sapply(bestReviewNodes,function(x){x$getElementText()})

#전체 댓글 링크 클릭후 
totalReview <- remDr$findElement(using='css','#cbox_module > div > div.u_cbox_sort > div.u_cbox_sort_option > div > ul > li:nth-child(2) > a')
totalReview$clickElement()

#첫 페이지 내용 읽어오기
totalReviewNodes<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
sapply(totalReviewNodes,function(x){x$getElementText()})


# 링크 클릭시 AJAX 로 처리되는 네이버 웹툰 댓글 읽어 오기
repl_v = NULL;
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr$navigate(url)
#베스트 댓글 내용 읽어오기
doms1<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
vest_repl <- sapply(doms1,function(x){x$getElementText()})
repl_v <- c(repl_v, unlist(vest_repl))

toralReview <- remDr$findElement(using='css selector','span.u_cbox_in_view_comment')
toralReview$clickElement()
#전체 댓글의 첫 페이지 내용 읽어오기
doms2<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
repl <-sapply(doms2,function(x){x$getElementText()})
repl_v <- c(repl_v, unlist(repl))

repeat {
  for (i in 4:12) {               
    nextCss <- paste("#cbox_module>div>div.u_cbox_paginate>div> a:nth-child(",i,") > span", sep="")                
    try(nextListLink<-remDr$findElement(using='css selector',nextCss))
    if(length(nextListLink) == 0)   break;
    nextListLink$clickElement()
    Sys.sleep(1)
    #전체 댓글의 해당 페이지 내용 읽어오기
    doms3<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
    repl <-sapply(doms3,function(x){x$getElementText()})
    repl_v <- c(repl_v, unlist(repl))                
  }
  
  try(nextPage<-remDr$findElement(using='css selector',
                                  "#cbox_module > div > div.u_cbox_paginate > div > a:nth-child(13) > span.u_cbox_cnt_page"))
  if(length(nextPage) == 0)  break;
  nextPage$clickElement()
  Sys.sleep(1)
  doms2<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
  repl <-sapply(doms2,function(x){x$getElementText()})
  repl_v <- c(repl_v, unlist(repl))        
}
print(repl_v)
write(repl_v, "output/webtoon.txt")


# [ 아고다 페이지에 올려진 신라스테이 호텔에 대한 전체 페이지 댓글 읽기 ]
#remDr <- remoteDriver(remoteServerAddr = "localhost" , port = 4445, browserName = "chrome")
#remDr$open()
url<-'https://www.agoda.com/ko-kr/shilla-stay-yeoksam/hotel/seoul-kr.html?asq=z91SVm7Yvc0eRE%2FTBXmZWCYGcVeTALbG%2FvMXOYFqqcm2JknkW25Du%2BVdjH%2FesXg8ORIaVs1PaEgwePlsVWfwf3sX%2BVNABRcMMOWSvzQ9BxqOPOsvzl8390%2BEhEylPvEiBp0eoREr2xLYHgqmk0Io4J1HYEzEOqyvdox%2BwS6yxHeonB9lh7mJsBIjSBPoMzBLFW01k%2BU8s2bGO6PcSdsu3T30HwabyNzwNYKiv%2BRDxfs%3D&hotel=699258&tick=637215342272&languageId=9&userId=bcb7ecc6-7719-465f-bf29-951e39733c66&sessionId=uouhnqjisace4freagmzbxxc&pageTypeId=7&origin=KR&locale=ko-KR&cid=-1&aid=130243&currencyCode=KRW&htmlLanguage=ko-kr&cultureInfoName=ko-KR&ckuid=bcb7ecc6-7719-465f-bf29-951e39733c66&prid=0&checkIn=2020-05-30&checkOut=2020-05-31&rooms=1&adults=1&childs=0&priceCur=KRW&los=1&textToSearch=%EC%8B%A0%EB%9D%BC%EC%8A%A4%ED%85%8C%EC%9D%B4%20%EC%97%AD%EC%82%BC%20(Shilla%20Stay%20Yeoksam)&productType=-1&travellerType=0&familyMode=off'
remDr$navigate(url)
Sys.sleep(3)
pageLink <- NULL
reple <- NULL
curr_PageOldNum <- 0
repeat{
  doms <- remDr$findElements(using = "css selector", ".Review-comment-bodyText")
  Sys.sleep(1)
  reple_v <- sapply(doms, function (x) {x$getElementText()})
  #print(reple_v)
  reple <- append(reple, unlist(reple_v))
  cat(length(reple), "\n")
  pageLink <- remDr$findElements(using='css selector',"#reviewSection > div:nth-child(6) > div > span:nth-child(3) > i ")
  remDr$executeScript("arguments[0].click();",pageLink)
  Sys.sleep(2)
  curr_PageElem <- remDr$findElement(using='css selector','#reviewSection > div:nth-child(6) > div > span.Review-paginator-numbers > span.Review-paginator-number.Review-paginator-number--current')
  curr_PageNewNum <- as.numeric(curr_PageElem$getElementText())
  cat(paste(curr_PageOldNum, ':', curr_PageNewNum,'\n'))
  if(curr_PageNewNum == curr_PageOldNum)  {
    cat("종료\n")
    break; 
  }
  curr_PageOldNum <- curr_PageNewNum;
}
cat(length(reple), "개의 댓글 추출\n")
write(reple,"output/hotel.txt")


# [ 네이버 북 페이지 이번주 베스트북정보 크롤링 ]

site <- "https://book.naver.com/"
remDr$navigate(site)

#bestseller_tab

booksitenodes <- remDr$findElements(using='css selector', '#bestseller_tab > ul.tab_cp_spt > li > a')
booksites <- sapply(booksitenodes, function(x) {x$getElementAttribute("class")})
booksites <- unlist(booksites); 
booksites <- unlist(strsplit(booksites, ' '))
size <- length(booksites)
booksites <- booksites[seq(1, size, 2)]

for (booksite in booksites) {
  booksitenode <- remDr$findElement(using='css selector', paste0('#tab_cp_spt_',booksite))
  booksitenode$clickElement()
  Sys.sleep(2)
  # 썸네일 이미지 URL
  bookthumbenodes <- remDr$findElements(using='css selector', '#bestseller_list dl>dt:nth-child(1) img')
  bookthumburl <- sapply(bookthumbenodes, function(x) {x$getElementAttribute("src")})
  bookthumburl <- unlist(bookthumburl)
  # 책이름
  booktitlenodes <- remDr$findElements(using='css selector', '#bestseller_list dl>dt:nth-child(2)>a')
  booktitle <- sapply(booktitlenodes, function(x) {x$getElementText()})
  booktitle <- gsub("[[:cntrl:]]", "", booktitle)
  
  df <- data.frame(bookthumburl, booktitle)
  if (!dir.exists('output/book')) 
    dir.create('output/book')
  print(df)
  write.csv(df, file=paste0('output/book/', booksite, '.csv'))
}



# [ GS25 1+1 상품 첫페이지 스크래핑 ]

site <- 'http://gs25.gsretail.com/gscvs/ko/products/event-goods'
remDr$navigate(site)


eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(3) > ul > li > div > p.tit')
eventgoodsname <- sapply(eventgoodsnodes, function(x) {x$getElementText()})

eventgoodsnodes <- remDr$findElements(using='css selector', '#contents > div.cnt > div.cnt_section.mt50 > div > div > div:nth-child(3) > ul > li > div > p.price > span')
eventgoodsprice <- sapply(eventgoodsnodes, function(x) {x$getElementText()})

data.frame(egn = unlist(eventgoodsname), egp = unlist(eventgoodsprice))




