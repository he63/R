# 문제1
v <- seq(10,38,2)
ml <- matrix(v, nrow = 3, ncol = 5, byrow=T)
m_max_v <- max(ml)
m_min_v <- min(ml)
row_max <- apply(ml,1,max)
col_max <- apply(ml,2,max)

# 문제2
n1 <- c(1,2,3)
n2 <- c(4,5,6)
n3 <- c(7,8,9)
m2 <- cbind(n1,n2,n3); m2

# 문제3
m3 <- matrix(1:9, nrow=3, byrow = T); m3

# 문제4
colnames(m3) <- c('col1', 'col2', 'col3')
rownames(m3) <- c('row1', 'row2', 'row3'); m3

# 문제5
alpha <- matrix(letters[1:6], nrow=2); alpha
alpha2 <- rbind(alpha, letters[24:26]);alpha2
alpha3 <- cbind(alpha, "s", "p"); alpha3

# 문제6
a <- array(1:24, dim=c(2,3,4)) # 3차원
a[2,3,4]
a[2,,]
a[,1,]
a[,,3]
a+100
a[,,4]*100
a[1,2,];a[1,3,]
a[2,,2] <- a[2,,2]+100;a
a[,,1] <- a[,,1] -2;a
a <- a*10;a
a <- NULL
a