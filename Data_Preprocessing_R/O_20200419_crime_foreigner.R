library(dplyr)


# 데이터 불러오기(기본 데이터, 범죄 데이터)
basic <- read.csv("../Data/preprocessingData/K_20200414_PreprocessingPeriod.csv")
crime <- read.csv("../Data/collectData/O_20200419_crime.csv", header =F)


# 필요한 컬럼 선택
c1 <- crime[-c(1,2,3),c("V2","V3","V4")]
c1 <- rename(c1, c(gu = V2,
                   crime = V3,
                   arrest = V4))

# 숫자 구분자 제거 
c1$crime <- gsub(",","",c1$crime) %>% as.numeric()
c1$arrest <- gsub(",","",c1$arrest) %>% as.numeric()

# 데이터 병합
c2 <- left_join(basic,c1,by="gu")

str(c2)


# 데이터 불러오기(등록 외국인 현황)
foreigner <- read.csv("../Data/collectData/O_20200419_foreigner.csv", header =F)

# 필요한 부분 선택
f1 <- foreigner[-c(1,2,3),] %>% filter(V3 == "소계") %>% select(V2,V4)
f1 <- rename(f1, c(gu = V2, foreigner = V4))
f1$foreigner <- as.character(f1$foreigner)
f1$foreigner <- as.numeric(f1$foreigner)

# 데이터 병합
c3 <- left_join(c2,f1,by="gu")


# 데이터 저장
write.csv(c3,"../Data/preprocessingData/O_20200419_crime_foreigner.csv",row.names = FALSE)



