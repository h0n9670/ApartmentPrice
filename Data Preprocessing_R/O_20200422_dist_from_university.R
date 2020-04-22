# 주소 데이터에서 가까운 대학교와의 거리 비교

# 거리 계산
install.packages("geosphere")
library(geosphere)
library(dplyr)

# 아파트 주소 데이터
apt <- read.csv("..\\Data\\preprocessingData\\O_Base.csv",  stringsAsFactors = F)
apt <- unique(apt)

# 대학교 주소 데이터
sub <- read.csv("..\\Data\\preprocessingData\\Y_University.csv", fileEncoding = "UTF-8", stringsAsFactors = F)

# 주소별 최소 거리와 해당 장소를 저장하기위한 빈 객체 생성
distance <- c()
univer <- c()
lon <- c()
lat <- c()
# 좌표를 이용한 두 데이터간의 최소거리 구하기
apt_row <- nrow(apt)
for (i in 1:nrow(apt)){
  d <- 100000
  loc <- ""
  lo <- 0
  la <- 0
  print(i/apt_row*100)
  for (j in 1:nrow(sub)){
    dis <- distm(c(apt$long[i],apt$lat[i]),c(sub$lon[j],sub$lat[j]), fun = distHaversine)
    if (dis < d) {
      d <- dis
      loc <- sub$학교명[j]
      lo <- sub$lon[j]
      la <- sub$lat[j]
    }
  }
  distance <- c(distance,d)
  univer <- c(univer,loc)
  lon <- c(lon,lo)
  lat <- c(lat,la)
}

# 거리 데이터는 m단위 이기 때문에 km 으로 바꾸고 소수점 2자리 이하로 변환
dist_from_univ <- round(distance/1000,2)
View(dist_from_univ)

# apt 데이터에 거리 데이터 병합
df <- cbind(apt, dist_from_univ)

# 원본 파일에 덮어쓰기
write.csv(df,"..\\Data\\preprocessingData\\O_Base_merge.csv",  row.names = FALSE)

# 데이터 확인
check_df <- read.csv("..\\Data\\preprocessingData\\O_Base_merge.csv",  stringsAsFactors = F)

str(check_df)
sum(is.na(df))

# 원 주소의 좌표와 가까운 거리의 대학교 이름과 좌표를 보관하기 위한 데이터
df1 <- cbind(apt,distance,univer,lon,lat)
sum(is.na(df1))
str(df1)

write.csv(df,"..\\Data\\preprocessingData\\O_20200422_dist_from_uni.csv",row.names = FALSE)
