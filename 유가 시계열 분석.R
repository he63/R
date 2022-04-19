# install.packages("forecast")
library(forecast)
library(readr)
library(dplyr)
oil <- read_csv("data/oil.csv")
oil1 <- oil %>% select("WTI")
View(oil1)
new <- na.omit(oil1)
View(new)
ts <- ts(new)
acf(ts)
diff <- diff(ts)
diff
plot(diff)
acf(diff)
arima <- auto.arima(ts)
arima
model <- arima(ts, order=c(2,1,1))
model
tsdiag(model)
Box.test(model$residuals, lag=1, type = "Ljung")

plot(arima$x, lty=1)
lines(fitted(arima), lty=2, col ="red")

fore <- forecast(arima)

plot(fore)
