#패키지 설치
install.packages("dplyr")
install.packages("reshape")

#라이브러리 불러오기
library(dplyr)
library(reshape)

#데이터 불러오기
data_2015 <- read.csv("../Data/collectData/K_20200414_2015.csv")
data_2014 <- read.csv("../Data/collectData/K_20200419_2014.csv")
data_2013 <- read.csv("../Data/collectData/K_20200419_2013.csv")
data_2012 <- read.csv("../Data/collectData/K_20200419_2012.csv")
data_2011 <- read.csv("../Data/collectData/K_20200419_2011.csv")
data_2010 <- read.csv("../Data/collectData/K_20200419_2010.csv")
data_2009 <- read.csv("../Data/collectData/K_20200419_2009.csv")
data_2008 <- read.csv("../Data/collectData/K_20200419_2008.csv")
data_Period <- read.csv("../Data/collectData/K_20200414_Period.csv")

data_Period <- data_Period%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2014 <- data_2014%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2013 <- data_2013%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2012 <- data_2012%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2011 <- data_2011%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2010 <- data_2010%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2009 <- data_2009%>%select(단지명,전용면적...,계약년월,거래금액.만원.)
data_2008 <- data_2008%>%select(단지명,전용면적...,계약년월,거래금액.만원.)

#데이터 합치기 1502-1604
data <- rbind(data_Period,data_2015)
data <- rbind(data,data_2014)
data <- rbind(data,data_2013)
data <- rbind(data,data_2012)
data <- rbind(data,data_2011)
data <- rbind(data,data_2010)
data <- rbind(data,data_2009)
data <- rbind(data,data_2008)

#컬럼명 설정
data<-rename(data,c(단지명 = "Apart",
                       전용면적... = "size",
                       계약년월 = "date",
                       거래금액.만원. = "price"))

# date 수정
#data$date <- gsub("201601","13",data$date)
#data$date <- gsub("201602","14",data$date)
#data$date <- gsub("201603","15",data$date)
#data$date <- gsub("201604","16",data$date)
#data$date <- gsub("2015","",data$date)

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
write.csv(dataM,"../Data/preprocessingData/K_20200419_preprocessing08_16.csv",row.names = FALSE)
