library(showtext)
showtext_auto() 
font_add(family = "cat", regular = "fonts/HoonWhitecatR.ttf")
font_add(family = "dog", regular = "fonts/THEdog.ttf")
font_add(family = "maple", regular = "fonts/MaplestoryBold.ttf")

# 지도 시각화

install.packages("ggmap")
library(ggmap)
register_google(key='AIzaSyDy81EbO46BRSnX1DOgg_F84bhsdbku2z4')

lon <- 126.9221322
lat <- 37.5268831
cen <- c(lon,lat)
mk <- data.frame(lon=lon, lat=lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=1, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=5, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=10, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=15, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="satellite",zoom=16, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=8, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="terrain",zoom=12, marker=mk)
Sys.sleep(2)
ggmap(map)
map <- get_googlemap(center=cen, maptype="hybrid",zoom=16, marker=mk)
Sys.sleep(1)
ggmap(map)+labs(title="테스트임", x="경도", y="위도")+
  theme(plot.title=element_text(family="maple", color="blue"))

map <- get_map(location=cen, maptype="toner",zoom=12, marker=mk, source="google")
ggmap(map)
map <- get_map(location=cen, maptype="watercolor",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="terrain-background",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="toner-lite",zoom=12, marker=mk, source="stamen")
ggmap(map)
map <- get_map(location=cen, maptype="terrain",zoom=12, marker=mk, source="stamen")
ggmap(map)



mk <- geocode("seoul", source = "google")
print(mk)
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=mk)
ggmap(map)

mk <- geocode(enc2utf8("부산"), source = "google")
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=11, marker=mk)
ggmap(map)

multi_lonlat <- geocode(enc2utf8("강남구 삼성동 151-7"), source = "google")
mk <- multi_lonlat
cen <- c(mk$lon, mk$lat)
map <- get_googlemap(center=cen, maptype="roadmap",zoom=16)

ggmap(map) + 
  geom_point(aes(x=mk$lon, y=mk$lat), alpha=0.4, size=5, color="magenta") +
  geom_text(aes(x=mk$lon, y=mk$lat, label="우리가 공부하는 곳", 
                family="maple", vjust=-0.1, hjust=-0.1), colour="blue") 


# 제주도
names <- c("용두암","성산일출봉","정방폭포",
           "중문관광단지","한라산1100고지","차귀도")
addr <- c("제주시 용두암길 15",
          "서귀포시 성산읍 성산리",
          "서귀포시 동홍동 299-3",
          "서귀포시 중문동 2624-1",
          "서귀포시 색달동 산1-2",
          "제주시 한경면 고산리 125")
gc <- geocode(enc2utf8(addr))
gc
#save(gc, file="jeju.RData")
#load("jeju.RData")
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
cen <- c(mean(df$lon),mean(df$lat)) # 중요
map <- get_googlemap(center=cen,
                     maptype="roadmap",
                     zoom=10,
                     size=c(800,640),
                     marker=gc)
Sys.sleep(2)
ggmap(map) 

ggmap(map) + geom_text(data=df,               
                       aes(x=lon,y=lat,
                           vjust=1.5, family="dog",            
                           size=3,label=name),
                       color="magenta") + guides(color="none", size="none")




# 공공 DB 활용 

library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "360"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc) ; top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList[1]")); df
busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList")); df
# 구글 맵에 버스 위치 출력
df$gpsX <- as.numeric(as.character(df$gpsX))
df$gpsY <- as.numeric(as.character(df$gpsY))
gc <- data.frame(lon=df$gpsX, lat=df$gpsY);gc
cen <- c(mean(gc$lon), mean(gc$lat))
map <- get_googlemap(center=cen, maptype="roadmap",size=c(800,640), zoom=12, marker=gc)
Sys.sleep(2)
ggmap(map)


library(dplyr)
library(ggmap)
library(ggplot2)

geocode('Seoul', source = 'google')
geocode('Seoul', source = 'google', output = 'latlona')
geocode(enc2utf8('서울'), source = 'google')
geocode(enc2utf8('서울'), source = 'google', output = 'latlona')
geocode(enc2utf8('서울&language=ko'), source = 'google', output = 'latlona')

