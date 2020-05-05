install.packages("devtools")
install.packages("ggmap")
install.packages("xlsx")
library(devtools)
library(ggmap)
library(xlsx)

# 파일 불러오기
dep_data <- read.csv("../Data/collectData/N_20200421_서울시 롯데백화점.csv")
dep_data

# 주소 추출
dep_code <- as.character(dep_data$지번)
dep_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

dep_code <- geocode(dep_code)

# 결측치 확인 및 수정
sum(is.na(dep_code))

dep_data2 <- cbind(dep_data, dep_code)

# CSV로 저장
write.csv(dep_data2, "../Data/preprocessingData/Y_department_lotte.csv", row.names = FALSE)
