install.packages("corrplot") 
install.packages("psych") 
install.packages("corrgram")
install.packages("car")
install.packages("gvlma")
install.packages("leaps")

### 데이터의 정규성 검정 ###
##

(ex<-rnorm(30,5,10))
plot(ex)
hist(ex)
shapiro.test(ex)
qqnorm(ex)
qqline(ex)


plot(iris$Sepal.Length)
hist(iris$Sepal.Length)
qqnorm(iris$Sepal.Length)
qqline(iris$Sepal.Length)
shapiro.test(iris$Sepal.Length)
shapiro.test(log(iris$Sepal.Length))
qqnorm(log(iris$Sepal.Length))
qqline(log(iris$Sepal.Length))

### 데이터의 등분산성 검정 ###
##
x <- rnorm(50, mean = 0, sd = 2)
y <- rnorm(30, mean = 1, sd = 1)
z <- rnorm(30, mean = 3, sd = 2)


var.test(x, y) 
var.test(x, z) 


### 상관분석과 상관분석 검정 ###

myiris <- iris[-5]
cor(myiris)
cor.test(myiris$Sepal.Length, myiris$Sepal.Width)
cor.test(myiris$Sepal.Length, myiris$Petal.Length)
cor.test(myiris$Sepal.Length, myiris$Petal.Width)
cor.test(myiris$Sepal.Width, myiris$Petal.Length)
cor.test(myiris$Sepal.Width, myiris$Petal.Width)
cor.test(myiris$Petal.Width, myiris$Petal.Length)

library(psych)
lowerCor(myiris, use="pairwise")
corr.test(myiris, use="pairwise")
corPlot(myiris, numbers=T, stars=T, upper=F, diag=F)

# 상관분석 결과를 보다 잘 표현할 수 있는 상관분석 관련 시각화 패키지들 소개
library(corrplot)  # corrplot 패키지 불러오기

car_cor <- cor(mtcars[, -12])
round(car_cor,2)
corrplot(car_cor)
corrplot(car_cor, order="hclust")
corrplot(car_cor, type="lower", order="hclust", tl.srt=45)
corrplot(car_cor, method="ellipse", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="number", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="shade", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="color", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="pie", type="lower", order="hclust", tl.srt=45, diag=F)
corrplot(car_cor, method="color", type="lower", order="hclust", tl.srt=45)
corrplot(car_cor, method="color", addCoef.col="black", type="lower", order="hclust", tl.srt=45)
corrplot(car_cor, method="color", addCoef.col="black", type="lower", diag=F, tl.srt=45)


library(psych)
pairs.panels(state.x77, bg="red", pch=21, hist.col="gold", 
             main="Correlation Plot of US States Data")



