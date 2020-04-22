library(devtools)
library(ggmap)
library(xlsx)
install.packages("xlsx")
install.packages("ggmap")
install.packages("readxl")
library(readxl)

setwd("~/ApartmentPrice/Data Preprocessing_R")
# 데이터 불러오기
park_data <- read.csv("../Data/collectData/N_20200421_distance_data/N_20200421_서울시 공원.csv")
# 중복값 제거
park_data2 <- unique(park_data)

# 주소 추출
park_code <- as.character(park_data2$지번)
park_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDaqk0cpRrmBkT6-77TZLq2LUuml_mnro0"
register_google(googleAPIkey)

park_code <- geocode(park_code)

# 결측치 확인 및 수정
sum(is.na(park_code))

# NA값이 있는 행 찾기 및 제거
park_data2 <- cbind(park_data2, park_code)
park_data2[!complete.cases(park_data2), ]

park_data3 <- na.omit(park_data2)

sum(is.na(park_data3))

# CSV로 저장
write.csv(park_data3, "../Data/preprocessingData/H_Seoul_PARK.csv", row.names = FALSE)

#읽는거 확인하기
read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_Seoul_PARK.csv")
