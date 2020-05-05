# 주소 데이터에서 가까운 고등학교와의 거리 비교

# 거리 계산
# install.packages("geosphere")
library(geosphere)
library(dplyr)

# 아파트 주소 데이터
apt2 <- read.csv("Base.csv",  stringsAsFactors = F)
apt <- unique(apt2)
# 고등학교 주소 데이터
sub <- read.csv("Y_highschool.csv", stringsAsFactors = F)
distance <- c()
univer <- c()
for (i in 1:nrow(apt)){
  d <- 100000
  loc <- ""
  print(i/nrow(apt)*100)
  for (j in 1:nrow(sub)){
    dis <- distm(c(apt$long[i],apt$lat[i]),c(sub$lon[j],sub$lat[j]), fun = distHaversine)
    if (dis < d) {
      d <- dis
      loc <- sub$학교명[j]
      
    }
  }
  distance <- c(distance,d)
  univer <- c(univer,loc)
}

df <- data.frame(apt$address, distance,univer, stringsAsFactors = F)
sum(is.na(df))


df1 <- left_join(apt2, df, by=c('address' = 'apt.address'))

sum(is.na(df1))
str(df1)

df1 <- rename(df1, highschool = univer)
df1 <- rename(df1, dist_from_highschool  = distance)

write.csv(df1,"address1.csv",row.names = FALSE)