library(corrgram)
corrgram(state.x77, order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Corrgram of US States Data")


cols <- colorRampPalette(c("darkgoldenrod4", "burlywood1", 
                           "darkkhaki", "darkgreen"))
corrgram(state.x77, order=FALSE, col.regions=cols,
         lower.panel=panel.pie, upper.panel=panel.conf, 
         text.panel=panel.txt, main="Corrgram of US States Data")



####################################
## 단순 선형 회귀 분석

# 사전 작업
plot(cars$speed, cars$dist)
cor(cars$speed, cars$dist)

# 단순 선형 회귀분석
model = lm(dist ~ speed, data = cars) # speed를 이용하여 dist를 예측하는 수식

summary(model)
abline(model, col="red")  # 회귀선
model$residuals
residuals(model)

plot(model, 1)
plot(model, 2)
shapiro.test(model$residuals)
plot(model, 3)
plot(model, 4)
plot(model)

# 심하게 이상치로 판정되는 49번째 데이터를 제외한 후에 다시 단순 선형 회귀분석 실시
cars1 <- cars[-49,]

model1 = lm(dist ~ speed, data = cars1)

summary(model1)

plot(model1, 1)
plot(model1, 2)
shapiro.test(model1$residuals)
plot(model1, 3)
plot(model1, 4)



# 예측
# 회귀식 : 3.6396 * speed - 14.0021
df <- data.frame(speed = c(10, 18, 30))

predict.lm(model1, newdata = df)

3.6396 * df  -14.0021


####################################################
## 다중회귀분석 (multiple linear regression)

## 다중회귀분석 예제 1
# 엄마와 아빠 키로 아들의 키를 예측하는 다중선형회귀모델 생성 
height_father <- c(180, 172, 150, 180, 177, 160, 170, 165, 179, 159) # 아버지 키 
height_mohter <- c(160, 164, 166, 188, 160, 160, 171, 158, 169, 159) # 어머니 키
height_son <- c(180, 173, 163, 184, 165, 165, 175, 168, 179, 160) # 아들 키 
height <- data.frame(height_father, height_mohter, height_son)
head(height) 

model <-lm (height_son ~ height_father + height_mohter, data = height)
model 


# 결정계수와 수정된 결정계수
summary(model)

(coef_r <- coef(model))
coef_r[1]
coef_r[2]
coef_r[3]

# 잔차 
r <- residuals(model)
r[1:4]

# 예측 
predict.lm(model, newdata = data.frame(height_father = 170, height_mohter = 160))
predict.lm(model, newdata = data.frame(height_father = 170, height_mohter = 160), interval = "confidence")


## 다중회귀분석 예제 2
head(state.x77) # 미국 50개 주의 인구, 소득, 문맹률 등에 대한 데이터
# state.x77 데이터 중에서 5개 변수만 선정한 데이터프레임을 만든다
states <- data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
head(states)
cor(states)
str(states)

lowerCor(states, use="pairwise")
corr.test(states, use="pairwise")
corPlot(states, numbers=T, stars=T, upper=F, diag=F)


# 다중회귀분석 실행
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
summary(fit)

op <- par(mfrow=c(2,2)) # 2 x 2 pictures on one plot
plot(fit)
par(op)
plot(fit, 4)
plot(fit,2)

fita <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states[-28, ])
summary(fita)
op <- par(mfrow=c(2,2)) # 2 x 2 pictures on one plot
plot(fita)
par(op)


# 모형비교 (model comparison)

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
fit2 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(fit1)
summary(fit2)
AIC(fit, fit2)


# 최선의 모형 선택 (selecting the "best" model)

library(MASS)
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
step(fit, direction="backward") 


library(leaps)
library(RColorBrewer)
states.regsubsets <- regsubsets(x=Murder ~ Population + Illiteracy + Income + Frost, data=states, nbest=4)

plot(states.regsubsets, scale="adjr2", col=brewer.pal(9, "Pastel1"),
     main="All Subsets Regression")


# 또 다른 예
mtcars.regsubsets <- regsubsets(x=mpg ~ hp + wt + disp + drat, data=mtcars, nbest=4)

plot(mtcars.regsubsets, scale="adjr2", col=brewer.pal(9, "Pastel1"),
     main="All Subsets Regression")



# 다중공선성 검정 사례

head(mtcars)
mtcars2 <- data.frame(mtcars[, c(1,3,4,6)])
corr.test(mtcars2, use="complete")

fit <- lm(mpg ~ disp + hp + wt, data=mtcars2)
summary(fit)
library(car)
vif(fit)


fit <- lm(mpg ~ hp + wt, data=mtcars2)
summary(fit)
vif(fit)

# 종속변수의 정규분포 가정을 위반하는 문제 해결하기
shapiro.test(cars$dist)
shapiro.test(cars$speed)
# 종속변수의 변환(transformation)
op <- par(mfrow=c(2,2))
plot(dist~speed, data=cars) 
plot(log(dist)~speed, data=cars) 
plot(sqrt(dist)~speed, data=cars) 
par(op)


# 종속변수를 제곱근으로 변환한 후 모형분석 그리고 회귀진단
out2 <- lm(sqrt(dist) ~ speed, data=cars)
summary(out2)

plot(sqrt(dist)~speed, data=cars, col="blue")
abline(out2, col="red")

op <- par(mfrow=c(2,2))
plot(out2)  
par(op)


###################################################################
## 상관분석과 회귀분석 응용
## 통계분석과 기본 그래프
## 김 대표의 양계장에는 7개의 부화장이 있고 부화장마다 최대 30개의 알을 부화시킬 수 있다.
## 병아리는 부화하는데 걸리는 기간이 약 21일이다.
## 어제까지 딱 21일이 지났다. 총 몇마리의 병아리가 부화했는지 알아보자.
## (1) 어제까지 몇 마리의 병아리가 부화했을까? (기초통계량)

