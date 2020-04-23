# 거리 계산
install.packages("geosphere")
library(geosphere)
library(dplyr)

# 베이스 주소 데이터

mart2 <- read.csv("Base.csv",  stringsAsFactors = F)
mart <- unique(mart2)

# 마트 주소 데이터
sub <- read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_FINAL_MART.csv", stringsAsFactors = F)

distance <- c()
univer <- c()

for (i in 1:nrow(mart)){
  d <- 100000
  loc <- ""
  print(i/nrow(mart)*100)
  for (j in 1:nrow(sub)){
    dis <- distm(c(mart$lon[i],mart$lat[i]),c(sub$lon[j],sub$lat[j]), fun = distHaversine)
    if (dis < d) {
      d <- dis
      loc <- sub$지점[j]
    }
  }
  distance <- c(distance,d)
  univer <- c(univer,loc)
}

df <- data.frame(mart$address, distance,univer, stringsAsFactors = F)
sum(is.na(df))


df1 <- left_join(mart2, df, by=c('address' = 'mart.address'))

sum(is.na(df1))
str(df1)
head(df1)

df1 <- rename(df1, c(mart = univer, dist_from_mart = distance ))
head(df1)

write.csv(df1,"C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_distance_mart1.csv",row.names = FALSE)
