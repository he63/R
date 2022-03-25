library(rvest)

url <- "https://comic.naver.com/genre/bestChallenge?&page="
text <- read_html(url)
text

comic.name <- html_text(html_nodes(text, xpath = '//*[@id="content"]/div/table/tr/td/div[2]/h6/a'), trim = T)
comic.name

comic.summary <- html_text(html_nodes(text, xpath = '//*[@id="content"]/div/table/tr/td/div[2]/div[1]'))

comic.grade <- html_text(html_nodes(text, xpath = '//*[@id="content"]/div/table/tr/td/div[2]/div[2]/strong'))


DataFrame <- data.frame(comic.name, comic.summary, comic.grade)
View(DataFrame)