# 데이터 파일 읽어오기
hat <- read.csv("data/data1.csv")
hat

head(hat)
tail(hat)

# 합계 구하기
sum(hat$chick)

# 평균 구하기
mean(hat$chick)

# 표준편차 구하기
sd(hat$chick)

# 중앙값 구하기
median(hat$chick)

# 최소값 구하기
min(hat$chick)

# 최대값 구하기
max(hat$chick)

# 데이터 정렬하기
hat_asc <- hat[order(hat$chick),] # chick 열을 기준으로 오름차순 정렬
hat_asc

# 간단한 그래프를 그려서 보자
# 막대그래프
barplot(hat$chick)

# 다양한 옵션을 통해 막대그래프 정보를 추가하자
barplot(hat$chick, names.arg = hat$hatchery,
        col = c("red","orange","yellow","green", "blue", "navy", "violet"), 
        main = "부화장별 병아리 부화현황", xlab = "부화장", ylab = "병아리수",
        ylim = c(0,35), family="dog")


library(RColorBrewer) # RColorBrewer 패키지 현재 작업 환경으로 불러오기
display.brewer.all()

col7 <- brewer.pal(7, "Pastel2")  # col7이라는 변수에 "Pastel2"라는 팔레트에서 7개의 색상을 집어넣음
col7

barplot(hat$chick, names.arg = hat$hatchery,
        col = col7, 
        main = "부화장별 병아리 부화현황", xlab = "부화장", ylab = "병아리수",
        ylim = c(0,35), family="dog")


bar_x <- barplot(hat$chick)  # bar_x 변수에 barplot의 x좌표 집어넣음

# 위에 bar_x 라는 변수를 만들어주는 이유는 x좌표를 알아내기 위함임
bar_x

# 다시 예쁜 그래프 기리기
barplot(hat$chick, names.arg = hat$hatchery,
        col = col7, 
        main = "부화장별 병아리 부화현황", xlab = "부화장", ylab = "병아리수",
        ylim = c(0,35), family="dog")
# 막대그래프에 text 추가, pos는 라벨의 위치
text(x = bar_x, y = hat$chick, labels = hat$chick, pos = 3, , family="dog")
# 막대그래프에 30기준으로 빨간색 점선 추가
abline(h = max(hat$chick), col = "red", lty = 2, lwd = 1)

# 파이차트 그리기
# 파이차트 그리기에 앞서 Percentage 열 만들어줌
hat$pct <- round(hat$chick/sum(hat$chick)*100, 1)
hat

# 파이차트 그리기
pie(hat$chick, labels = paste(hat$hatchery, hat$pct, "%"), 
    col = col7, clockwise = TRUE, 
    main = "부화장별 병아리 부화 비율", family="dog")


## 체계적인 사육을 위해 김대표는 부화된 병아리 모두에 GPS 위치추적기가 탑재된 Tag를 부착해
## 병아리 개별 데이터를 수집하기로 했다. 먼저 병아리들의 몸무게를 측정한다.

## 정규분포 : 수집된 데이터들의 평균 근처에 값이 모여 있는 연속 확률분포
## 평균값과 표준편차에 의해 모양이 결정되는 연속확률분포
##            주변에서 흔히 볼 수 있는 데이터들의 분포는 대부분 정규분포
## 중심극한정리 : 데이터가 적당히 많을 경우(일반적으로 30이상) 정규분포에 가까워 진다.
##                평균값과 표준편차만 알아도 대략적인 데이터의 분포를 알아낼 수 있다.

## (2) 부화한 병아리들의 체중은 얼마일까? (정규분포와 중심극한정리)

# 샘플 병아리 데이터를 불러오기
b <- read.csv("data/data2.csv")

head(b)
str(b)
summary(b)

# B 부화장 병아리 무게 표준편차
sd(b$weight)

## (참고)정규분포 그래프 설명용 그리기
x <- seq(-5, 5, length = 500)
y1 <- dnorm(x, mean = 0, sd = 1)
y2 <- dnorm(x, mean = 0, sd = 2)

plot(x, y1, type = "l", col = "blue", ylabel = NULL, xlabel = NULL, main = "표준편차(1, 2)에 따른 정규분포 비교")
lines(x, y2, type = "l", col = "red")
legend("topright", c("X~N(0,1)","X~N(0,4)"), text.col = c("blue", "red"))
##########################################################################

