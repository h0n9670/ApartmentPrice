# 경로지정
setwd("~/ApartmentPrice/Data Preprocessing_R")

# 마트 데이터 읽기
data1 <- read.csv('../Data/preprocessingData/H_Seoul_COSTCO.csv')
data2 <- read.csv('../Data/preprocessingData/H_Seoul_EMART.csv')
data3 <- read.csv('../Data/preprocessingData/H_Seoul_HANAROMART.csv')
data4 <- read.csv('../Data/preprocessingData/H_Seoul_HIMART.csv')
data5 <- read.csv('../Data/preprocessingData/H_Seoul_HOMEPLUS.csv')
data6 <- read.csv('../Data/preprocessingData/H_Seoul_LOTTEMART.csv')
data7 <- read.csv('../Data/preprocessingData/H_Seoul_MEGAMART.csv')
data8 <- read.csv('../Data/preprocessingData/H_Seoul_STARFIELD.csv')
data9 <- read.csv('../Data/preprocessingData/H_Seoul_TRADUS.csv')

#백화점 데이터 읽기
d_data1 <- read.csv('../Data/preprocessingData/Y_department_hyundai.csv')
d_data2 <- read.csv('../Data/preprocessingData/Y_department_lotte.csv')
d_data3 <- read.csv('../Data/preprocessingData/Y_department_shinsegae.csv')



data_result <- rbind(data1, data2, data3, data4, data5, data6, data7, data8, data9)
sum(is.na(data_result))
write.csv(data_result, '../Data/preprocessingData/H_TOTAL_MART.csv', row.names = FALSE)

d_data_result <- rbind(d_data1, d_data2, d_data3)
sum(is.na(d_data_result))
write.csv(d_data_result, '../Data/preprocessingData/H_TOTAL_department.csv', row.names = FALSE)

# 데이터 저장 후 각 주소에서 NA 값이 있음.
# 이 주소값은 지번 주소를 찾아서 도로명주소로 수동으로 값을 입력하여 처리함
# 도로명 주소의 na값을 0개로 만들고 지번 주소의 셀은 삭제하였음

# 데이터 불러오기
final_mart <- read.csv('../Data/preprocessingData/H_FINALL_MART.csv')
final_department <- read.csv('../Data/preprocessingData/H_FINAL_department.csv')

# 데이터 출력
final_mart
final_department
