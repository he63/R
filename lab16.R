# 1단계
library(dplyr)
(emp <- read.csv("data/emp.csv"))

# 문제1
emp %>% filter(job == "MANAGER")

# 문제2
emp %>% select(empno, ename, sal)

# 문제3
emp %>% select(-empno)

# 문제4
emp %>% select(ename, sal)

# 문제5
emp %>% count(job)

# 문제6
emp %>% filter(sal >= 1000 & sal <= 3000) %>% select(ename, sal, deptno)

# 문제7
emp %>% filter(job != "ANALYST") %>% select(ename, job, sal)

# 문제8
emp %>% filter(job == "SALESMAN"|job == "ANALYST") %>% select(ename, job)

# 문제9
emp %>% group_by(deptno) %>% summarise(sum = sum(sal))

# 문제10
emp %>% arrange(sal)

# 문제11
emp %>% arrange(desc(sal)) %>% head(1)

# 문제12
empnew <- emp %>% rename(salary='sal', commrate='comm')

# 문제13
emp %>% group_by(deptno) %>% summarise(n = n()) %>% arrange(desc(n)) %>% select(deptno) %>% head(1)

# 문제14
emp %>% mutate(enamelength=nchar(ename))

# 문제15
emp %>% filter(comm != "NA") %>% summarise(n=n())



# 2단계

# 문제16
mpg <- as.data.frame(ggplot2::mpg)
str(mpg)
dim(mpg)
head(mpg, 10)
tail(mpg, 10)
View(mpg)
summary(mpg)
mpg %>% group_by(manufacturer) %>% summarise(n=n())
mpg %>% group_by(manufacturer, model) %>% summarise(n=n())


# 문제17
mpg <- mpg %>% rename(city="cty", highway="hwy")
str(mpg)

# 문제18
# 1
meanhwy4 <- mpg %>% filter(displ >= 4) %>% summarise(meanhwy = mean(highway))
meanhwy5 <- mpg %>% filter(displ >= 5) %>% summarise(meanhwy = mean(highway))
meanhwy4 < meanhwy5   # 참이므로 displ이 5일 때 고속도로 연비가 더 높다.

# 2
mean_audi <- mpg %>% filter(manufacturer == "audi") %>% summarise(meancity = mean(city))
mean_toyota <- mpg %>% filter(manufacturer == "toyota") %>% summarise(meancity = mean(city))
mean_audi < mean_toyota   # 참이므로 toyota가 도시연비가 더 높다.

# 3
mpg %>% filter(manufacturer=="chevrolet"|manufacturer=="ford"|manufacturer=="honda") %>% summarise(meanhwy=mean(highway))

# 문제19
# 1
mpg3 <- mpg %>% select(class, city)
head(mpg3)

# 2
subcity <- mpg3 %>% filter(class=="suv") %>% summarise(subcity=mean(city))
compactcity <- mpg3 %>% filter(class=="compact") %>% summarise(subcity=mean(city))
subcity < compactcity   # 참이므로 compact의 도시 주행 연비가 더 높다.

# 문제20
mpg %>% filter(manufacturer == "audi") %>% arrange(desc(highway)) %>% head(5)
    