# Histogram으로 분포 확인
hist(b$weight, col = "sky blue", xlab = "병아리 무게(g)", main = "B 부화장 병아리 무게 분포 현황")

# Box-Plot으로 분포 확인
boxplot(b$weight, col = "sky blue", main = "B 부화장 병아리 무게 상자그림")

# 히스토그램과 Box-Plot을 같이 그리기
par(mfrow=c(2,1))  # 행 2개, 열 1개
hist(b$weight, col = "sky blue", xlab = "병아리 무게(g)", , main = "B 부화장 병아리 무게 분포 현황")
boxplot(b$weight, horizontal = TRUE, col = "sky blue")
par(mfrow=c(1,1)) 

## 히스토그램과 상자그림을 통해 병아리의 몸무게가 어느 정도인지 확인한 결과 30마리의 체중이
## 30~45g 사이에 분포하며 그중 절반은 36.25(1사분위 수)~40.75(3사분위 수) 사이에 분포한다는
## 것을 파악할 수 있다.

## 병아리가 부화한지 5일이 지났다. 그런데 이상한 점을 발견했다. 부화장 A에서 태어난 병아리 
## 대비 부화장 B에서 태어난 병아리의 덩치가 더 작아 보인다. 서로 다른 사료를 먹이고 있기는
## 한데 기분 탓인지, 아니면 정말 작인지 검정해 보자.

## (3) 사료 제조사별 성능차이가 있을까? (가설검정)

# 파일의 데이터 불러오기
test <- read.csv("data/data3.csv")
test

# 상자그림을 2개 그려서 비교해봄
boxplot(weight ~ hatchery, data = test, 
        horizontal = TRUE, col = c("light green", "sky blue"),
        ylab= "부화장", xlab = "몸무게 분포",
        main = "부화장 A vs. B 몸무게 분포 비교")

## 통계적으로 두 집단의 몸무게가 같은지 다른지는 어떻게 설명할 수 있을까?
## 이럴 때 사용하는 것이 바로 가설검정이다.
## 가설검정이란 통계추론의 영역으로 "비교하는 값과 차이가 없다"는 가정의 귀무가설과
## 반대인 대립가설을 설정해서 검정 통계량으로 가설의 진위를 판단하는 방법이다.

## 두 집단의 몸무게 평균이 같은지 다른지 가설검정의 방법론인 t-test를 통해 진행한다.
## t-test는 데이터가 정규분포를 한다는 가정하에 평균의 데이터의 대푯값을 한다고 전제한다.
## 따라서 t-test를 수행하기 전에 데이터가 정규분포를 따르는지 검정한다.
## 데이터의 정규성 검정 : 샤피로 월크 검정 
##    귀무가설 : 정규 분포한다. 대립가설 : 정규분포하지 않는다.
##    95% 신뢰수준을 적용하여 계산되는 유의확률(p값)이 0.05 보다 작으면 귀무가설을 기각하고
##    0.05 보다 크면 귀무가설을 채택한다. 유의확률(p값)이란 귀무가설을 지지하는 정도이다.
# 두 집단이 우선 정규분포를 따르고 있는지 샤피로 월크 검정 실시한다.

a <- subset(test$weight, test$hatchery == 'A')
b <- subset(test$weight, test$hatchery == 'B')
shapiro.test(a)
shapiro.test(b)

## 부화 후 일주일 뒤 각각 다른 사료를 먹고 키운 병아리의 성장에 차이가 있을까?
## 두 집단의 평균이 다르다고 할 수 있을까? -> t-test 를 통해서 검정 - 계산되는 유의확률 p 값으로 결정
##    귀무가설 :두 집단의 평균에 차이가 없다.  대립가설 :두 집단의 평균에 차이가 있다.                             

t.test(data = test, weight ~ hatchery) 

# 결과해석 : p값이 0.01094로 0.05보다 작으므로 귀무가설을 기각하고 대립가설을 채택함, 
# 즉 두 집단의 평균은 다름


## 상관분석과 회귀분석
## 상관분석과 회귀분석은 데이터 분석 모델을 만들기 위한 가장 기초적인 관문이다. 
## 상관분석은 변수와 변수의 관계가 서로 비례 또는 반비례 관계인지 + 와 - 부호로 표현하고
## 회귀분석은 서로 상관관계가 있는 연속형 변수들의 관계를 수식으로 나타낸다.

