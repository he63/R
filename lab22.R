data <- read.csv("data/purifier.csv")

new_purifier <- data$purifier - data$old_purifier

data <- cbind(data, new_purifier)

purifier <- data$purifier
old_purifier <- data$old_purifier
as_time <- data$as_time

plot(data$as_time, new_purifier)

cor(data$as_time, new_purifier)

puri = lm(as_time ~ new_purifier + old_purifier, data = data)

summary(puri)

predict.lm(puri, data.frame(new_purifier = 230000, old_purifier = 70000))

# 예상된 시간은 37403.09이다.
# 기사 한 명이 한달간 처리하는 AS시간은 8시간 * 20일 이므로
# 기사 한 명당 한달에 160 시간을 처리한다.

37403.09/160
#해당 결과는 233.7693으로 234명 고용하면 된다.