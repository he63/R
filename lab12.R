library(RSelenium)
story = NULL;
storypoint = NULL;
storyrecommend = NULL;
storytxt = NULL;

remDr <- remoteDriver(remoteServerAddr = "localhost" , 
                      port = 4445, browserName = "chrome")
url <- 'https://www.megabox.co.kr/movie-detail/comment?rpstMovieNo=21049700'
remDr$open()
remDr$navigate(url)
Sys.sleep(1)

pointdata <- remDr$findElements(using ="css selector","div.movie-idv-story div.story-point")
storypoint <- unlist(sapply(pointdata, function(x) {x$getElementText()}))
Sys.sleep(1)

recommenddata <- remDr$findElements(using ="css selector","div.movie-idv-story div.story-recommend")
storyrecommend <- unlist(sapply(recommenddata, function(x) {x$getElementText()}))
Sys.sleep(1)

txtdata <- remDr$findElements(using ="css selector","div.movie-idv-story div.story-txt")
storytxt <- unlist(sapply(txtdata, function(x) {x$getElementText()}))
Sys.sleep(1)


for (i in 2:10) {               
  nextCss <- paste("#contentData > div > div.movie-idv-story > nav > a:nth-child(",i,")", sep="")                
  try(nextListLink <- remDr$findElement(using='css selector',nextCss))
  if(length(nextListLink) == 0)   break;
  nextListLink$clickElement()
  Sys.sleep(1)
  
  pointdata <- remDr$findElements(using ="css selector","div.movie-idv-story div.story-point")
  storypoint1 <- unlist(sapply(pointdata, function(x) {x$getElementText()}))
  Sys.sleep(1)
  
  recommenddata <- remDr$findElements(using ="css selector","div.movie-idv-story div.story-recommend")
  storyrecommend1 <- unlist(sapply(recommenddata, function(x) {x$getElementText()}))
  Sys.sleep(1)
  
  txtdata <- remDr$findElements(using ="css selector","div.movie-idv-story div.story-txt")
  storytxt1 <- unlist(sapply(txtdata, function(x) {x$getElementText()}))
  Sys.sleep(1)
  
  storypoint <- c(storypoint, storypoint1)
  storyrecommend <- c(storyrecommend, storyrecommend1)
  storytxt <- c(storytxt, storytxt1)
}

story <- data.frame(storypoint, storyrecommend, storytxt)
write.csv(story, "output/movie.csv")
View(story)