## 병아리의 성장(체중)에 영향을 미치는 인자는 무엇일까? (상관분석)
## 유전적인 요소? 사료의 양?

# 데이터 불러오기
w <- read.csv("data/data4.csv")

head(w)
tail(w)
str(w)

# w 데이터 셋에서 2~5열 데이터만 가져오기(첫열은 character이므로)
w_n <- w[,2:5]
head(w_n)

# 위와 동일
w_n <- subset(w, select = -c(chick_nm))

head(w_n)

## 상관분석을 실시하면 두 변수 간의 관계를 상관 계수로 나타낸다.
## 상관계수는 두 변수 간에 연관된 정도만 나타낼 뿐 인과관계(원인-결과)를 설명하는 것은 아니다.
## 상관계수는 -1~1사이의 값을 갖는다. 

w_cor <- cor(w_n)  # w_n 데이터 셋으로 상관분석한 결과를 w_cor변수에 넣음
w_cor  # w_cor 상관분석 결과 확인

## 상관분석을 통하여 얻은 상관계수가 과연 통계적으로도 유의한가?
## 유의성 검정의 귀무가설 : 두 변수는 선형관계가 없어 상관계수가 0이다. 
## 유의성 검정의 연구가설 : 두 변수 간에는 선형관계가 존재하여 상관계수가 0이 아니다.
cor.test(w_n$weight, w_n$egg_weight)
cor.test(w_n$weight, w_n$movement)
cor.test(w_n$weight, w_n$food)

plot(w_n)  # w_n 데이터 셋 산점도로 표현

# 그냥 한번 실행해보기(주의할 점은 데이터셋이 아닌 상관분석결과를 넣어야함)
corrplot(w_cor)  # 상관분석 결과인 w_cor을 corrplot 패키지로 실행해보기

# 원을 타원으로 표시하고, 하단에만 표시하고, 상관계수 표시
corrplot(w_cor, method = "ellipse", 
         type = "lower", addCoef.col = "white")



## 상관분석을 통해 병아리 몸무게에 영향을 미치는 인자를 찾을 수 있었고 그중에서도 병아리가 태어난 
## 달걀인 종란의 무게가 가장 큰 양의 상관 관계를 갖고 있음을 확인할 수 있었다.
## 그렇다면 종란의 무게로 병아리의 몸무게를 예측하는 것이 가능할까? 회귀분석을 통해 해결해 본다.
## 선형회귀분석 : 연속형 변수들에 대해 두 변수 간의 관계를 수식으로 나타내는 분석 방법이다.
##                영향을 주는 변수 - 독립변수(x), 영향을 받는 변수 - 종속변수(y)
##                회귀식 - y = ax + b


## 종란의 무게로 병아리의 무게를 예측할 수 있을까? (회귀분석)

w <- read.csv("data/data4.csv")
# w 데이터 셋에서 2~5열 데이터만 가져오기(첫열은 factor이므로)
w_n <- w[,2:5]
head(w_n)

# 단순선형 회귀분석 실시
w_lm <- lm(weight ~ egg_weight, data = w_n)

w_lm

## - 회귀모델 F 통계량의 p-값(유의확률)을 확인하여 0.05 보다 작으면 95% 신뢰수준에서 
##   통계적으로 유의하다고 판단함
## - 독립 변수의 p-값(유의확률)을 확인하여 0.05 보다 작으면 95% 신뢰수준에서 
##   통계적으로 유의(영향력이 있다고)하다고 판단함 또한 * 기호가 많을 수록 유의성이 높아짐
## - 결정계수(R-squared)가 높은지 확인하여 1에 가까울수록 회귀모델의 성능이 뛰어남을 뜻함.
##   독립변수가 2개이상인 다중회귀모델은 Adjusted R-squared 값으로 확인
## - 회귀모델의 y절편(상수)과 독립변수의 계수는 Estimate 값으로 확인 가능. 회귀분석 결과를
##   저장한 변수의 coefficient로도 확인 가능.
# 회귀모델 결과 확인
summary(w_lm)

