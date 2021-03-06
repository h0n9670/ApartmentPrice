#경로설정
setwd("~/ApartmentPrice/Data Preprocessing_R")

#패키지 설치
install.packages("dplyr")
install.packages("reshape")
install.packages("tidyr")

#라이브러리 불러오기
library(dplyr)
library(reshape)
library(tidyr)

#데이터 불러오기
data <- read.csv("../Data/collectData/K_20200414_Period.csv")

#컬럼명 설정
data<-rename(data,c(단지명 = "Apart",
                       전용면적... = "size",
                       계약년월 = "date",
                       거래금액.만원. = "price",
                       시군구="gudong",
                       도로명="address",
                       층="floor",
                       건축년도="ConstructionYear"))

# date 수정
data$date <- gsub("201602","2",data$date)
data$date <- gsub("201603","3",data$date)
data$date <- gsub("201604","4",data$date)

# price 수정
data$price <- gsub(",","",data$price)
data$price <- as.numeric(data$price)

# size 수정
data$size <-as.numeric(data$size)

# pps(평당가격) 설정
data$pps <- data$price/data$size
data$pps <- round(data$pps)

# 2016시점에서 연식 계산
data$year <- 2016-data$ConstructionYear

# 군과 구로 나누기
data$gudong <- gsub("서울특별시 ","",data$gudong)
data <- separate(data,gudong,into=c("gu","dong"),
         sep=" ",
         remove=TRUE
         )

# 원하는 컬럼 추출(active용)
data <- data%>%select(Apart,pps,gu,dong,address,Apart,size,floor,year)

# 아파트이름만 추출(passive용)
ApartName <- unique(data%>%select(Apart,pps))

# 파일저장
write.csv(data,"../Data/preprocessingData/K_20200414_PreprocessingPeriod.csv",row.names = FALSE)
write.csv(ApartName,"../Data/preprocessingData/K_20200414_PreprocessingPeriodApartName.csv",row.names = FALSE)
