library(dplyr)
library(tidyr)
library(ggplot2)
library(kormaps2014)
library(dplyr)
library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")


#자살
자살 <- read.csv("data/자살.csv")
자살 <- 자살[,2]

# CCTV
CCTV <- read.csv("data/CCTV.csv")
CCTV <- CCTV[,2]

# 경찰 1인당 담당 인구수
cop <- read.csv("data/경찰관 1인당 담당 인구수.csv")
cop <- na.omit(cop)
cop <- cbind(cop, code)
cop <-cop[,c(3,4)]
colnames(cop) <- c("인구", "담당인구")

# 지역별 범죄 발생 수
crime <- read.csv("data/범죄 발생 지역별 통계.csv")

crime <- crime %>% group_by("범죄대분류") %>% select(-"범죄중분류") 
crime <- aggregate(crime[2:87], by=list(crime$범죄대분류), FUN='sum')
경기도 <- crime %>% select(starts_with("경기")) %>% group_by(1:16) %>% rowSums()
강원도 <- crime %>% select(starts_with("강원")) %>% group_by(1:16) %>% rowSums()
충청도 <- crime %>% select(starts_with("충")) %>% group_by(1:16) %>% rowSums()
전라도 <- crime %>% select(starts_with("전")) %>% group_by(1:16) %>% rowSums()
경상도 <- crime %>% select(starts_with("경상"), starts_with("경남")) %>% group_by(1:16) %>% rowSums()
제주도 <- crime %>% select(starts_with("제주")) %>% group_by(1:16) %>% rowSums()
crime <- crime[,c(1:9)]
code <- c(11, 21, 22, 23, 24, 25, 26, 29, 31, 32, 33, 35, 37, 38)
crime <- cbind(crime, 경기도, 강원도, 충청도, 전라도, 경상도, 제주도)
as.data.frame(crime)
rownames(crime) <- c(crime[,1])
crime <- crime[2:15]
crime <- t(crime)
crime <- cbind(crime, code, cop, CCTV, 자살)
crime <- as.data.frame(crime)
View(crime)
copperpop <- crime[,c(2,19)]

# 다중회귀분석 
crime_lm <- lm(계 ~ 인구 + 담당인구 + CCTV + 자살 , data = crime)


# 후진 소거법을 통해 변수 선택
step_crime <- step(crime_lm, direction = "backward")

# p값이 높은 변수를 제외하고 다시 회귀분석
crime_lm <- lm(계 ~ 인구 + CCTV + 자살 , data = crime)
par(mfrow=c(2,2))
plot(crime_lm)


# 경상도가 이상치로 나타나므로 경상도 값을 제외하고 다시 회귀분석
crime1 <- crime[-13,]
crime_lm <- lm(계 ~ 인구 + CCTV + 자살 , data = crime1)
par(mfrow=c(2,2))
plot(crime_lm)


# 범죄율
범죄율 <- crime$계/crime$인구