station_list = c('시청역', '을지로입구역', '을지로3가역', '을지로4가역', 
                 '동대문역사문화공원역', '신당역', '상왕십리역', '왕십리역', '한양대역', 
                 '뚝섬역', '성수역', '건대입구역', '구의역', '강변역', '잠실나루역', 
                 '잠실역', '신천역', '종합운동장역', '삼성역', '선릉역', '역삼역', 
                 '강남역', '2호선 교대역', '서초역', '방배역', '사당역', '낙성대역', 
                 '서울대입구역', '봉천역', '신림역', '신대방역', '구로디지털단지역', 
                 '대림역', '신도림역', '문래역', '영등포구청역', '당산역', '합정역', 
                 '홍대입구역', '신촌역', '이대역', '아현역', '충정로역')
station_df = data.frame(station_list)
station_df$station_list = enc2utf8(station_df$station_list)
# 다음 행은 한번만 수행시켜 주셔영(^^)- 과금때문에 ㅎㅎㅎ
station_lonlat = mutate_geocode(station_df, station_list, source = 'google')
station_lonlat
# 두 번째 테스트부터는 저장했다가 읽자구요(^^)
save(station_lonlat, file="data/station_lonlat.RData")
#load("data/station_lonlat.RData")

seoul_lonlat = unlist(geocode('seoul', source = 'google'))
?qmap

qmap('seoul', zoom = 11)
qmap(seoul_lonlat, zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map <- qmap('Seoul', zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map + geom_point(data = station_lonlat, aes(x = lon, y = lat), colour = 'green',
                       size = 4)



# 지도 응용
df <- read.csv("data/전국전기차충전소표준데이터.csv")       
str(df) 
head(df); View(df)
df_add <- df[,c(13, 17, 18)]
names(df_add) <- c("address", "lat", "lon")
str(df_add)
View(df_add)

map_korea <- get_map(location="southKorea", zoom=7, maptype="roadmap") 
ggmap(map_korea)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=2, color="red")


map_seoul <- get_map(location="seoul", zoom=11, maptype="roadmap")       
ggmap(map_seoul)+geom_point(data=df_add, aes(x=lon, y=lat), alpha=0.5, size=5, color="blue")



#leaflet 그리기

install.packages("leaflet")
library(leaflet)
library(dplyr)
library(ggmap)

seoul_lonlat<-geocode("seoul")

# 지도 배경 그리기 
leaflet()

# 지도 배경에 타일깔기
leaflet() %>% addTiles() 

# 지도 배경에 센터 설정하기
map0 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16)  
map0

# 지도 배경에 센터 설정하고 타일깔기
map1 <- map0 %>% addTiles() 
map1

mk <- multi_lonlat
lon <- mk$lon
lat <- mk$lat
msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none" >멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ'
map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 18) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 5) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 1) %>% addTiles() %>% 
  addCircles(lng = lon, lat = lat, color='green', popup = msg )
map2


content1 <- paste(sep = '<br/>',"<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",'아름다운 서울','코로나 이겨냅시다!!')
map3<-leaflet() %>% addTiles() %>%  addPopups(126.97797, 37.56654, content1)
map3

content2 <- paste(sep = '<br/>',"<b><a href='http://www.snmb.mil.kr/mbshome/mbs/snmb/'>국립서울현충원</a></b>",'1955년에 개장', '2013년 ‘서울 미래유산’으로 등재')
map3<-leaflet() %>% addTiles() %>%  addPopups(c(126.97797, 126.97797),  c(37.56654, 37.50124) , c(content1, content2), options = popupOptions(closeButton = FALSE) )
map3

wifi_data = read.csv('data/wifi_data.csv', encoding = 'utf-8')
#View(wifi_data)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], 
          lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat)


leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~lon, lat = ~lat)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat, popup = ~div)

?colorFactor
telecom_color = colorFactor('Set1', wifi_data$div)
telecom_color(wifi_data$div)
str(telecom_color)
mode(telecom_color)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat=~lat, popup = ~div, color = ~telecom_color(div)) -> mymap

leaflet() %>%
  addTiles() %>%
  setView( lng=lon, lat=lat, zoom = 16) %>%
  addProviderTiles("Esri.WorldImagery")


leaflet() %>%
  addTiles() %>%
  setView( lng=lon, lat=lat, zoom = 6) %>%
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")




# 미국 주별 강력 범죄율 단계 구분도 만들기
# 패키지 준비하기
install.packages("ggiraphExtra")
library(ggiraphExtra)
library(tibble)

