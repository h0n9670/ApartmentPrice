# 거리 계산
install.packages("geosphere")
library(geosphere)
library(dplyr)

# 베이스 주소 데이터

department2 <- read.csv("H_distance_mart1.csv",  stringsAsFactors = F)
head(department2)
department <- unique(department2)
head(department)

# 마트 주소 데이터
sub <- read.csv("C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_FINAL_department.csv", stringsAsFactors = F)

distance <- c()
univer <- c()

for (i in 1:nrow(department)){
  d <- 100000
  loc <- ""
  print(i/nrow(department)*100)
  for (j in 1:nrow(sub)){
    dis <- distm(c(department$lon[i],department$lat[i]),c(sub$lon[j],sub$lat[j]), fun = distHaversine)
    if (dis < d) {
      d <- dis
      loc <- sub$지점[j]
    }
  }
  distance <- c(distance,d)
  univer <- c(univer,loc)
}

df <- data.frame(department$address, distance,univer, stringsAsFactors = F)
sum(is.na(df))


df1 <- left_join(department2, df, by=c('address' = 'department.address'))

sum(is.na(df1))
str(df1)
head(df1)

df1 <- rename(df1, c(department = univer, dist_from_department = distance ))
head(df1)

write.csv(df1,"C:\\Users\\USER\\Documents\\ApartmentPrice\\Data\\preprocessingData\\H_distance_department2.csv",row.names = FALSE)
