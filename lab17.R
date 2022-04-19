library(ggplot2)
library(dplyr)

# 문제1
mpg <- as.data.frame(ggplot2::mpg)
mpg_y <- mpg %>% select(cty, hwy)
sketch <- ggplot(mpg_y, aes(x = cty, y = hwy))
sketch + geom_point(color="blue")

# 문제2
mpg <- as.data.frame(ggplot2::mpg)
ggplot(mpg, aes(x = class)) + geom_bar(aes(fill=drv))

# 문제3
pro_c <- read.table("data/product_click.log")
pro_c <- pro_c %>% select(2)
pro_c <- as.data.frame(table(pro_c))
names(pro_c) <- c("상품ID", "클릭수")
ggplot(pro_c, aes(x = 상품ID, y = 클릭수)) + geom_col(aes(fill=상품ID))

# 문제4
data(GNI2014)
str(GNI2014)
treemap(GNI2014, vSize="population", index=c("continent", "iso3"), title="전세계 인구 정보", fontfamily.title="maple")

dev.copy(png, "output/result4.png")
dev.off()