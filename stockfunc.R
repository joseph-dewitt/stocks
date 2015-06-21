#this is a script to store, list, and hopefully later
#analyse stock data
#the first step is make a character list
#i also have to include the quantmod library
library(XML)
library(quantmod)
library(rvest)
#these lines read tables and make lists of ticker symbols
url500 <- "http://en.wikipedia.org/wiki/List_of_S%26P_500_companies"
table500 <- url500 %>%
  html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/table[1]') %>%
  html_table()
  table500 <- table500[[1]]
  list500 <- table500[,"Ticker symbol"]
table400 <- html('http://en.wikipedia.org/wiki/List_of_S%26P_400_companies')[[1]]
  list400 <- table400[,"Ticker Symbol"]
#capital S on this one
table600<-read.csv("smallcap.csv",header=TRUE)
#this is an excel file from a website i had to make an account for
#currently looking for alternative sources
  list600<-table600[,"SYM"]
#the lists were of factors, they need to be characters...
clist500<-as.character(list500)
clist400<-as.character(list400)
clist600<-as.character(list600)
#...so they can be combined properly
masterlist<-c(clist400,clist500,clist600)
#getFinancials doesn't work with lapply
#so a for loop will hopefully work
for(i in 1:length(list500)){
  try(
    getFinancials(list500[i])
  )
}

