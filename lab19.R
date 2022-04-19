library(leaflet)
library(dplyr)
library(ggmap)
library(htmltools)

# 문제1
home <- geocode(enc2utf8("경기도 양주시 옥정동 968"), source = "google")
cen <- c(home$lon, home$lat)
msg <- '<strong>집</strong><hr>내 집'
map <- leaflet() %>% setView(lng = home$lon, lat = home$lat, zoom = 15) %>% addTiles() %>% 
  addCircles(lng = home$lon, lat = home$lat, color='green', popup = msg )
map
save_html(map, "output/lab19_1.html")

# 문제2
library(kormaps2014)
library(dplyr)
register_google(key='AIzaSyDy81EbO46BRSnX1DOgg_F84bhsdbku2z4')

myseoulpop <- seoulpop <- korpop2 %>% filter(startsWith(as.character(code), '11'))
myseoulpop <- rename(myseoulpop, "외국인수" = "외국인_계_명")
myseoulpop$외국인수 <- as.numeric(myseoulpop$외국인수)

lab19_2 <- ggChoropleth(data = myseoulpop,      # 지도에 표현할 데이터
             aes(fill = 외국인수,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = seoulmap,       # 지도 데이터
             palette="GnBu",       # 칼라 팔레트
             interactive = T)      # 인터랙티브
save_html(lab19_2, "output/lab19_2.html")
