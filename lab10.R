library(rvest)

url <- "http://media.daum.net/ranking/popular/"
text <- read_html(url)


# 뉴스 제목
newstitle <- html_text(html_nodes(text, ".tit_g > .link_txt"))
newstitle <- gsub("[[:cntrl:]]|                                    ", "", newstitle)
newstitle <- newstitle[1:20]
newstitle


# 신문사 명칭
newscategory <- html_nodes(text, ".logo_cp > img")
newscategory
news = html_attr(newscategory, 'alt')

daumnews <- data.frame(newstitle, news)
View(daumnews)

write.csv(daumnews, file="daumnews.csv") 