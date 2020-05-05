library(devtools)
library(ggmap)
library(xlsx)
install.packages("xlsx")
install.packages("ggmap")
install.packages("readxl")
library(readxl)

setwd("~/ApartmentPrice/Data Preprocessing_R")
# 데이터 불러오기
mart_data <- read.csv("../Data/collectData/N_20200421_distance_data/N_20200421_서울시 메가마트.csv")
# 중복값 제거
mart_data2 <- unique(mart_data)

# 주소 추출
mart_code <- as.character(mart_data2$지번)
mart_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDaqk0cpRrmBkT6-77TZLq2LUuml_mnro0"
register_google(googleAPIkey)

mart_code <- geocode(mart_code)

# 결측치 확인 및 수정
sum(is.na(mart_code))

# NA값이 있는 행 찾기 및 제거
mart_data2 <- cbind(mart_data2, mart_code)
mart_data2[!complete.cases(mart_data2), ]

mart_data3 <- na.omit(mart_data2)

sum(is.na(mart_data3))

# CSV로 저장
write.csv(mart_data3, "../Data/preprocessingData/H_Seoul_MEGAMART.csv", row.names = FALSE)

#읽는거 확인하기
read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_Seoul_MEGAMART.csv")
