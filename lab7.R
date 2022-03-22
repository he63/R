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
      if(num %% 2 == 0) {
        even <- c(even, num)
      }else{
        odd <- c(odd, num)
      }
    }
    evenodd$even <- sum(even)
    evenodd$odd <- sum(odd)
    return(evenodd)
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