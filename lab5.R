# 문제1
(grade <- sample(1:6,1))
if (grade == 1 | grade == 2 | grade ==3) {
  cat(grade,"학년은 저학년입니다.")
} else {
  cat(grade,"학년은 고학년입니다.")
}

# 문제2 
result = ""
choice <- sample(1:5,1)
if (choice == 1){
  result = (300+50)
} else if (choice == 2){
  result = (300-50)
} else if (choice == 3){
  result = (300*50)
} else if (choice == 4){
  result = (300/50)
} else {
  result = (300 %% 50)
}
cat("결과값 : ", result)

# 문제3
count <- sample(3:10,1)
deco <- sample(1:3,1)
if (deco == 1){
  cat(paste(rep("*", count), collapse = ""))
} else if (deco == 2) {
  cat(paste(rep("$", count), collapse = ""))
} else {
  cat(paste(rep("#", count), collapse = ""))
}

# 문제4
score <- sample(0:100,1);score;score_a
if (score<=100 & score>=90){
  score_a <- 1
} else if (score<=89 & score>=80){
  score_a <- 2
} else if (score<=79 & score>=70){
  score_a <- 3
} else if (score<=69 & score>=60){
  score_a <- 4
} else {
  score_a <- 5
}
level <- switch(EXPR=score_a,
                "A 등급", "B 등급", "C 등급", "D 등급", "F 등급"); level 
cat(score, "점은 ", level, "등급입니다.")

# 문제5
alpha <- paste(LETTERS[1:26], letters[1:26], sep = "")

# 문제6#
list <- scan("data/iotest1.txt")
cat("오름차순 : ", sort(list),
"내림차순 : ", sort(list, decreasing = TRUE),
"합 : ", sum(list),
"평균 : ", mean(list))
save(list=ls(), file="test1.R")

# 문제7
list <- scan("data/iotest2.txt",what="")
a1 <- factor(list)
a2 <- levels(a1)
a1 <- sort(summary(a1), decreasing = T)
name <- names(a1[1])
cat("가장 많이 등장한 단어는 ", name,"입니다.")
