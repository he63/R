#문제1
(v <- sample(1:26,10))
sapply(v, function(v) return(LETTERS[v]))

v <- sample(1:26, 10); v
sapply(v, function(d) LETTERS[d])

v <- sample(1:26, 10)
v
sapply(v, function(v) for (num in v) return(LETTERS[num]))


#문제2-1
memo <- readLines("./data/memo.txt",encoding="UTF-8")
memo[1] <- gsub('[&$!#@%]','',memo[1])
memo[2] <- gsub('e','E',memo[2])
memo[3] <- gsub('[0-9]','',memo[3])
memo[4] <- gsub("[A-Za-z]", "", memo[4])
memo[4] <- gsub("  ", "", memo[4])
memo[5] <- gsub("[!123456789<>]", "", memo[5])
memo[6] <- gsub(" ", "", memo[6]) #  gsub("[[:space:]]", "", memo[6])
memo[7] <- gsub("YOU", "you", memo[7])
memo[7] <- gsub("OK", "ok", memo[7])
write(memo, "./data/memo_new1.txt")

#문제2-2
memo <- readLines("./data/memo.txt",encoding="UTF-8")
memo[1] <- gsub('[&$!#@%]','',memo[1])
memo[2] <- gsub('e','E',memo[2])
memo[3] <- gsub('[0-9]','',memo[3])
memo[4] <- gsub("[A-z]", "", memo[4])
memo[4] <- gsub("  ", "", memo[4])
memo[5] <- gsub("[!123456789<>]", "", memo[5])
memo[6] <- gsub(" ", "", memo[6])
memo[7] <- tolower(memo[7])
write(memo, "./data/memo_new2.txt")

# 문제 2

getwd()
memo <- readLines("data/memo.txt", encoding = "UTF-8")
memo[1] <- gsub("[&$!#@%]", "", memo[1]) 
memo[2] <- gsub("e", "E", memo[2])
memo[3] <- gsub("[[:digit:]]", "", memo[3])
memo[4] <- gsub("[[:lower:][:upper:]]", "", memo[4])
memo[5] <- gsub("[!<>]|[[:digit:]]", "", memo[5])
memo[6] <- gsub("[[:space:]]", "", memo[6]) 
memo[7] <- tolower(memo[7])
write(memo, "memo_new.txt")

# 문제 2

memo <- readLines("data/memo.txt", encoding="UTF-8"); memo

memo_new <- c()
memo[1]; memo_new <- c(memo_new, gsub("[&$!#@%]", "", memo[1])); memo_new[1]
memo[2]; memo_new <- c(memo_new, gsub("e", "E", memo[2])); memo_new[2]
memo[3]; memo_new <- c(memo_new, gsub("\\d", "", memo[3])); memo_new[3]
memo[4]; memo_new <- c(memo_new, gsub("[a-z|A-Z]", "", memo[4])); memo_new[4]
memo[5]; memo_new <- c(memo_new, gsub("[^가-힣|. ]", "", memo[5])); memo_new[5]
memo[6]; memo_new <- c(memo_new, gsub("[[:space:]]", "", memo[6])); memo_new[6]
memo[7]; memo_new <- c(memo_new, gsub("([[:upper:]])", "\\L\\1", memo[7], perl=T)); memo_new[7]

memo_new
write(memo_new, "data/memo_new.txt")

#문제2
memo = readLines("data/memo.txt",encoding="UTF-8")
memo = gsub("[a-d]",'',memo)
memo = gsub('[f-z]','',memo)
memo = gsub("[RABD]",'',memo)
memo = gsub("[&$#@%<>]",'',memo)
memo = gsub('[0-9]','',memo)
memo = gsub('OK','ok',memo)
memo = gsub('YOU','you',memo)
memo = gsub('e','E',memo)
memo = gsub('!말','말',memo)
memo = gsub('매!일!','매일',memo)
write(memo,file='memo_new.txt',append=TRUE)



#문제3
myBirthday <- as.POSIXlt("1990-10-24")
weekdays(myBirthday)

myBirthday <- as.POSIXct("1990-10-24")
weekdays(myBirthday)

myBirthday <- as.Date("1990-10-24")
weekdays(myBirthday)