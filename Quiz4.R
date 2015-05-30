#1
tmp <- tempfile()
url1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(url1,destfile=tmp,method="curl")
names(tmp)
head(tmp)
dat <- read.csv(tmp)
names(dat)
splitnames <- strsplit(names(dat),"wgtp")

#2
url2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
tmp2 <- tempfile()
download.file(url2,destfile=tmp2,method="curl")
dat2 <- read.csv(tmp2, header=FALSE,skip=5, nrow=190)
mean(as.numeric(gsub(",","",dat2[,5])), na.rm=TRUE)

#3

grep("^United", dat2[,4], value=TRUE)

#4

url3 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url4 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
tmp3 <- tempfile()
tmp4 <- tempfile()
download.file(url3,destfile=tmp3,method="curl")
download.file(url4,destfile=tmp4,method="curl")

dat3 <- read.csv(tmp3, header=FALSE,skip=5, nrow=190)
dat4 <- read.csv(tmp4)

colnames(dat3)[1] <- "CountryCode"

dat5 <- merge(dat3, dat4)
grep("end: June",dat5[,"Special.Notes"],value=TRUE)


#5
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

length(grep(2012,sampleTimes))
length(grep("Mon",format(as.Date(grep(2012,sampleTimes,value=TRUE)), "%a %b %Y")))
