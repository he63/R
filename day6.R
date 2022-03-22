# 정규표현식의 기능과 작성방법 점검
# gsub() : 대체하는 함수
# sub는 첫번째 한번, gsub는 전부

word <- "JAVA javascript 가나다 123 %^&*"
gsub("A", "", word) # "A" 빼고 출력
gsub("a", "", word) # "a" 빼고 출력
gsub("[Aa]", "", word)  # "A" and "a" 빼고 출력
gsub("[가-힣]", "", word) # 한글 빼고 출력
gsub("[^가-힣]", "", word) # 한글만 출력
gsub("[&^%*]", "", word)  # 특수기호(&^%*) 빼고 출력
gsub("[1234567890]", "", word) # 숫자빼고 출력
gsub("[0-9]", "", word) # 위와 동일 숫자 빼고 출력
gsub("\\d", "", word) # 위와 동일 숫자 빼고 출력
gsub("[^1234567890]", "", word) # 숫자만 출력
gsub("\\D", "", word) # 숫자만 출력
gsub("[[:punct:]]", "", word) # 특수기호 빼고 출력
gsub("[[:alnum:]]", "", word) # 알파벳, 한글 , 숫자 빼고 출력
gsub("[[:digit:]]", "", word) # 숫자 빼고 출력
gsub("[^[:alnum:]]", "", word) # 알파벳, 한글, 숫자만 출력 
gsub("[[:space:]]", "", word) # 공백 빼고 출력
gsub("[[:space:][:punct:]]", "", word) #특수기호, 여백 빼고 출력
gsub("[^[:space:][:punct:]]", "", word) # 특수기호 여백만 출력
gsub("[[:punct:][:digit:][:space:]]", "", word) # 특수기호, 여백, 숫자 빼고 출력

word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub(" ", "@", word) # 여백을 @ 로 대체
sub(" ", "@", word)
gsub("Aa", "", word) # "Aa"를 여백으로 대체
gsub("Aa{2}", "", word) # "Aaa" 를 여백으로 대체
gsub("(Aa){2}", "", word) # "AaAa" 를 여백으로 대체
gsub("[Aa]", "", word) #"A", "a"를 여백으로 대체체


#문자열 처리 관련 주요 함수들 

x <- "We have a dream"
nchar(x)  # 각 벡터의 형태소의 갯수 # 공백도 문자로 포함한다.
length(x) # x안의 element 갯수

y <- c("We", "have", "a", "dream", "ㅋㅋㅋ")
length(y)
nchar(y)

letters
sort(letters, decreasing=TRUE)  # 내림차순 decreasing 값에 따라 오름차순, 내림차순 

fox.says <- "It is only with the HEART that one can See Rightly"
tolower(fox.says) # 소문자로 변경 
toupper(fox.says) # 대문자로 변경경

substr("Data Analytics", start=1, stop=4) # 문자열의 1번째 부터 4번째 까지 인덱싱
substr("Data Analytics", start=1, stop=1)
substr("Data Analytics", 3, 3)  # start, stop 생략 가능 
substr("Data Analytics", start=2, stop=7)
substr("Data Analytics", 6, 14)
# substr("Data Analytics", start=2)
substr("Data Analytics", start=c(1,6), stop=c(4, 14))
    # (start=1, stop=4)만 인식, 첫번째만 인식

### 웬만하면 substring 쓰자

substring("Data Analytics", first=6) # 6번째 문자열부터 끝까지 # last값은 생략가능 
substring("Data Analytics", first=6, last=10) # 6번째 부터 10번째 까지
substring("Data Analytics", first=c(1,6), last=c(4, 14))
substring("abcdef", 1:6, 1:6) # 각각 한개씩 출력


classname <- c("Data Analytics", "Data Mining", 
               "Data Visualization")
substr(classname, 1, 4)
# 각 벡터의 (start=1, stop=4)에 해당하는 값을 출력력


