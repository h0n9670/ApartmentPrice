library(devtools)
library(ggmap)
library(xlsx)

install.packages("readxl")
library(readxl)

# 데이터 불러오기
academy_data <- readxl::read_excel("../Data/collectData/Y_academy_east_north.xlsx", sheet = "동대문구 중랑구 학원")

# 중복값 제거
academy_data2 <- unique(academy_data)

# 주소 추출
academy_code <- as.character(academy_data2$학원주소)
academy_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDxB5P_GoIqF7KUzM4cRh9KUZbEYjbVfX4"
register_google(googleAPIkey)

academy_code <- geocode(academy_code)

# 결측치 확인 및 수정
sum(is.na(academy_code))

# 242 - 37.572688, 127.074026
# 261 - 37.574569, 127.073685
# 534 - 37.603286, 127.063604
# 586 - 37.571280, 127.074013

academy_code$lon[242] = 127.074026
academy_code$lat[242] = 37.572688

academy_code$lon[261] = 127.073685
academy_code$lat[261] = 37.574569

academy_code$lon[534] = 127.063604
academy_code$lat[534] = 37.603286

academy_code$lon[586] = 127.074013
academy_code$lat[586] = 37.571280

sum(is.na(academy_code))

# 출력된 좌표 결합
academy_data2 <- cbind(academy_data2, academy_code)
academy_data2

# CSV로 저장
write.csv(academy_data2, "../Data/preprocessingData/Y_academy_동대문구_중랑구.csv", row.names = FALSE)