par(mfrow=c(1,1))
# 한국 범죄 분포도
ggplot(crime,aes(map_id=code, fill=계))+
  geom_map(map = kormap1, colour="black",size=0.1)+
  expand_limits(x= kormap1$long,y = kormap1$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('한국 범죄 분포도')+coord_map()

# 경찰 당 담당 인구수
ggplot(crime,aes(map_id=code, fill=담당인구))+
  geom_map(map = kormap1, colour="black",size=0.1)+
  expand_limits(x= kormap1$long,y = kormap1$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('경찰 당 담당 인구수')+coord_map()

# 범죄율
ggplot(crime,aes(map_id=code, fill=범죄율))+
  geom_map(map = kormap1, colour="black",size=0.1)+
  expand_limits(x= kormap1$long,y = kormap1$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('범죄율')+coord_map()



# 경찰 당 담당인구에 비례한 범죄율
plot(copperpop$담당인구, copperpop$계)
cor(copperpop$담당인구, copperpop$계)
cor.test(copperpop$담당인구, copperpop$계)
factory.lm = lm(계 ~ 담당인구, data = copperpop)
summary(factory.lm)
abline(factory.lm, col="red") 



# 범행 동기 및 그래프 
범행동기 <- read.csv("data/범행동기.csv")
범행동기 <- 범행동기 %>% group_by("범죄대분류") %>% select(-"범죄중분류")
범행동기 <- aggregate(범행동기[2:16], by=list(범행동기$범죄대분류), FUN='sum')
강력범죄동기 <- 범행동기[1,]
View(강력범죄동기)


# 강력범죄 범행동기
data <- c(700, 464, 28, 12, 48, 1380, 77, 6, 237, 1104, 1012, 7459, 278, 321, 6059)
dataname <- c("생활비", "유흥비", "", "", "", "이욕.기타", "", "", "가정불화", "호기심", "유혹", "우발적", "현실불만", "부주의", "기타")
dataname <- dataname[order(data)]
data <- data[order(data)]
pie(data, dataname, col=rainbow(15),radius = 1, family="maple", main = "범행동기")
  # 강력범죄는 우발적인 경우가 가장 많다.




# CCTV 대수 증가량
CCTV <- read.csv("data/cctv증감량.csv")
CCTV <- CCTV %>% select(CCTV계)

# 서울시 범죄 통계
seoulcrime <- read.csv("data/범죄 통계.csv")
seoulcrime <- seoulcrime %>% select(합계)
colnames(seoulcrime) <- "범죄 수"

# CCTV대수 증가에 따른 범죄 통계
crime.data <- data.frame(CCTV, seoulcrime)
plot(crime.data$CCTV계, crime.data$범죄.수, main = "CCTV 증가에 따른 범죄 증감")
cor(crime.data$CCTV계, crime.data$범죄.수)
cor.test(crime.data$CCTV계, crime.data$범죄.수)
factory.lm = lm(범죄.수 ~ CCTV계, data = crime.data)
summary(factory.lm)
abline(factory.lm, col="red") 

# 자살 수의 증가에 따른 범죄 수
crime.suicide <- data.frame(자살, crime$계)
plot(자살, crime$계, main = "자살과 범죄 수의 관계")
cor(자살, crime$계)
cor.test(자살, crime$계)
factory.lm = lm(crime$계 ~ 자살, data = crime.data)
summary(factory.lm)
abline(factory.lm, col="red") 


# 회귀식
# 범죄.수 = 3.895e+05 - (6.662e-02 * CCTV계)

# 평균 연령과 소득에 따른 범죄 수 통계
age.avg <- read.csv("data/연령 소득.csv")
age.avg <- age.avg[,2:3]
age.avg <- cbind(age.avg, 범죄수 = seoulcrime[1:10,])

# 소득의 증가에 따른 범죄 수
plot(age.avg$소득, age.avg$범죄수, main = "소득과 범죄 수의 관계")
cor(age.avg$소득, age.avg$범죄수)
cor.test(age.avg$소득, age.avg$범죄수)
factory.lm = lm(범죄수 ~ 소득, data = age.avg)
summary(factory.lm)
abline(factory.lm, col="red") 


# 연령분포에 따른 범죄 수
plot(age.avg$가구주연령, age.avg$범죄수, main = "연령과 범죄 수의 관계")
cor(age.avg$가구주연령, age.avg$범죄수)
cor.test(age.avg$가구주연령, age.avg$범죄수)
factory.lm = lm(범죄수 ~ 가구주연령, data = age.avg)
summary(factory.lm)
abline(factory.lm, col="red") 


# 성별 연령
age.man <- read.csv("data/남자연령.csv")
age.woman <- read.csv("data/여자연령.csv")

df <- data.frame(연도 = rep(c("2012년", "2013년", "2014년", "2015년", "2016년", "2017년", "2018년", "2019년", "2020년"), each = 7),
                 연령 = rep(c("20세이하", "21.30세", "31.40세", "41.50세", "51.60세", "61.70세", "71세이상"), 9),
                범죄수 = c(24744, 43849, 63099, 92983, 69461, 17789, 4735, 21114, 43749, 62519, 89991, 70470, 18668, 5384, 18139, 42086, 61431, 89826, 75861, 21306, 6412, 20183, 46501, 63439, 90448, 79958, 24304, 7595, 20263, 49189, 66057, 90178, 83034, 27759, 8826, 20697, 46644, 60108, 81420, 79351, 29196, 9285, 19352, 44915, 58513, 78299, 78649, 32590, 10515, 19284, 47006, 59958, 79381, 82373, 37621, 12831, 18347, 46115, 53613, 69783, 76863, 38332, 13266))


# 성별에 따른 범죄 수
barplot(man, main='성별에 따른 범죄 빈도', 
        col=c('blue','yellow'),
        beside=TRUE,
        legend.text=T,
        args.legend = list(x='topright', bty='n', inset=c(-0.25,0)))

# 연령별 범죄 산포도
ggplot(data=df, aes(x = 연령, y = 범죄수)) +
  geom_line(color="blue", size=1.2)+
  geom_point(color="red", size=3)+
  ggtitle("연령에 따른 범죄 수")

# 연령의 증가에 따른 범죄 수.
some <- cumsum(df[57:63,3])
df_c <- data.frame(연령 = c(10, 20, 30, 40, 50, 60, 70), 범죄 = some)
plot(df_c$연령, df_c$범죄, main = "연령과 범죄 수의 관계")
cor(df_c$연령, df_c$범죄)
cor.test(df_c$연령, df_c$범죄)
factory.lm = lm(범죄 ~ 연령, data = df_c)
summary(factory.lm)
abline(factory.lm, col="red") 



#############################################################################


#
df <- data.frame(연도 = rep(c("2012년", "2013년", "2014년", "2015년", "2016년", "2017년", "2018년", "2019년", "2020년"), each = 7),
                   연령 = rep(c("20세이하", "21.30세", "31.40세", "41.50세", "51.60세", "61.70세", "71세이상"), 9),
                   범죄수 = c(24744, 43849, 63099, 92983, 69461, 17789, 4735, 21114, 43749, 62519, 89991, 70470, 18668, 5384, 18139, 42086, 61431, 89826, 75861, 21306, 6412, 20183, 46501, 63439, 90448, 79958, 24304, 7595, 20263, 49189, 66057, 90178, 83034, 27759, 8826, 20697, 46644, 60108, 81420, 79351, 29196, 9285, 19352, 44915, 58513, 78299, 78649, 32590, 10515, 19284, 47006, 59958, 79381, 82373, 37621, 12831, 18347, 46115, 53613, 69783, 76863, 38332, 13266))

df_c <- data.frame(연령 = c(10, 20, 30, 40, 50, 60, 70), 범죄 = df$범죄수)
plot(df_c$연령, df_c$범죄, main = "연령과 범죄 수의 관계")
cor(df_c$연령, df_c$범죄)
cor.test(df_c$연령, df_c$범죄)
factory.lm = lm(범죄 ~ 연령, data = df_c)
summary(factory.lm)
abline(factory.lm, col="red") 

# 범죄수 = 54177 - (age - 40)^2
# 범죄수 = 54177 - age^2 + 80age - 160
# b0 =  54017, b1 = 80, b2 = -1

# 범죄수 = b0+ b1*age + b2*age^2 + 오차항
df <- data.frame(연도 = rep(c("2012년", "2013년", "2014년", "2015년", "2016년", "2017년", "2018년", "2019년", "2020년"), each = 7),
                   연령 = rep(c("20세이하", "21.30세", "31.40세", "41.50세", "51.60세", "61.70세", "71세이상"), 9),
                   범죄수 = c(24744, 43849, 63099, 92983, 69461, 17789, 4735, 21114, 43749, 62519, 89991, 70470, 18668, 5384, 18139, 42086, 61431, 89826, 75861, 21306, 6412, 20183, 46501, 63439, 90448, 79958, 24304, 7595, 20263, 49189, 66057, 90178, 83034, 27759, 8826, 20697, 46644, 60108, 81420, 79351, 29196, 9285, 19352, 44915, 58513, 78299, 78649, 32590, 10515, 19284, 47006, 59958, 79381, 82373, 37621, 12831, 18347, 46115, 53613, 69783, 76863, 38332, 13266))

df_c <- data.frame(연령 = c(10, 20, 30, 40, 50, 60, 70), 범죄 = df$범죄수)
plot(df_c$연령, df_c$범죄, main = "연령과 범죄 수의 관계")
cor(df_c$연령, df_c$범죄)
cor.test(df_c$연령, df_c$범죄)
criminal = 54016 - (-193.5)^2 + 80 * (-193.5)
factory.lm = lm(criminal ~ poly(age, 2, raw = T))
summary(factory.lm)



#################################################
# 이차곡선
df <- data.frame(year = rep(c("2012년", "2013년", "2014년", "2015년", "2016년", "2017년", "2018년", "2019년", "2020년"), each = 7),
                 age = rep(c("20세이하", "21.30세", "31.40세", "41.50세", "51.60세", "61.70세", "71세이상"), 9),
                 criminal = c(24744, 43849, 63099, 92983, 69461, 17789, 4735, 21114, 43749, 62519, 89991, 70470, 18668, 5384, 18139, 42086, 61431, 89826, 75861, 21306, 6412, 20183, 46501, 63439, 90448, 79958, 24304, 7595, 20263, 49189, 66057, 90178, 83034, 27759, 8826, 20697, 46644, 60108, 81420, 79351, 29196, 9285, 19352, 44915, 58513, 78299, 78649, 32590, 10515, 19284, 47006, 59958, 79381, 82373, 37621, 12831, 18347, 46115, 53613, 69783, 76863, 38332, 13266))

df_c <- data.frame(age = c(10, 20, 30, 40, 50, 60, 70), criminal = df$criminal)
plot(df_c$age, df_c$criminal, main = "연령과 범죄 수의 관계")
cor(df_c$age, df_c$criminal)
cor.test(df_c$age, df_c$criminal)
criminal = 54016 - (-193.5)^2 + 80 * (-193.5)
factory.lm = lm(df_c$criminal ~ poly(df_c$age, 2, raw = T), data = df_c)
summary(factory.lm)

for( degree in 1:2){
  FLEXIBLE_MODEL = lm(criminal ~ poly(df_c$age,degree),data = df_c)
}
  
library(ggplot2)

ggplot(df_c) +
  geom_point(aes(x= age , y = criminal) , col = 'royalblue', alpha = 0.8) +
  geom_smooth(aes(x = age, y = predict(FLEXIBLE_MODEL, newdata = df_c,col = 'red'))) +
  xlab("") + ylab("") + ggtitle("연령과 범죄 수의 관계") 

  