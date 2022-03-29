library(plotrix)
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

# 문제1
(click <- read.table("data/product_click.log", header=TRUE))
(click <- table(click[,2]))
barplot(click, main='세로바 그래프 실습', col=terrain.colors(10))
dev.copy(png, "output/clicklog1.png") 
dev.off()

# 문제2
(click <- read.table("data/product_click.log", header=TRUE))
(click <- click[,1])
(click_time <- substr(click, 9, 10))
(click_time <- table(click_time))
time <- names(click_time)
time1 <- as.numeric(time)+1
pie(click_time, main='파이그래프 실습', labels=paste(time, "-", time1), col=rainbow(19), col.main="blue", family="maple", radius = 3.5)
dev.copy(png, "output/clicklog2.png") 
dev.off()

# 문제3
(score <- read.table("data/성적.txt", header=TRUE))
score1<- score[3:5] 
a <- t(score[2])
name <- a[1, 1:10]
rownames(score1) <- name
par(mar=c(5,5,5,5), mfrow=c(1,1))
par(xpd=T, mar=c(5,5,5,5))
barplot(t(score1), main='학생별 점수', col=rainbow(3), col.main="pink", family="maple")
legend(11,30, names(score1), cex=0.8, fill=rainbow(3))
dev.copy(png, "output/clicklog3.png") 
dev.off()

