# 2016.02.01 ~ 2018.02.01
# 셰일 오일 채굴 이후 저점부터 2년간 변동률 


# install.packages("forecast")
library(forecast)
library(readr)
library(dplyr)
oil <- read.csv("data/으아아아.csv")
oilWTI <- oil %>% select(c("WTI"))
new <- na.omit(oilWTI)
ts <- ts(new)
acf(ts)
View(new)
diff <- diff(ts)
plot(diff)
acf(diff)
arima <- auto.arima(ts)
arima
model <- arima(ts, order=c(1,1,0))
model
tsdiag(model)
Box.test(model$residuals, lag=1, type = "Ljung")
plot(arima$x, lty=1)
lines(fitted(arima), lty=2, col ="red")

fore <- forecast(arima)

plot(fore)

d <- 58
for (i in 1:48){
  d <- (d * (100.4)/100)
}
d

