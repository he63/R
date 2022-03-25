library(httr)
library(jsonlite)
library(XML)
# 문제1

searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"

query <- URLencode("맛집")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/xml",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))
		
doc2 <- xmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
text <- gsub("</?b>", "", text)
write(text, "output/naverblog.txt")

# 문제2

API_key <- "4062158448"
bus_No <- "360"
stdHour <- "10"
type <- "xml"
url <- paste0("http://ws.bus.go.kr/api/rest/busRouteInfo", API_key, "&type=", type, "&sdate=", sdate, "&stdHour=", stdHour)
url

doc <- xmlParse(url, encoding="UTF-8")
unitName <- xpathSApply(doc,"//list/unitName", xmlValue) 
unitCode <- xpathSApply(doc,"//list/unitCode", xmlValue)
routeName <- xpathSApply(doc,"//list/routeName", xmlValue)
addr <- xpathSApply(doc,"//list/addr", xmlValue)
weatherContents <- xpathSApply(doc,"//list/weatherContents", xmlValue)
tempValue <- xpathSApply(doc,"//list/tempValue", xmlValue)

df <- data.frame(unitName, unitCode, routeName, addr, weatherContents, tempValue )
View(df)


# 문제3
searchurl <- 'https://openapi.naver.com/v1/search/news.json'
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode("빅데이터")
url <- paste0(searchUrl, "?query=", query, "&display=100")
doc <- GET(url, add_headers("Content_Type" = "application/json",
                            "X-Naver-client-Id" = Client_ID, "X-naver-Client-Secret" = Client_Secret))

response <- GET(url)
json_data <- content(response, type = 'text', encoding = "UTF-8")
json_obj <- fromJSON(json_data)
df <- data.frame(json_obj)
View(df)



