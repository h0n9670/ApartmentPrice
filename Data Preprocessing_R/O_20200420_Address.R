#원본 데이터에 번지 데이터가 잘못된것 수정하고
# 아파트별 좌표를 뽑기위한 주소 정제

setwd("C:/apt/ApartmentPrice/Data Preprocessing_R")

library(dplyr)

# 2016년 2,3,4 월 실거래가 데이터 불러오기
apt <-read.csv("../Data/collectData/K_20200414_Period.csv")

head(apt)
str(apt)
sum(is.na(apt$본번))
class(apt)

# apt 데이터를 보면 번지에 12월 2일, jul-3 과같이 주소 형식이 아닌 컬럼이 들어있다.
# 그래서 정상적으로  된 본번, 부번 컬럼으로 만 된 컬럼들로 번지를 다시 만들어준다.

apt$addr <- ifelse(apt$부번==0 , apt$본번, paste(apt$본번,apt$부번,sep = "-"))
View(apt$addr)

apt$address <- paste(apt$시군구,apt$addr)

# 죄표 알아 내기전 같은 주소를 갖는 열 제거 하기 위해  unique() 사용
addr <- unique(apt$address) %>% as.data.frame()
addr <- rename(addr,c(address = .))
str(addr)
View(addr)


# 파일 저장
write.csv(addr,"../Data/preprocessingData/O_20200420_APT_address.csv",row.names = FALSE)