# 산점도에 회귀직선을 표시해 모델이 데이터를 잘 대표하는지 확인
plot(w_n$egg_weight, w_n$weight)  # 산점도 그리기
lines(w_n$egg_weight, w_lm$fitted.values, col = "blue")  # 회귀직선 추가
text(x = 66, y = 132, label = 'Y = 2.3371X - 14.5475')  # 회귀직선 라벨로 표시

names(w_lm)  # w_lm 변수에 어떤 항목들이 있는지 확인

w_lm$coefficients
w_lm$model
w_lm$residuals # 잔차 : 실제 종속변수 값과 회귀 모델로 추정된 값의 편차

hist(w_lm$residuals, col = "skyblue", xlab = "residuals",
     main = "병아리 무게 잔차 히스토그램")

## 잔차에 대한 히스토그램을 확인한 결과 정규분포를 이루고 있지 않는다.
## 잔차가 높게 나왔다는 결과... --> 영향을 주는 변수인 독립 변수를 좀더 늘려보자. - 다중회귀분석
## 다중회귀분석 : 독립 변수가 2개 이상 - y = ax1 + bx2 + c

# 다중회귀분석 실시
w_mlm <- lm(weight ~ egg_weight + movement + food, data = w_n)

summary(w_mlm)


# p값이 높은 movement 변수를 제외한 열만 다시 회귀분석 실시 
w_mlm2 <- lm(weight ~ egg_weight + food, data = w_n)

summary(w_mlm2)
hist(w_mlm2$residuals, col = "skyblue", xlab = "residuals",
     main = "병아리 무게 잔차 히스토그램")
shapiro.test(w_mlm2$residuals)


## 잔차 히스토그램 : 단순 선영 회귀분석에서처럼 산점도를 그려서 회귀모델이 얼마나 적합한지 
## 봐야하지만 다중 회귀 분석은 독립변수가 많으므로 최소 3차원 이상의 축을 가진
## 그래프를 그려야 함  --> 잔차 히스토그램만 확인
hist(w_mlm2$residuals, col = "skyblue", xlab = "residuals",
     main = "병아리 무게 잔차 히스토그램(다중 회귀)")


## 다중회귀분석에서 변수 선택 방법
## 전진선택법 : y 절편만 있는 상수부터 시작해서 독립 변수들을 추가해 나가는 방법
## 후진소거법 : 독립 변수를 모두 포함한 상태에서 가장 적은 영향을 주는 변수를 하나씩 제거해 나감
# (참고)후진소거법을 적용해 자동으로 실행
step_mlm <- step(w_mlm, direction = "backward")

# (참고)회귀분석 결과 그래프로 확인
plot(w_mlm2)

## 김대표는 병아리에서 닭이 될 때까지 성장 기간에 따른 몸무게의 변화가 궁금해졌다.
## 병아리 한 마리를 지정해서 부화한 첫 날부터 70일까지의 몸무게를 기록했다. -> 어떻게 성장했을까?

## 비선형 회귀분석(다항 회귀분석)
## 독립변수와 종속변수가 선형관계가 아닌 비선형 관계일 때 사용하는 분석 방법
## 독립변수와 종속변수 관계가 곡선 형태일 때
## 독립변수에 로그나 거듭 제곱 등을 취해 보면서 적합한 비선형 모델을 찾는다.
# 비선형 회귀분석용 두번째 데이터셋 불러오기
w2 <- read.csv("data/data5.csv", header = TRUE)

head(w2)
str(w2)
plot(w2)  # 데이터 형태 산점도로 확인


# 성장기간에 따른 병아리 무게 변화 선형 회귀분석 실시
w2_lm <- lm(weight ~ day, data = w2)

summary(w2_lm)

# 산점도 위에 회귀직선 표시
lines(w2$day, w2_lm$fitted.values, col = "blue")

# 성장기간에 따른 병아리 무게 변화 비선형 회귀분석 실시
w2_lm2 <- lm(weight ~ I(day^3) + I(day^2) + day, data = w2)

summary(w2_lm2)

plot(w2)

# 산점도 위에 회귀곡선 표시
lines(w2$day, w2_lm2$fitted.values, col = "red")

# w2_lm2 회귀분석 결과에서 계수 확인
w2_lm2$coefficients

# 산점도 위에 수식 표시
text(25, 3000, "weight = -0.025*day^3 + 2.624*day^2 - 15.298*day + 117.014")
