library(devtools)
library(ggmap)
library(xlsx)

# 데이터 불러오기
high_data <- read.xlsx("../Data/collectData/Y_school.xls", sheetName = "고등학교", header = T)
high_data

# NA 제거
high_data <- high_data[,c(1,2)]
high_data

# 주소 추출
high_code <- as.character(high_data$주소)
high_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

high_code <- geocode(high_code)

# 결측치 확인 및 수정
sum(is.na(high_code))

# 37.584303, 126.927447
high_code$lon[143] = 126.927447
high_code$lat[143] = 37.584303

sum(is.na(high_code))

# 출력된 좌표 결합
high_data <- cbind(high_data, high_code)
high_data

# CSV로 저장
write.csv(high_data, "../Data/preprocessingData/Y_highschool.csv", row.names = FALSE)