countries <- c("Korea, KR", "United States, US", 
               "China, CN")
substr(countries, nchar(countries)-1, nchar(countries))
# 각 벡터의 문자열 끝의 2글자 출력

?iris
?islands
str(islands)
head(islands)
landmesses <- names(islands)
landmesses
grep(pattern="New", x=landmesses)
# grep(pattern=, x=)에서 포함되는 문자열을 pattern에 입력하고
# 그 값들을 포함하고 있는 리스트나 벡터를 x에 입력한다.
# 그럼 그 문자열을 포함하고 있는 값의 인덱스를 출력한다.

index <- grep("New", landmesses)
landmesses[index]
# 동일
grep("New", landmesses, value=T)
# grep 함수에 value=T를 주면 인덱싱값이 아닌 name값을 출력


txt <- "Data Analytics is useful. Data Analytics is also interesting."
sub(pattern="Data", replacement="Business", x=txt) # sub이기 때문에 한개의 pattern값을 찾아서 replacement값으로 변경
gsub(pattern="Data", replacement="Business", x=txt)  # gsub이므로 모든 pattern을 변경

x <- c("test1.csv", "test2.csv", "test3.csv", "test4.csv")
x <- gsub(".csv", "", x)
x

gsub("[ABC]", "@", "123AunicoBC98ABC")  # 123@unico@@98@@@
gsub("ABC", "@", "123AunicoBC98ABC")  # 123AunicoBC98@
gsub("(AB)|C", "@", "123AunicoBC98ABC") # 123AunicoB@98@@
gsub("A|(BC)", "@", "123AunicoBC98ABC") # 123Aunico@98@@
gsub("A|B|C", "@", "123AunicoBC98ABC")  # 123@unico@@98@@@

words <- c("ct", "at", "bat", "chick", "chae", "cat", 
           "cheanomeles", "chase", "chasse", "mychasse", 
           "cheap", "check", "cheese", "hat", "mycat", "mycheese", "asdfcccasdf")

grep("che", words, value=T) # 포함하는 원소들의 값들로 구성된 벡터 리턴
grep("che", words) # 포함하는 원소들의 인덱스들로 구성된 벡터 리턴
grep("at", words, value=T)
grep("[ch]", words, value=T)
grep("[at]", words, value=T)
grep("ch|at", words, value=T)
grep("ch(e|i)ck", words, value=T)
grep("chase", words, value=T)
grep("chas?e", words, value=T)  #chae, chase ?앞의 글자가 0번 or 1번
grep("chas*e", words, value=T)  #chae, chase, chasse, chassse, chassssse *앞의 글자 0번이상 무한대.
grep("chas+e", words, value=T)  # chase, chasse +앞의 글자가 1번잇아
grep("ch(a*|e*)se", words, value=T)
grep("^c", words, value=T)  #[^....]  -> 부정 대괄호 밖에서 ^를 사용하는경우 ^xxx  -> ~으로 시작하는 것 
grep("t$", words, value=T)  # xxx$  -> ~로 끝나는
grep("^c.*t$", words, value=T)  # .은 임의의 한 문자를 뜻함, .*는 0개 또는 한개  , 이 예시의 경우 c로 시작하고 t로 끝나는 경우
grep( "^[^c]+$", words, value=T)  # 부정 두번 이기 때문에 c가 아닌 문자가 한개 이상으로 시작한다

words2 <- c("12 Dec", "OK", "http//", 
            "<TITLE>Time?</TITLE>", 
            "12345", "Hi there", "가나다")

