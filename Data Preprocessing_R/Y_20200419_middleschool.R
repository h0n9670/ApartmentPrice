library(devtools)
library(ggmap)
library(xlsx)

# 데이터 불러오기
middle_data <- read.xlsx("../Data/collectData/Y_school.xls", sheetName = "중학교", header = T)
middle_data

# NA 제거
middle_data <- middle_data[,c(1,2)]
middle_data

# 주소 추출
middle_code <- as.character(middle_data$주소)
middle_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

middle_code <- geocode(middle_code)

# 결측치 확인
sum(is.na(middle_code))

# 출력된 좌표 결합
middle_data <- cbind(middle_data, middle_code)
middle_data

# CSV로 저장
write.csv(middle_data, "../Data/preprocessingData/Y_middleschool.csv", row.names = FALSE)
