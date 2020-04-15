#패키지 설치
install.packages("dplyr")
install.packages("reshape")

#라이브러리 불러오기
library(dplyr)
library(reshape)

#데이터 불러오기
data <- read.csv("./Data/collectData/K_20200414_Period.csv")

#컬럼명 설정
data<-rename(data,c(단지명 = "Apart",
                       전용면적... = "size",
                       계약년월 = "date",
                       거래금액.만원. = "price"))

# date 수정
data$date <- gsub("2016","",data$date)
data$date <- gsub("0","",data$date)

# price 수정
data$price <- gsub(",","",data$price)
data$price <- as.numeric(data$price)

# size 수정
data$size <-as.numeric(data$size)

# pps(평당가격) 설정
data$pps <- data$price/data$size
data$pps <- round(data$pps)
data%>%select(Apart,date,pps)

# 평당평균가 설정
data <- aggregate(pps~date+Apart,
                  data,
                  mean)
data$pps <- round(data$pps)


# 아파트명 모으기
apart <- as.character(data$Apart)
apart <- unique(apart)

# 아파트명을 컬럼으로 date를 index로, pps를 해당 값으로 설정
dataM<-data%>%filter(Apart==apart[1])%>%select(date,pps)%>%rename(c(pps=apart[1]))
for (i in 2:length(apart)) {
  dataM <- merge(dataM,
                 data%>%filter(Apart==apart[i])%>%select(date,pps)%>%rename(c(pps=apart[i])),
                 by='date',
                 all=TRUE)
}

# 파일저장
write.csv(dataM,"./Data/preprocessingData/K_20200414_PreprocessingPeriod.csv",row.names = FALSE)
