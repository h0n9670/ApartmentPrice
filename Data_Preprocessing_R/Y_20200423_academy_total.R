data1 <- read.csv('../Data/preprocessingData/Y_academy_강북구_성북구.csv')
data2 <- read.csv('../Data/preprocessingData/Y_academy_관악구_성북구.csv', fileEncoding='utf-8')
data3 <- read.csv('../Data/preprocessingData/Y_academy_도봉구_노원구.csv')
data4 <- read.csv('../Data/preprocessingData/Y_academy_동대문구_중랑구.csv', fileEncoding='utf-8')
data5 <- read.csv('../Data/preprocessingData/Y_academy_성동구_광진구.csv')
data6 <- read.csv('../Data/preprocessingData/Y_academy_영등포구_구로구_금천구.csv')
data7 <- read.csv('../Data/preprocessingData/Y_academy_은평구_서대문구_마포구.csv')
data8 <- read.csv('../Data/preprocessingData/H_academy_강남구_서초구.csv')
data9 <- read.csv('../Data/preprocessingData/H_academy_강동구_송파구.csv')
data10 <- read.csv('../Data/preprocessingData/H_academy_강서구_양천구.csv')
data11 <- read.csv('../Data/preprocessingData/H_academy_용산구_종로구_중구.csv')

data_result <- rbind(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11)

sum(is.na(data_result))

write.csv(data_result, '../Data/preprocessingData/Y_academy_coordinates.csv', row.names = FALSE)
