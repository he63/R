# 문제1
factory <- read.csv("data/factory.csv")

# 1 산점도
plot(factory$age, factory$cost)

# 2 상관계수
cor(factory$age, factory$cost)

# 3 상관계수 검정
cor.test(factory$age, factory$cost)
      # p-value = 0.0009779 로 0.05 이하이므로 통계적 의미를 갖는다.

# 4 단순선형회귀 분석 모델
plot(factory$age, factory$cost)
cor(factory$age, factory$cost)
factory.lm = lm(cost ~ age, data = factory)   # 나이를 이용하여 가격을 예측하는 수식

# 5 산점도 추세선
abline(factory.lm, col="red") 

# 6    4번 모델이 유의미한지 체크
summary(factory.lm)
# Multiple R-squared:  0.6098
# age의 분산을 cost가 약 60% 설명한다.

# 7
summary(factory.lm)
# 절편은 29.107이고 age 회귀계수는 13.637 이므로
# 회귀식은 cost = 29.107 + 13.637 * age 이다.

cost = 29.107 + 13.637 * 4
# 83.655