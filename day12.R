# 데이터 전처리 - dplyr 패키지를 학습하자....

install.packages("dplyr") 
library(dplyr) # detach("package:dplyr")
install.packages("ggplot2")
str(ggplot2::mpg)
head(ggplot2::mpg)
mpg <- as.data.frame(ggplot2::mpg)
head(mpg)
exam <- read.csv("data/csv_exam.csv")
str(exam)
dim(exam)
head(exam);tail(exam)
View(exam) 

