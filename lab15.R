library(plotrix)

# 문제1
(pro_c <- read.table("data/product_click.log", header=TRUE))
pro_c1 <- substr(pro_c[,1],1,4)
pro_c2 <- substr(pro_c[,1],5,6)
pro_c3 <- substr(pro_c[,1],7,8)
pro_date <- paste(pro_c1, pro_c2, pro_c3, sep = "-")
pro_date <- as.Date(pro_date)
pro_wd <- weekdays(pro_date)
click_wd <- table(pro_wd)
ord <- c(4, 6, 3, 2, 1, 5)
click_wd <- click_wd[ord]
par(mar=c(5,5,5,5), mfrow=c(1,2))
plot(click_wd, type="o", main="요일별 클릭 수", col="orange", family="cat", xlab="", ylab="", ylim=c(0, 300)) 
barplot(click_wd, main="요일별 클릭 수", col=rainbow(6), family="cat", xlab="", ylab="", ylim=c(0, 300)) 
dev.copy(png, "output/clicklog4.png", height=1000, width=1800) 
dev.off()

# 문제2
movie_re <- read.csv("data/movie_reviews3.csv")
movie_re <- movie_re[,3]

par(mar=c(5,5,5,5), mfrow=c(1,3))

hist(movie_re, main="영화 평점 히스토그램(auto)", col=rainbow(6), family="maple", xlab="평점", ylab="평가지수", ylim=c(0, 500))
hist(movie_re, breaks =c(1,5,10), main="영화 평점 히스토그램(1~5,6~10)", col=rainbow(6), family="maple", xlab="평점", ylab="평가지수", freq=TRUE)
hist(movie_re, breaks=c(1,5,6,7,8,9,10), main="영화 평점 히스토그램(1~5,6,7,8,9,10)", xlab="평점", ylab="평가지수", freq=TRUE)
dev.copy(png, "output/clicklog5.png", height=1000, width=1800) 
dev.off()


# 문제3
one <- read.csv("data/one.csv")
loc <- one[,1]
one_hh <- one[,3]
one <- data.frame(loc, one_hh)
par(mar=c(5,5,5,5), mfrow=c(1,1))
boxplot(one_hh~loc, data=one, main='구별 1인가구', col=rainbow(10), las = 2, xlab="", ylab="", family="maple")
dev.copy(png, "output/clicklog6.png", height=1000, width=1800) 
dev.off()

