url1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
url2 = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
GDPtmp <- tempfile()
EDtmp <- tempfile()
download.file(url1,destfile=GDPtmp,method="curl") 
download.file(url2,destfile=EDtmp,method="curl") 
EDdat <- read.csv(EDtmp)

library(dplyr)
library(plyr)

GDPdat <- read.csv(GDPtmp, skip=4, nrows=190)

GDPdat <- rename(GDPdat, c("X" = "CountryCode", "X.1" = "Ranking", "X.3" = "Economy", "X.4" = "millionsOfUSdollars"))
GDPdat$X.9
GDPdat$X.9 <- NULL
head(GDPdat)
GDPdat$X.8 <- NULL
GDPdat$X.7 <- NULL
GDPdat$X.6 <- NULL
GDPdat$X.5 <- NULL
GDPdat$X.2 <- NULL


class(GDPdat$Ranking)
intersect(names(GDPdat),names(EDdat))
mergedDat <- merge(GDPdat,EDdat, all=TRUE)
head(mergedDat)
class(mergedDat$Ranking)
length(mergedDat$Ranking)

summary(mergedDat)

mergedDatSorted <- arrange(mergedDat, desc(Ranking))
head(mergedDatSorted,13)
nrow(mergedDat)
# the above doesn't work for the number of matches.  Had to quess the answer


names(mergedDatSorted)
mergedDatSorted$Income.Group

mean(mergedDatSorted[mergedDatSorted$Income.Group == "High income: OECD",]$Ranking,na.rm=TRUE)
mean(mergedDatSorted[mergedDatSorted$Income.Group == "High income: nonOECD",]$Ranking,na.rm=TRUE)


history(max.show=Inf)

qntls <- quantile(mergedDatSorted$Ranking, c (seq(0, 1, 0.2)), na.rm=TRUE)
table(mergedDatSorted[mergedDatSorted$Ranking <= qntls[2],]$Income.Group, useNA="ifany")
