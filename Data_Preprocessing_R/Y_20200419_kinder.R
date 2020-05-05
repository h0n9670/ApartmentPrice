library(devtools)
library(ggmap)
library(xlsx)

# 데이터 불러오기
kinder_data <- read.xlsx("../Data/collectData/Y_school.xls", sheetName = "유치원", header = T)
kinder_data

# NA 제거
kinder_data <- kinder_data[-(203:204),]

# 주소추출
kinder_code <- as.character(kinder_data$주소)
kinder_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

kinder_code <- geocode(kinder_code)

# 출력된 좌표 결합
kinder_data <- cbind(kinder_data, kinder_code)
kinder_data

# CSV로 저장
write.csv(kinder_data, "../Data/preprocessingData/Y_kindergarten.csv", row.names = FALSE)
