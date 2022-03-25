library(rvest)

site <- "https://comic.naver.com/genre/bestChallenge?&page="
text <- NULL
comic <- NULL
for (page_num in 1:50){
  url <- paste(site, page_num, sep="")
  text <- read_html(url)
  comic.name <- html_text(html_nodes(text, xpath = '//*[@id="content"]/div/table/tr/td/div[2]/h6/a'), trim = T)
  comic.summary <- html_text(html_nodes(text, xpath = '//*[@id="content"]/div/table/tr/td/div[2]/div[1]'))
  comic.grade <- html_text(html_nodes(text, xpath = '//*[@id="content"]/div/table/tr/td/div[2]/div[2]/strong'))
  page <- data.frame(comic.name, comic.summary, comic.grade)
  comic <- rbind(comic, page)
}
write.csv(comic, file='output/navercomic.csv')
