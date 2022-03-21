# 문제7
list <- scan("data/iotest2.txt",what="")
a1 <- factor(list)
a2 <- levels(a1)
a1 <- sort(summary(a1), decreasing = T)
name <- names(a1[1])
cat("가장 많이 등장한 단어는 ", name,"입니다.")
