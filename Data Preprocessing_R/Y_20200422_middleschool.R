library(devtools)
library(ggmap)
library(xlsx)

install.packages("readxl")
library(readxl)

# 데이터 불러오기
academy_data <- readxl::read_excel("../Data/collectData/Y_school.xls", sheet = "중학교")

# 중복값 제거
academy_data2 <- unique(academy_data)

# 주소 추출
academy_code <- as.character(academy_data2$주소)
academy_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

academy_code <- geocode(academy_code)

# 결측치 확인 및 수정
sum(is.na(academy_code))

# NA값이 있는 행 찾기 및 제거
academy_data2 <- cbind(academy_data2, academy_code)
academy_data2[!complete.cases(academy_data2), ]

academy_data3 <- na.omit(academy_data2)

sum(is.na(academy_data3))

# CSV로 저장
write.csv(academy_data3, "../Data/preprocessingData/Y_middleschool2.csv", row.names = FALSE)
