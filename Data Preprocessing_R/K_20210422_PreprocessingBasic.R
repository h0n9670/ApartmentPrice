#작업경로 설정
setwd("~/ApartmentPrice/Data Preprocessing_R")

#install
install.packages("dplyr")
install.packages("xlsx")
install.packages("ggmap")
install.packages("readxl")
install.packages("devtools")
install.packages("reshape")

#library
library(dplyr)
library(devtools)
library(ggmap)
library(xlsx)
library(readxl)
library(reshape)
library(plyr)

#파일 읽기
data=read.csv("~/ApartmentPrice/Data/preprocessingData/K_20200414_PreprocessingPeriod.csv")
location=read.csv("~/ApartmentPrice/Data/preprocessingData/K_20200421_PreprocessingEntrcSeoul.csv")

#데이터보기
head(data)
head(location)

#-값제거
splitMinus=data.frame(do.call('rbind',strsplit(as.character(data$address),split="-")))
data$address<-splitMinus$X1

#데이터 합치기
data_location <- merge(x=data,
                       y=location,
                       by='address',
                       all.x=TRUE)
#널값확인
nrow(data_location)
colSums(is.na(data_location))

#34개의 유니크한 널값 주소확인
nullData <- data_location%>%filter(is.na(lat))
uniqueNullData<-unique(nullData$address)
uniqueNullData

# 주소 추출
address_code <- as.character(uniqueNullData)
address_code

# 구글 API활용 좌표 출력
googleAPIkey <- "AIzaSyDnC8_26g3cfLwpjyKBIEaxpstMdJDA9bM"
register_google(googleAPIkey)

address1_code <- geocode(address_code)
uniqueNullData_code<-cbind(uniqueNullData,address1_code)
uniqueNullData_code

# 난계로 10길 9 : 37.563546, 127.025817
# 상원길 15 : 37.550772, 127.048248
uniqueNullData_code$lon[8]<-127.025817
uniqueNullData_code$lat[8]<-37.563546
uniqueNullData_code$lon[16]<-127.048248
uniqueNullData_code$lat[16]<-37.550772
uniqueNullData_code

#널갑 1차 처리 데이터 준비
willSumData <- uniqueNullData_code[-c(1,2),]
willSumData$uniqueNullData
willSumData1<-rename(willSumData,c(uniqueNullData="address"))

#1차 널값 처리

for (i in 1:nrow(willSumData1)){
  for (j in 1:nrow(data_location)){
    if (data_location$address[j]==willSumData1$address[i]){
      data_location$long[j]=willSumData1$lon[i]
      data_location$lat[j]=willSumData1$lat[i]
      }
    }
  }

#널값 확인
nrow(data_location)
colSums(is.na(data_location))

#28개의 널값 주소확인
nullData2 <- data_location%>%filter(is.na(lat))
nullData2
uniqueNullData2<-unique(nullData2$Apart)
uniqueNullData2

#강남한신휴플러스6단지 : 37.468035, 127.105484
#강남한신휴플러스8단지 : 37.469393, 127.111247
#신내 데시앙포레 : 37.615403, 127.109678
#삼성 : 37.611107, 126.978884
#래미안첼리투스아파트 : 37.517197, 126.979877
#신내우디안1단지 : 37.617057, 127.106723
#꿈의숲 SK VIEW : 37.620641, 127.053828

#데이터프레임 만들기
Apart<-c("강남한신휴플러스6단지","강남한신휴플러스8단지","신내 데시앙포레","삼성",
         "래미안첼리투스아파트","신내우디안1단지","꿈의숲 SK VIEW")
long<-c(127.105484,127.111247,127.109678,126.978884,126.979877,127.106723,127.053828)
lat<-c(37.468035,37.469393,37.615403,37.611107,37.517197,37.617057,37.620641)
lastNullData <-data.frame(Apart,long,lat)

#2차 널값 처리
for (i in 1:nrow(lastNullData)){
  for (j in 1:nrow(data_location)){
    if (data_location$Apart[j]==lastNullData$Apart[i]){
      data_location$long[j]=lastNullData$long[i]
      data_location$lat[j]=lastNullData$lat[i]
      }
    }
  }

#3차 널값 확인
#널값 확인
nrow(data_location)
colSums(is.na(data_location))

write.csv(data_location, "~/ApartmentPrice/Data/preprocessingData/K_20200422_PrepocessingBasic.csv", row.names = FALSE)