# 행 이름을 state 변수로 바꿔 데이터 프레임 생성
crime <- rownames_to_column(USArrests, var = "state")
head(crime)
# 지도 데이터와 동일하게 맞추기 위해 state의 값을 소문자로 수정
crime$state <- tolower(crime$state)

str(crime)

library(ggplot2)

# 뭔가 설치를 요구함 -> 1번 선택 
states_map <- map_data("state") # 데이터 설치 프롬프트함 -> 1번 선택
str(states_map)

# mapproj 패키지 설치를 요구함 -> 1번 선택 
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map)     # 지도 데이터

ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,     # 지도 데이터
             interactive = T)      # 인터랙티브

# 한국 단계구분도

#install.packages("stringi")
#install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
library(kormaps2014)
library(dplyr)

# 시도
class(korpop1)
head(korpop1)
head(kormap1)

# 시군구
class(korpop2)
head(korpop2)
head(kormap2)

# 읍면동
class(korpop3)
head(korpop3)
head(kormap3)

rm(korpop1, korpop2, korpop3)

korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop1$name <- iconv(korpop1$name, "UTF-8","CP949")


korpop2 <- rename(korpop2,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop2$name <- iconv(korpop2$name, "UTF-8","CP949")


korpop3 <- rename(korpop3,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
korpop3$name <- iconv(korpop3$name, "UTF-8","CP949")



ggplot(korpop1,aes(map_id=code, fill=pop))+
  geom_map(map = kormap1, colour="black",size=0.1)+
  expand_limits(x= kormap1$long,y = kormap1$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('2014년도 시도별 인구분포도')+coord_map()

ggplot(korpop2,aes(map_id=code, fill=pop))+
  geom_map(map = kormap2, colour="black",size=0.1)+
  expand_limits(x= kormap2$long,y = kormap2$lat)+
  scale_fill_gradientn(colours = c('#e6e6ff', 'blue', 'darkblue'))+
  ggtitle('2014년도 시군구별 인구분포도')+coord_map()


ggplot(korpop3,aes(map_id=code, fill=pop))+
  geom_map(map = kormap3, colour="black",size=0.1)+
  expand_limits(x= kormap3$long,y = kormap3$lat)+
  scale_fill_gradientn(colours = c('white','orange','red'))+
  ggtitle('2014년도 읍면동별 인구분포도')+coord_map()


seoulmap <- kormap2 %>% filter(startsWith(as.character(code), '11'))
seoulpop <- korpop2 %>% filter(startsWith(as.character(code), '11'))

ggplot(seoulpop,aes(map_id=code, fill=pop))+
  geom_map(map = seoulmap, colour="black",size=0.1)+
  expand_limits(x= seoulmap$long,y = seoulmap$lat)+
  scale_fill_gradientn(colours = rainbow(7))+
  ggtitle('2014년도 서울시 구별 인구분포도')+coord_map()


ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             palette="RdBu",       # 칼라 팔레트
             interactive = T)      # 인터랙티브


ggChoropleth(data = korpop2,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap2,        # 지도 데이터
             palette="Set3",       # 칼라 팔레트
             interactive = T)      # 인터랙티브


ggChoropleth(data = korpop3,       # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap3,        # 지도 데이터
             palette="YlGnBu",     # 칼라 팔레트
             interactive = T)      # 인터랙티브




ggChoropleth(data = seoulpop,      # 지도에 표현할 데이터
             aes(fill = pop,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = seoulmap,       # 지도 데이터
             palette="RdPu",       # 칼라 팔레트
             interactive = T)      # 인터랙티브

library(dplyr)
one <- read.csv("data/one.csv")
head(one)
head(seoulpop)
one <- one %>% group_by(구별) %>%  summarise(구별1인가구=sum(X1인가구))
sort(unique(one$구별))
sort(seoulpop$name)
seoulpop$name <- trimws(seoulpop$name)
oneseoulpop <- inner_join(seoulpop,  one, by = c("name"="구별"))
head(oneseoulpop)


ggChoropleth(data = oneseoulpop,   # 지도에 표현할 데이터
             aes(fill = 구별1인가구,  # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = seoulmap,        # 지도 데이터
             palette="YlOrRd",     # 칼라 팔레트
             interactive = T)      # 인터랙티브