grep("[[:alnum:]]", words2, value=TRUE) # 알파벳, 숫자 를 포함하고 있는 원소를 출력
grep("[[:alpha:]]", words2, value=TRUE)
grep("[[:digit:]]", words2, value=TRUE)
grep("[[:punct:]]", words2, value=TRUE)
grep("[[:space:]]", words2, value=TRUE)
grep("\\w", words2, value=TRUE) # alphanum과 동일, 문자열과 숫자 를 포함하고 있는 원소 출력
grep("\\d", words2, value=TRUE) # 숫자를 포함하고 있는 원소 출력
grep("\\D", words2, value=TRUE) # 숫자가 아닌 것을 포함한 원소 출력
grep("\\s", words2, value=TRUE) # space와 동일 , 공백을 포함한 원소 출력


# 문자열을 분리자로 분리하는 함수 : strsplit()

fox.said <- "What is essential is invisible to the eye"
fox.said
strsplit(x= fox.said, split= " ") # 공백을 기준으로 분리
strsplit(x= fox.said, split="") # 모든 형태소를 각각 분리

fox.said.words <- unlist(strsplit(fox.said, " ")) # 공백을 기준으로 분리하고 리스트 형식을 해체함
fox.said.words
fox.said.words <- strsplit(fox.said, " ")[[1]]
fox.said.words
fox.said.words[3]
p1 <- "You come at four in the afternoon, than at there I shall begin to the  happy"
p2 <- "One runs the risk of weeping a little, if one lets himself be tamed"
p3 <- "What makes the desert beautiful is that somewhere it hides a well"
(littleprince <- c(p1, p2, p3))
strsplit(littleprince, " ")
strsplit(littleprince, " ")[[3]] 
strsplit(littleprince, " ")[[3]][5]


# 날짜와 시간 관련 기능을 지원하는 함수들

(today <- Sys.Date())
str(today)
class(today)
format(today, "%Y년 %m월 %d일")
format(today, "%d일 %B %Y년")
format(today, "%B %b %m")
format(today, "%y")
format(today, "%Y")
format(today, "%B")
format(today, "%b")
format(today, "%a")
format(today, "%A")
weekdays(today) 
months(today) 
quarters(today)
unclass(today)  # 1970-01-01을 기준으로 얼마나 날짜가 지났지는 지의 값을 가지고 있다.
Sys.Date(); str(Sys.Date())
Sys.time();str(Sys.time());class(Sys.time())
Sys.timezone()
date()

as.Date('1/17/2022') # 에러발생
as.Date('2022/1/17') # 잘 인식한다.
as.Date('2022-1-17') 
as.Date('2022-01-17') 
as.Date('2022년 1월 17일') 
as.Date('1/12/2022',format='%m/%d/%Y') # format 은 생략 가능
as.Date('2022년 1월 17일', '%Y년 %m월 %d일') 
as.Date('1월 17, 2022',format='%B %d, %Y')
as.Date('110228',format='%d%b%y') 
as.Date('110228',format='%y%m%d') 
as.Date('11228',format='%d%b%y') 

x1 <- "2022-01-17 09:00:00"
# 문자열을 날짜형으로
d <- as.Date(x1, "%Y-%m-%d %H:%M:%S") 
d
class(d)
# 문자열을 날짜+시간형으로
t <- strptime(x1, "%Y-%m-%d %H:%M:%S")
t
class(t)
strptime('2022-08-21 14:10:30', "%Y-%m-%d %H:%M:%S")

as.POSIXlt("2022/01/01 10:30:11",format="%Y/%m/%d %S:%M:%H")
as.POSIXct("2022/01/01 10:30:11",format="%Y/%m/%d %S:%M:%H")

as.Date("2022/01/01 08:00:00") - as.Date("2022/01/01 05:00:00")
as.POSIXct("2022/01/01 08:00:00") - as.POSIXct("2022/01/01 05:00:00")
as.POSIXlt("2022/01/01 08:00:00") - as.POSIXlt("2022/01/01 05:00:00")

ct<-Sys.time()
lt<-as.POSIXlt(ct)
str(ct) 
str(lt) 
unclass(ct) 
unclass(lt) 
lt$mon+1
lt$hour
lt$year+1900

