library(devtools)
library(ggmap)

# 데이터 불러오기
seoul_data <- read.csv("../Data/collectData/Y_seoul_university.csv", header = T, fileEncoding = "euc-kr")
seoul_data

str(seoul_data)

seoul_data <- seoul_data[,-(1:3)]
seoul_data <- seoul_data[,-(2:5)]
seoul_data <- seoul_data[,-(3:9)]

seoul_code <- as.character(seoul_data$주소)
seoul_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

seoul_code <- geocode(seoul_code)

# 좌표 변환 안되는곳 수동 입력
seoul_code$lon[63] = 126.947988
seoul_code$lat[63] = 37.542959

# 데이터 가공
seoul_data <- cbind(seoul_data, seoul_code)

seoul_data <- seoul_data[,-2]
seoul_data

write.csv(seoul_data, "../Data/preprocessingData/Y_University.csv", row.names = FALSE)
