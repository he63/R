# 문제1
countEvenOdd <- function(num.vec){
  even=c()
  odd=c()
  evenodd=list()
  if (!is.vector(num.vec) & !is.numeric(num.vec)){
    return(NULL)
  }else{
    for (num in num.vec){
      if (num %% 2 == 0){
        even=c(even,"even")
      }else{
        odd=c(odd,"odd")
      }
    }
  } 
  evenodd <- list(even=c(length(even)), odd=c(length(odd)))
  print(evenodd)
} 

# 문제2
vmSum <- function(arg){
  sum = 0
  if (is.vector(arg)){
    if (!is.numeric(arg)){
      print("숫자 벡터를 전달하숑!")
      return(0)
    } else {
        return(sum(arg))
    }
  } else {
    print("벡터만 전달하숑!")
  }
}

# 문제3
vmSum2 <- function(arg){
  if (!is.vector(arg)){
    stop("벡터만 전달하숑!")
  } else {
    if (!is.numeric(arg)){
      warning("숫자 벡터를 전달하숑!")
    } else {
      return(sum(arg))
    }
  }
}

# 문제4
mySum <- function(vec){
  evenodd <- list()
  even <- c()
  odd <- c()
  if (any(is.vector(vec))){
    for (num in vec){
      if (is.na(num)){
        warning("NA를 최저값으로 변경하여 처리함!!")
        num <- min(vec, na.rm = T)
      }
      return(evenSum <- sum(vec[seq(from=1, to=length(vec), by=2)]))
      return(oddSum <- sum(vec[seq(from=2, to=length(vec), by=2)]))
      return(list(evenSum=evenSum, oddSum=oddSum))
    }
  }else{
    stop("벡터만 처리 가능!!")
  }
}

mySum(c(1,2,3,4,5,NA))

# 문제5
myExpr <- function(fun){
  if (!is.function(fun)){
    stop("수행 안할꺼임!!")
  }else{
    nums <- sample(1:45,6)
    return(fun(nums))
  }
}

# 문제6
createVector1 <- function(...){
  data <- c(...)
  if (length(data) == 0){
    return(NULL)
  } else {
    if (is.na(data)){
      return(NA)
    }else {
      return(c(data))
    }
  }
}

# 문제7
createVector2 <- function(...){
  vect_num <- c()
  vect_log <- c()
  vect_char <- c()
  data2 <- list(...)
  if (length(data2) == 0){
    return(NULL)
  }else {
    for (vec in data2){
      if (is.numeric(vec)){
        vect_num <- c(vect_num, vec)
      }else if (is.character(vec)){
        vect_char <- c(vect_char, vec)
      }else if (is.logical(vec)){
        vect_log <- c(vect_log, vec)
      }
    }
    return(list(vect_char=vect_char,vect_log=vect_log,vect_num=vect_num))
  }
}









##########################################
# 다른분 풀이
# 문제1
countEvenOdd <- function(x){
  even <- 0
  odd <- 0
  if (!is.numeric(x)){
    return()
  }else{
    for (num in x){
      if (num %% 2 ==0){
        even = even + 1
      }else {
        odd = odd + 1
      }
    }
  }
  return(list(even=even,odd=odd))
}
countEvenOdd(c(1:9))
countEvenOdd(LETTERS)


# 문제2
vmSum <- function(x){
  if (!is.vector(x)){
    return("벡터만 전달하숑!")
  }
  if (!is.numeric(x)){
    print("숫자 벡터를 전달하숑!")
    return(0)
  }else{
    sum <- 0
    for (i in x){
      sum = sum + i
    }
  }
  return(sum)
}
vmSum(1:10)
vmSum(matrix(1:3))
vmSum(iris)
vmSum(letters)

# 문제3
vmSum2 <- function(x){
  if (!is.vector(x)){
    stop("벡터만 전달하숑!")
  }
  if (!is.numeric(x)){
    warning("숫자 벡터를 전달하숑!")
    return(0)
  }else{
    sum <- 0
    for (i in x){
      sum = sum + i
    }
  }
  return(sum)
}
vmSum2(1:10)
vmSum2(matrix(1:3))
vmSum2(iris)
vmSum2(letters)

# 문제4
mySum <- function(x){
  oddSum <- 0
  evenSum <- 0
  if (is.null(x)){
    return()
  }
  if (!is.vector(x)){
    stop("벡터만 처리 가능!!")
  }
  if(any(is.na(x))){
    warning("NA를 최저값으로 변경하여 처리함!!")
    x[is.na(x)] = min(x, na.rm = TRUE)
  }
  evenSum <- sum(x[seq(from=1, to=length(x), by=2)])
  oddSum <- sum(x[seq(from=2, to=length(x), by=2)])
  return(list(evenSum=evenSum, oddSum=oddSum))
}
mySum(array(1:10))
mySum(c(10, 1, NA, 5, NA, 6, 11))
mySum(1:10)
mySum(NULL)


# 문제5
myExpr <- function(x) {
  if (!is.function(x)){
    stop("수행 안할꺼임!")
  }
  num <- sample(1:45,6)
  return(x(num))
}

myExpr(min)
myExpr(max)
myExpr(sum)
myExpr(mean)

# 문제6
createVector1 <- function(...) {
  data <- c(...)
  if (is.null(data)){
    return()
  }
  if (any(is.na(data))){
    return(NA)
  }
  return(data)
}
createVector1(1:20)
createVector1(1,2,3,4,5)
createVector1(LETTERS, 1:10)
createVector1(TRUE)
createVector1(NA)
createVector1(NULL)
createVector1()
createVector1(1,'a string', TRUE)
createVector1(1,'a string', TRUE, NA)



# 문제7
# CASE 1
createVector2 <- function(...) {
  data <- list(...)
  if (length(data) == 0) {
    return()
  }
  else {
    char.vec <- c()
    number.vec <- c()
    bool.vec <- c()
    for (x in data) {
      if (is.character(x)) {
        char.vec <- c(char.vec, x)
      }
      else if (is.numeric(x)) {
        number.vec <- c(number.vec, x)
      }
      else if (is.logical(x)) {
        bool.vec <- c(bool.vec, x)
      }
    }
    return(list(char.vec, number.vec, bool.vec))
  }
}

createVector2()
createVector2("안녕", 1, TRUE, 2, 3, "끝", "end")
createVector2("안녕", 1, 2, 3, "끝", "end", F)


# CASE 2
createVector2<-function(...){
  p<-c(...)
  char<-c()
  num<-c()
  bool<-c()
  if(is.null(p))return(NULL)
  for(a in p){
    if(is.character(a))char<-append(char,a)
    else if(is.numeric(a))num<-append(num,a)
    else if(is.logical(a))bool<-append(bool,a)
  }
  return(list(num,char,bool))
}
createVector2(1,2,3,4,5,T,F,"hi")
