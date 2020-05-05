library(dplyr)


# 데이터 불러오기(기본 데이터, trash 데이터)
basic <- read.csv("../Data/preprocessingData/O_20200419_crime_foreigner.csv")
trash <- read.csv("../Data/collectData/O_20200419_trash.csv")



# 필요한 컬럼 선택
t1 <- trash[-c(1,2,3),c("V2","V8")]
t1 <- rename(t1, c(gu = V2,
                   trash = V8))
str(t1)

# 숫자 구분자 제거 
t1$trash <- gsub(",","",t1$trash) %>% as.numeric()


# 데이터 병합
basic1 <- left_join(basic,t1,by="gu")

# 병합 확인
head(basic1)
colnames(basic1)
sum(is.na(basic1$trash))



# 데이터 불러오기(구별 cctv 현황)
cctv <- read.csv("../Data/collectData/O_20200419_cctv.csv")

# 필요한 부분 선택
cc1 <- cctv[,c(1,2,9,10)]
cc1 <- rename(cc1, c(gu = 기관명,
                     cctv = 소계))
str(cc1)

# gu 컬럼 띄어쓰기 제거, 소계 컬럼에서 2017,2018년 cctv수 제거
cc1$gu <- gsub(" ","",cc1$gu)
cc1$cctv <- cc1$cctv - cc1$X2017년 - cc1$X2018년

cc2 <- cc1[,c(1,2)]

# 데이터 병합
basic2 <- left_join(basic1,cc2,by="gu")

# 병합 확인
head(basic2)
colnames(basic2)
sum(is.na(basic2$cctv))

# 데이터 저장
write.csv(basic2,"../Data/preprocessingData/O_20200419_cctv_trash.csv",row.names = FALSE)

# 저장데이터 확인
test <- read.csv("../Data/preprocessingData/O_20200419_cctv_trash.csv")
head(test)

