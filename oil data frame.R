data <- read.table("data/oil1.txt", encoding="UTF-8")

dataname <- data[1,]
dataname <- unlist(strsplit(dataname, split=","))
data <- data[,1]
data <- unlist(strsplit(data, split=","))


for (i in (length(data)/6)) {
  print(data[i:(i*6)])
}



colnames(data) <- dataname

data <- as.vector(data)
class(data)



read.table("data/oil2.csv", header = T)
