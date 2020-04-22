library(devtools)
library(ggmap)
library(xlsx)
install.packages("xlsx")
install.packages("ggmap")
install.packages("readxl")
library(readxl)

setwd("~/ApartmentPrice/Data Preprocessing_R")
# 데이터 불러오기
metro_data <- read.csv("../Data/collectData/N_20200421_distance_data/N_20200421_서울시 서울교통공사 역별 주소 현황 및 전화번호.csv")
# 중복값 제거
metro_data2 <- unique(metro_data)

# 주소 추출
metro_code <- as.character(metro_data2$상세주소)
metro_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDaqk0cpRrmBkT6-77TZLq2LUuml_mnro0"
register_google(googleAPIkey)

metro_code <- geocode(metro_code)

# 결측치 확인 및 수정
sum(is.na(metro_code))

# NA값이 있는 행 찾기 및 제거
metro_data2 <- cbind(metro_data2, metro_code)
metro_data2[!complete.cases(metro_data2), ]

metro_data3 <- na.omit(metro_data2)

sum(is.na(metro_data3))

# CSV로 저장
write.csv(metro_data3, "../Data/preprocessingData/H_Seoul_METRO.csv", row.names = FALSE)

#읽는거 확인하기
read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_Seoul_METRO.csv")
