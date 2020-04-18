# 한겨레 '서울 재개발' 키워드 검색 크롤링

#install.packages("stringr")
#install.packages("wordcloud")
#install.packages("KoNLP")
#install.packages("dplyr")
#install.packages("RColorBrewer")
#install.packages("rvest")
#install.packages("ggplot2")

#install.packages('rJava')
#install.packages('stringr')
#install.packages('hash')
#install.packages('Sejong')
#install.packages('RSQLite')
#install.packages('devtools')
#install.packages('tau')
#install.packages("https://cran.r-project.org/src/contrib/Archive/KoNLP/KoNLP_0.80.2.tar.gz", repos = NULL, type="source")

library(stringr) # 문자열 조작하는 전문 패키지
library(wordcloud) # 시각화작업 시 필요한 패키지
library(KoNLP) # 명사 추출과 같은 작업을 위한 사전을 포함하고 있는 패키지
library(dplyr) # 데이터프레임을 수정하거나 합하거나 하는 데이터프레임에 관련된 함수를 가진 패키지
library(RColorBrewer) # 색상과 관련된 패키지, 시각화작업에서 필요하다.
library(memoise) # mf <- 메모(f)는 f의 메모 사본인 mf를 작성한다. 
library(rvest)

#############################################여기서부터 텍스트마이닝########한겨레##################
setwd("~/ApartmentPrice/Data Preprocessing_R")

useNIADic() 

for(i in 1:100){
  url <- paste0('http://search.hani.co.kr/Search?command=query&keyword=%EC%84%9C%EC%9A%B8%20%EC%9E%AC%EA%B0%9C%EB%B0%9C&media=news&submedia=&sort=d&period=all&datefrom=2000.01.01&dateto=2020.04.13&pageseq=',i)
  k <- read_html(url, encoding="utf-8")
  k <- k %>% 
    html_nodes("dt") %>% 
    html_nodes("a") %>% 
    html_attr("href")
  
  for(addr in k){
    temp <- read_html(addr) %>% html_nodes(".text") %>% 
      html_text()                                                     
    cat(temp, file="temp2.txt", append=TRUE)
  }#for END
}

txt <- readLines("temp2.txt")
txt2 <- grep("[가-힣]", txt, value=T)
nouns <- extractNoun(txt2)
wordcount <- table(unlist(nouns))

df_word <- as.data.frame(wordcount, stringsAsFactors = F)

df_word <- filter(df_word, nchar(Var1) >= 2)

dim(df_word)
View(df_word)
#서울 재개발 키워드 빈도수 파일 생성
#write.csv(df_word, 'C:\\rStudy\\StudyFiles\\dataset\\서울_재개발_키워드.csv')
#read.csv()


pal <- brewer.pal(8, "Dark2")
set.seed(1234)
wordcloud(words=df_word$Var1,
          freq=df_word$Freq,
          min.freq = 2, max.words = 500,
          random.order = F,
          rot.per = .1, scale=c(4,0.3),
          colors=pal)