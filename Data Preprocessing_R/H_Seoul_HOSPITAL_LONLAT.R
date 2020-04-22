library(devtools)
library(ggmap)
library(xlsx)
install.packages("xlsx")
install.packages("ggmap")
install.packages("readxl")
library(readxl)

setwd("~/ApartmentPrice/Data Preprocessing_R")
# 데이터 불러오기
hospital_data <- read.csv("../Data/collectData/N_20200421_distance_data/N_20200421_서울시 병원 주소.csv")
# 중복값 제거
hospital_data2 <- unique(hospital_data)

# 주소 추출
hospital_code <- as.character(hospital_data2$지번)
hospital_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDaqk0cpRrmBkT6-77TZLq2LUuml_mnro0"
register_google(googleAPIkey)

hospital_code <- geocode(hospital_code)

# 결측치 확인 및 수정
sum(is.na(hospital_code))

# NA값이 있는 행 찾기 및 제거
hospital_data2 <- cbind(hospital_data2, hospital_code)
hospital_data2[!complete.cases(hospital_data2), ]

hospital_data3 <- na.omit(hospital_data2)

sum(is.na(hospital_data3))

# CSV로 저장
write.csv(hospital_data3, "../Data/preprocessingData/H_Seoul_hospital.csv", row.names = FALSE)

#읽는거 확인하기
read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_Seoul_hospital.csv")
