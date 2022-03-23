library(rvest)

url <- "http://unico2013.dothome.co.kr/crawling/exercise_bs.html"
text <- read_html(url)
text

# <h1> 태그의 컨텐츠
h1 <- html_text(html_nodes(text, "h1",))

# <a> 태그의 컨텐츠와 href 속성값
link <- html_nodes(text, "a")
length(link)
nodes = html_attr(link, 'href')
nodes

# <img> 태그의 src 속성값
link_img <- html_nodes(text, "img")
nodes_img = html_attr(link_img, "src")
nodes_img

# 첫번째 <h2> 태그의 컨텐츠
h2_1 <- html_text(html_nodes(text, "h2:nth-of-type(1)",))

# <ul> 태그의 자식 태그들 중 style 속성의 값이 green 으로 끝나는 태그의 컨텐츠
nodes_style <- html_nodes(text, "ul > li")
nodes_green <- grep("green", nodes_style, value=TRUE)
green <- gsub("[^가-힣]", "", nodes_green)


# 두번째 <h2> 태그의 컨텐츠
h2_2 <- html_text(html_nodes(text, "h2:nth-of-type(2)",))

# <ol> 태그의 모든 자식 태그들의 컨텐츠
nodes_ol <- html_text(html_nodes(text, "ol > li"))

# <table> 태그의 모든 자손 태그들의 컨텐츠
table <- html_nodes(text, 'table * ')
html_text(table)

# name 이라는 클래스 속성을 갖는<tr>태그의 컨텐츠 
nodes_name <- html_text(html_nodes(text, ".name"))

# target 이라는 아이디 속성을 갖는 <id> 태그의 컨텐츠
nodes_target <- html_text(html_nodes(text, "#target"))



