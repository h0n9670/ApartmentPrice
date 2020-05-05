setwd("~/ApartmentPrice/Data Preprocessing_R")

#import
library(dplyr)

#데이터불러오기
depart=read.csv("../Data/preprocessingData/H_distance_department2.csv")
mart=read.csv("../Data/preprocessingData/H_distance_mart1.csv")
park=read.csv("../Data/preprocessingData/H_distance_park3.csv")
elhigh=read.csv("../Data/preprocessingData/N_20200423_dist_from_highschool_elementaryschool.csv")
mer=read.csv("../Data/preprocessingData/O_Base_merge.csv")
academy=read.csv("../Data/preprocessingData/Y_academy_dist.csv")
subway=read.csv("../Data/preprocessingData/Y_subway_dist.csv")
crime_foreigner=read.csv("../Data/preprocessingData/O_20200419_crime_foreigner.csv")
cctv_trash=read.csv("../Data/preprocessingData/O_20200419_cctv_trash.csv")
data=read.csv("../Data/preprocessingData/K_20200422_PrepocessingBasicNonull.csv")
move=read.csv("../Data/preprocessingData/H_시군구별이동자수.csv")
pop=read.csv("../Data/preprocessingData/H_서울_시군구_별_인구수.csv")
data
#데이터확인 및 컬럼선정
head(depart)
departPick<-depart[c('address','dist_from_mart','dist_from_department')]
departPick<-unique(departPick)

head(mart)
martPick<-mart[c('address','dist_from_mart')]
martPick<-unique(martPick)

head(park)
parkPick<-park[c('address','dist_from_park')]
parkPick<-unique(parkPick)

head(elhigh)
elhighPick<-elhigh[c('address','dist_from_highschool','dist_from_elementaryschool')]
elhighPick<-unique(elhighPick)


head(mer)
merPick<-mer[c('address','dist_from_univ','dist_from_middleschool','dist_from_bus','dist_from_hospital')]
merPick<-unique(merPick)

head(academy)
academyPick<-academy[c('address','dist_from_academy')]
academyPick<-unique(academyPick)

head(subway)
subwayPick<-subway[c('address','dist_from_subway','dist_from_kinder')]
subwayPick<-unique(subwayPick)


head(crime_foreigner)
crime_foreignerPick<-crime_foreigner[c('gu','crime','arrest','foreigner')]
crime_foreignerPick<-unique(crime_foreignerPick)

head(cctv_trash)
cctv_trashPick<-cctv_trash[c('gu','trash','cctv')]
cctv_trashPick<-unique(cctv_trashPick)

head(move)
move$period<-move$X2016..02.월+move$X2016..03.월+move$X2016..04.월
movePick<-move[c('행정구역.시군구.별','period')]
movePick<-rename(movePick,'gu'='행정구역.시군구.별')
moveinPick<-movePick[1:25,]
moveoutPick<-movePick[26:50,]

head(pop)
pop$popu<-rowSums(pop[c('X2016..02','X2016..03','X2016..04')])
popPick<-pop[c('행정구역.시군구.별','popu')]
popPick<-rename(popPick,'gu'='행정구역.시군구.별')

data1<-merge(data,departPick,by="address",all.x=TRUE)
data2<-merge(data1,martPick,by="address",all.x=TRUE)
data3<-merge(data2,elhighPick,by="address",all.x=TRUE)
data4<-merge(data3,merPick,by="address",all.x=TRUE)
data5<-merge(data4,academyPick,by="address",all.x=TRUE)
data6<-merge(data5,crime_foreignerPick,by="gu",all.x=TRUE)
data7<-merge(data6,cctv_trashPick,by="gu",all.x=TRUE)
data8<-merge(data7,subwayPick,by="address",all.x=TRUE)
data9<-merge(data8,parkPick,by="address",all.x=TRUE)
data10<-merge(data9,moveoutPick,by="gu",all.x=TRUE)
data11<-merge(data10,moveinPick,by="gu",all.x=TRUE)
data12<-merge(data11,popPick,by="gu",all.x=TRUE)

sum(is.na(data12))

data12<-rename(data12,'in'='period.y')
data12<-rename(data12,'out'='period.x')
# CSV로 저장
write.csv(data12, "../Data/preprocessingData/K_20200425_sumVariable.csv", row.names = FALSE)
