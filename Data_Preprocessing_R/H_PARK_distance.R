# 거리 계산
install.packages("geosphere")
library(geosphere)
library(dplyr)

# 베이스 주소 데이터

park2 <- read.csv("H_distance_department2.csv",  stringsAsFactors = F)
head(park2)
park <- unique(park2)
head(park)

# 마트 주소 데이터
sub <- read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_Seoul_PARK.csv", stringsAsFactors = F)
head(sub)

distance <- c()
univer <- c()

for (i in 1:nrow(park)){
  d <- 100000
  loc <- ""
  print(i/nrow(park)*100)
  for (j in 1:nrow(sub)){
    dis <- distm(c(park$lon[i],park$lat[i]),c(sub$lon[j],sub$lat[j]), fun = distHaversine)
    if (dis < d) {
      d <- dis
      loc <- sub$도로명[j]
    }
  }
  distance <- c(distance,d)
  univer <- c(univer,loc)
}

df <- data.frame(park$address, distance,univer, stringsAsFactors = F)
sum(is.na(df))


df1 <- left_join(park2, df, by=c('address' = 'park.address'))

sum(is.na(df1))
str(df1)
head(df1)

df1 <- rename(df1, c(park = univer, dist_from_park = distance ))
head(df1)

write.csv(df1,"C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_distance_park3.csv",row.names = FALSE)
