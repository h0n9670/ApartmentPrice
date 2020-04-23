# 주소 데이터 와 가까운 버스 정류장과의 거리

# 거리 계산
install.packages("geosphere")
library(geosphere)
library(dplyr)
library(readxl)

getwd()
setwd("C:\\apt\\ApartmentPrice\\Data Preprocessing_R")
# 아파트 주소 데이터
apt <- read.csv("..\\Data\\preprocessingData\\O_Base.csv",  stringsAsFactors = F)
# 머지 할 데이터
merge <- read.csv("..\\Data\\preprocessingData\\O_Base_merge.csv",  stringsAsFactors = F)

# 버스 정류장 위치 데이터
sub <- read_xls("..\\Data\\collectData\\N_20200421_distance_data\\N_20200421_서울시 버스정류소 위치 데이터(20180502).xls")

str(sub)

sub$X좌표 <- as.numeric(sub$X좌표)
sub$Y좌표 <- as.numeric(sub$Y좌표)

str(sub)
sum(is.na(sub))

# 주소별 최소 거리와 해당 장소를 저장하기위한 빈 객체 생성
distance <- c()
place <- c()
lon <- c()
lat <- c()
code <- c()

# 좌표를 이용한 두 데이터간의 최소거리 구하기
apt_row <- nrow(apt)
for (i in 1:nrow(apt)){
  d <- 100000
  loc <- ""
  lo <- 0
  la <- 0
  co <- ""
  print(i/apt_row*100)
  for (j in 1:nrow(sub)){
    dis <- distm(c(apt$long[i],apt$lat[i]),c(sub$X좌표[j],sub$Y좌표[j]), fun = distHaversine)
    if (dis < d) {
      d <- dis
      loc <- sub$정류소명[j]
      lo <- sub$X좌표[j]
      la <- sub$Y좌표[j]
      co <-sub$정류소번호[j]
    }
  }
  distance <- c(distance,d)
  place <- c(place,loc)
  lon <- c(lon,lo)
  lat <- c(lat,la)
  code <- c(code,co)
}

# 거리 데이터는 m단위 이기 때문에 km 으로 바꾸고 소수점 2자리 이하로 변환
dist_from_bus <- round(distance/1000,2)
View(dist_from_bus)

# merge 데이터에 거리 데이터 병합
df <- cbind(merge, dist_from_bus)

# 원본 파일에 덮어쓰기
write.csv(df,"..\\Data\\preprocessingData\\O_Base_merge.csv",  row.names = FALSE)

# 데이터 확인
check_df <- read.csv("..\\Data\\preprocessingData\\O_Base_merge.csv",  stringsAsFactors = F)

str(check_df)
sum(is.na(df))

# 원 주소의 좌표와 가까운 거리의 대학교 이름과 좌표를 보관하기 위한 데이터
df1 <- cbind(apt,distance,place,code,lon,lat)
sum(is.na(df1))
str(df1)

write.csv(df1,"..\\Data\\preprocessingData\\O_20200423_dist_from_busstop.csv",row.names = FALSE)
