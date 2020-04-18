#http://kosis.kr/
#서울시/구별 전입, 전출자 수 추이
setwd("~/ApartmentPrice/Data Preprocessing_R")
c <- read.csv('~/ApartmentPrice/Data/preprocessingData/H_시군구별이동자수.csv')
View(c[1:25,]) #서울 구별 전입
View(c[25:50,]) #서울 구별 전출

#http://kosis.kr/statHtml/statHtml.do?orgId=101&tblId=DT_1YL20651E&vw_cd=MT_GTITLE01&list_id=101&seqNo=&lang_mode=ko&language=kor&obj_var_id=&itm_id=&conn_path=MT_GTITLE01
#서울시 주민등록인구 추이
pop <- read.csv('~/ApartmentPrice/Data/preprocessingData/H_서울_시군구_별_인구수.csv')
View(pop)

#http://www.index.go.kr/potal/main/EachDtlPageDetail.do?idx_cd=1240
#주택 매매가격 증감율 추이
sell <- read.csv('~/ApartmentPrice/Data/preprocessingData/H_주택매매가격동향.csv')
View(sell)


#http://www.r-one.co.kr/rone/resis/statistics/statisticsViewer.do
#부동산 통계뷰어


# http://rtdown.molit.go.kr/
# 20160102 ~ 20170101 까지의 서울시 아파트 매매 실거래가(층수 포함)
#아파트 층수와 가격의 관계 & 강변에 위치한 아파트 층수와 가격의 관계 유의미를 따진 논문을 참고할 수 는 있다고 판단됨
realprice<- read.csv('~/ApartmentPrice/Data/preprocessingData/H_아파트매매실거래가2016.csv')
View(realprice)

#######대교명과 좌표를 따옴
#lonlat <- read.table('C:\\rStudy\\StudyFiles\\dataset\\서울대교좌표.txt',header=T,sep=',')
#write.csv(lonlat, 'C:\\rStudy\\StudyFiles\\dataset\\서울대교좌표.csv', )
seoulbridge <- read.csv('~/ApartmentPrice/Data/preprocessingData/H_서울대교좌표.csv')
View(seoulbridge)

#https://data.seoul.go.kr/dataList/175/S/2/datasetView.do
#서울 대규모 점포 현황
martInSeoul <- read.csv('~/ApartmentPrice/Data/preprocessingData/H_2016서울대규모점포현황.csv',header=T)
View(martInSeoul)
head(martInSeoul)
