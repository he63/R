# 문제1
exam1 <- function(){
  return(paste(LETTERS,letters, sep = ""))
}
exam1()

# 문제2
exam2 <- function(x){
  return(sum(1:x))
}
cat("함수 호출 결과 : ",exam2(3))

# 문제3
exam3 <- function(x,y){
  return(if (x==y){
    return(0)
  } else{
    max(x,y)-min(x,y)}
)}
print(paste("함수 호출 결과 : ", exam3(1,3)), quote = FALSE)

# 문제4
exam4 <- function(a,b,c){
  return(if (b == "+"){
    return(a + c)
  } else if (b == "-"){
    return(a - c)
  } else if (b == "*"){
    return(a * c)
  } else if (b == "%/%"){
    if (a == 0){
      return("오류1")}else{
        return(a %/% c)}
  } else if (b == "%%"){
    if (c == 0){
      return("오류1")}else{
        return(a %% c)}
  } else {
    "규격의 연산자만 전달하세요"
  })
}

# 문제5
exam5 <- function(x,y="#"){
  if (x > 0){
  cat(paste(rep(y, x), collapse = ""), "\n")
  } 
    return(NULL)
  }

exam5(3)
# 문제6
exam6 <- function(data){
  for (b in data){
    if (is.na(b)){
      cat("NA는 처리불가", "\n")
    } 
    else{
      if (b>=85 & b<=100){
        cat(b, "점은", "상등급입니다.","\n")
      }else if (b>=70 & b<=84){
        cat(b, "점은", "중등급입니다.","\n")
      }else{
        cat(b, "점은", "하등급입니다.","\n")
      }
    }
  }
  return(NULL)}

exam6(c(80, 50, 70, 66, NA, 35))