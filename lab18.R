library(ggplot2)

# 문제 1
data <- read.csv("data/성적2.csv", encoding="UTF-8")

boxplot(data$국어, data$수학, range=1)
성명 <- data$성명
data$국어 <- ifelse(data$국어 > 10, mean(data$국어), data$국어)
data$수학 <- ifelse(data$수학 > 10, ceiling(mean(data$수학, na.rm = T)), data$수학)

data <- fill(data, c(국어, 수학), .direction = "updown")
View(data)

data_refine <- data %>% select(국어, 수학)
sketch <- ggplot(data_refine, aes(x = 국어, y = 수학))
sketch + geom_point(aes(fill=성명, size = 3, color = 성명))

dev.copy(png, "output/result1.png") 
dev.off()



# 문제 2
library(tidyr)
library(dplyr)

# 1
data_2 <- read.csv("data/reshapedata.csv")
longdata <- data_2 %>% gather(key="exam", value="jumsu", -name, -num)
View(longdata)

# 2
widedata <- longdata %>% spread(key = "exam", value = "jumsu")
View(widedata)

# 3
result <- longdata %>% separate(exam, into = c("subname", "subnum"))


# 문제 3
library(proxy)
library(tm)
#fruit <- c("사과 포도 망고 자몽 귤 오렌지 바나나 복숭아 자두")
fruit <- c("사과 포도 망고",
            "포도 자몽 자두",
            "복숭아 사과 포도",
            "오렌지 바나나 복숭아",
            "포도 바나나 망고",
            "포도 귤 오렌지")

cps <- VCorpus(VectorSource(fruit))
tdm <- TermDocumentMatrix(cps, control=list(wordLengths = c(1, Inf)))
inspect(tdm)
fruit_tdm <- as.matrix(tdm)
x <- fruit_tdm %*% t(fruit_tdm)  
(fruit_fav <- dist(x, method = "cosine"))

dtm <- DocumentTermMatrix(cps, control=list(wordLengths = c(1, Inf)))
fruit_dtm <- as.matrix(dtm)
y <- fruit_dtm %*% t(fruit_dtm)  
(fruit_sim <- dist(y, method = "cosine"))

rowSums(x)

# fruit_sim의 (3행, 1열)과 (5행, 1열)에 위치한 0.1097362가 가장 작은 수 이므로 ("또치" 와 "듀크"), ("듀크"와 "길동")이 가장 유사하다.

# rowSums(x)를 통해 포도가 15로 가장 높은 값이고, 귤이 3으로 가장 낮은 값이 나타난다.
# 가장 많이 선택된 과일은 "포도"이고, 가장 적게 선택된 과일은 "귤"이다.