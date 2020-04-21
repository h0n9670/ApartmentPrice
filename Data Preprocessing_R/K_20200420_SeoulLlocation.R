# 기본 경로 설정
setwd("C:/ApartmentPrice/Data Preprocessing_R")

install.packages("rgdal")
install.packages("sp")

# 패키지 호출
library(sp)
library(rgdal)
library(dplyr)

# txt 파일을 한 번에 불러들이기 위해 for문 작성
# 데이터를 가져올 폴더 경로 설정 및 확인
dir <- ("C:/ApartmentPrice/Data/collectData");dir

# 빈 데이터프레임 생성
data <- data.frame()

data <- read.delim(paste(dir, K_20200421_entrcSeoul.txt, sep='\\'), sep="|", header=F)

# 구조 확인 및 
str(data)
head(data)


# lat&long's missing values exclude
d <- data %>% filter(is.na(V17)==FALSE, is.na(V18)==FALSE)

dim(data)
dim(d)

# CRS function 생성 (long:경도, lat:위도)
convertCRS <- function(long, lat, from.crs, to.crs){
     xy <- data.frame(long=long, lat=lat)
     coordinates(xy) <- ~long+lat
  
     from.crs <- CRS(from.crs)
     from.coordinates <- SpatialPoints(xy, proj4string=from.crs)
  
     to.crs <- CRS(to.crs)
     changed <- as.data.frame(SpatialPoints(spTransform(from.coordinates, to.crs)))
     names(changed) <- c("long","lat")
  
     return(changed)
}

# proj4 인자 설정 (GRS80 -> WGS84)
from.crs <- "+proj=tmerc +lat_0=38 +lon_0=127.5 +k=0.9996 +x_0=1000000 +y_0=2000000 +ellps=GRS80 +units=m +no_defs"
to.crs <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

# X좌표, Y좌표만 뽑아서 coord 생성
coord <- data.frame(grs.long=d[,17], grs.lat=d[,18])
str(coord)
head(coord)

# 위에서 뽑은 X,Y좌표를 경도, 위도로 변환 후 기존 데이터셋에 cbind로 열 결합
coord <- cbind(coord, convertCRS(coord$grs.long, coord$grs.lat, from.crs, to.crs))
head(coord)


# join 시 사용할 Key 값으로 X,Y 생성
d2 <- d %>% mutate(V19=paste0(V17, ',', V18))

# coord 데이터셋에도 동일한 값을 V19로 생성 후 V19, long, lat만 추출.
coord2 <- coord %>% mutate(V19=paste0(grs.long, ',', grs.lat)) %>% select(V19, long, lat)

# V19를 Key로 하여 원본 데이터에 long, lat을 left join
result <- left_join(d2, coord2, by="V19") %>% select(-c("V17","V18","V19"))

# csv로 저장
write.csv(result, paste(dir, file="address_convert.csv", sep='\\'), row.names=T)
