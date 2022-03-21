# 문제6#
list <- scan("data/iotest1.txt")
cat("오름차순 : ", sort(list),'\n',
    "내림차순 : ", sort(list, decreasing = TRUE),'\n',
    "합 : ", sum(list),'\n',
    "평균 : ", mean(list))
