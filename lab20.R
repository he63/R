library(showtext)
showtext_auto() 
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")


# 문제1
stats <- read_csv("data/picher_stats_2017.csv")


library(fmsb) 
score <- stats[2,] %>% select("승", "패", "삼진/9", "볼넷/9", "홈런/9")
max.score <- rep(100,5)          
min.score <- rep(0,5)           
ds <- rbind(max.score,min.score, score)
ds <- data.frame(ds)          
colnames(ds) <- c("승", "패", "삼진", "볼넷", "홈런")
ds
radarchart(ds,
           pcol='dark green',           
           pfcol=rgb(0.2,0.5,0.5,0.5),   
           plwd=3,                       
           cglcol='pink',               
           cglty=1,                    
           cglwd=0.8,                  
           axistype=1,                   
           seg=4,                                      
           axislabcol='green',         
           caxislabels=seq(0,100,25),
           title = "소사 선수의 성적",
           family="maple"
           )
dev.copy(png, "output/lab20.png")
dev.off()


# 문제2
library(ggplot2)
data("iris")

#1
summary(iris$Sepal.Width)

#2
hist(iris$Sepal.Width, main="꽃받침 너비", family="maple", xlab="Sepal.Width", ylab="Frequency")

#3
aggregate(iris$Sepal.Width, by=list(species = iris$Species), FUN='min')

#4
aggregate(iris$Sepal.Width, by=list(species = iris$Species), FUN='max')
aggregate(iris$Sepal.Width, by=list(species = iris$Species), FUN='min')
    # setosa가 분포가 가장 넓다.

#5
test <- iris %>% filter(Species == "virginica")
test <- test[,1:4]

#6
cor(test) 
#              Sepal.Length Sepal.Width Petal.Length Petal.Width
# Sepal.Length    1.0000000   0.4572278    0.8642247   0.2811077

# 자신을 제외한 3가지중 Petal.Length의 상관계수가 가장 높다.