?as.POSIXlt
#POSIXct는 UNIX epoch(1970년) 부터 지금까지의 초를 저장하는 방식이다. 일반적으로 프로그래밍할 때 사용되는 방법과 비슷하다. 때문에 double의 숫자 타입으로 저장된다.
#POSIXlt는 시간을 년/월/일/시/분/초 등으로 저장하는 방식이다. Java의 java.util.Calendar와 비슷한 느낌

as.POSIXct(1449894438,origin="1970-01-01")
as.POSIXlt(1449894438,origin="1970-01-01")

as.POSIXlt("2022/05/01")$wday
as.POSIXlt("2022/05/02")$wday
as.POSIXlt("2022/05/03")$wday
as.POSIXlt("2022/05/04")$wday
as.POSIXlt("2022/05/05")$wday

#올해의 크리스마스 요일 2가지방법(요일명,숫자)
christmas2<-as.POSIXlt("2022-12-25")
weekdays(christmas2)
christmas2$wday
#2022년 1월 1일 어떤 요일
tmp<-as.POSIXct("2022-01-01")
weekdays(tmp)
#오늘은 xxxx년x월xx일x요일입니다 형식으로 출력
tmp<-Sys.Date()
year<-format(tmp,'%Y')
month<-format(tmp,'%m')
day<-format(tmp,'%d')
weekday<-format(tmp,'%A')
cat("오늘은 ",year,"년 ",month,"월 ",day,"일 ",weekday," 입니다.\n",sep="")
format(tmp,'오늘은 %Y년 %B %d일 %A입니다')



# 데이터 전처리(1) - apply 계열의 함수를 알아보자
weight <- c(65.4, 55, 380, 72.2, 51, NA)
height <- c(170, 155, NA, 173, 161, 166)
gender <- c("M", "F","M","M","F","F")

df <- data.frame(w=weight, h=height)
df
?apply
?lapply
apply(df, 1, sum, na.rm=TRUE)
apply(df, 2, sum, na.rm=TRUE)
lapply(df, sum, na.rm=TRUE)
sapply(df, sum, na.rm=TRUE)
tapply(1:6, gender, sum) # rm(sum)
tapply(df$w, gender, mean, na.rm=TRUE)
mapply(paste, 1:5, LETTERS[1:5], month.abb[1:5])

v<-c("abc", "DEF", "TwT")
sapply(v, function(d) paste("-",d,"-", sep=""))

l<-list("abc", "DEF", "TwT")
sapply(l, function(d) paste("-",d,"-", sep=""))
lapply(l, function(d) paste("-",d,"-", sep=""))

flower <- c("rose", "iris", "sunflower", "anemone", "tulip")
length(flower)
nchar(flower)
sapply(flower, function(d) if(nchar(d) > 5) return(d)) 
sapply(flower, function(d) if(nchar(d) > 5) d)
sapply(flower, function(d) if(nchar(d) > 5) return(d) else return(NA))
sapply(flower, function(d) paste("-",d,"-", sep=""))

sapply(flower, function(d, n=5) if(nchar(d) > n) return(d))
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), 3)
sapply(flower, function(d, n=5) if(nchar(d) > n) return(d), n=4)

count <- 1
myf <- function(x, wt=T){
  cat(x,"(",count,")", "\n")
  Sys.sleep(1)
  if(wt) 
    r <- paste("*", x, "*")
  else
    r <- paste("#", x, "#")
  count <<- count + 1;
  return(r)
}
result <- sapply(df$w, myf) #c(65.4, 55, 380, 72.2, 51, NA)
length(result)
result
sapply(df$w, myf, F)
sapply(df$w, myf, wt=F)
rr1 <- sapply(df$w, myf, wt=F)
str(rr1)

count <- 1
sapply(df, myf)
rr2 <- sapply(df, myf)
str(rr2)
rr2[1,1]
rr2[1,"w"]
