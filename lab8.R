# 문제1
v <- sample(1:26, 10)
sapply(v, function(v) for (num in v) return(LETTERS[num]))
# sapply 는 받은 벡터를 각각 꺼내어 리턴해주는것 이므로
# for문이 의미가 없다

# 문제2
memo <- readLines("data/memo.txt",encoding="UTF-8")
memo
memo <- gsub("[&^%*#$@<>]", "", memo)
memo[1] <- gsub("!", "", memo[1])
memo[2] <- gsub("e", "E", memo[2])
memo[3] <- gsub("[0-9]", "", memo[3])
memo[4] <- gsub("[RAnalysisBigData]", "", memo[4])
memo_1 <- substring(memo[4], first=1, last=9)
memo_2 <- substring(memo[4], first=11, last=22)
memo[4] <- paste(memo_1, memo_2, sep = "")
memo[5] <- gsub("[[:digit:]!]", "", memo[5])
memo[6] <- gsub("[[:space:]]", "", memo[6])
memo[7] <- tolower(memo[7])
memo_3 <- substring(memo[7], first=1, last=76)
memo_4 <- substring(memo[7], first=79, last=81)
memo[7] <- paste(memo_3, memo_4, sep = "")

getwd()
write(memo, file ="memo_new.txt")


# 문제3
as.Date('1997/12/15')
as.Date('12/15/1997',format='%m/%d/%Y')