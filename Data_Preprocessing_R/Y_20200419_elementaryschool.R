library(devtools)
library(ggmap)
library(xlsx)

# 데이터 불러오기
elementary_data <- read.xlsx("../Data/collectData/Y_school.xls", sheetName = "초등학교", header = T)
elementary_data

# NA 제거
elementary_data <- elementary_data[,-4]

# 주소 추출
elementary_code <- as.character(elementary_data$주소)
elementary_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

elementary_code <- geocode(elementary_code)

# 결측치 확인
sum(is.na(elementary_code))

# 출력된 좌표 결합
elementary_data <- cbind(elementary_data, elementary_code)
elementary_data

# CSV로 저장
write.csv(elementary_data, "../Data/preprocessingData/Y_elementary.csv", row.names = FALSE)
