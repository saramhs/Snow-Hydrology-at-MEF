# Package ID: edi.573.1 Cataloging System:https://pasta.edirepository.org.
# Data set title: Marcell Experimental Forest breakpoint streamflow, 1962 - ongoing.
# Data set creator:  Stephen Sebestyen - Marcell Experimental Forest 
# Data set creator:  Elon Verry - USDA Forest Service, Northern Research Station, retired 
# Data set creator:  Arthur Elling - USDA Forest Service, Northern Research Station, retired 
# Data set creator:  Richard Kyllander - USDA Forest Service, Northern Research Station, retired 
# Data set creator:  Nina Lany - USDA Forest Service, Northern Research Station 
# Data set creator:  Randall Kolka - USDA Forest Service, Northern Research Station 
# Contact:    -  Data Manager, Marcell Experimental Forest  - nina.lany@usda.gov
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/573/1/2aca4b900546e80ed7dd409ff1ad9787" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


s2 <-read.csv(infile1,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "Peatland",     
                 "DateTime",     
                 "Stage.ft",     
                 "Q.cfs",     
                 "q.mmh",     
                 "q.interval"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(s2$Peatland)!="factor") s2$Peatland<- as.factor(s2$Peatland)                                   
# attempting to convert s2$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1DateTime<-as.POSIXct(s2$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DateTime) == length(tmp1DateTime[!is.na(tmp1DateTime)])){s2$DateTime <- tmp1DateTime } else {print("Date conversion failed for s2$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1DateTime) 
if (class(s2$Stage.ft)=="factor") s2$Stage.ft <-as.numeric(levels(s2$Stage.ft))[as.integer(s2$Stage.ft) ]               
if (class(s2$Stage.ft)=="character") s2$Stage.ft <-as.numeric(s2$Stage.ft)
if (class(s2$Q.cfs)=="factor") s2$Q.cfs <-as.numeric(levels(s2$Q.cfs))[as.integer(s2$Q.cfs) ]               
if (class(s2$Q.cfs)=="character") s2$Q.cfs <-as.numeric(s2$Q.cfs)
if (class(s2$q.mmh)=="factor") s2$q.mmh <-as.numeric(levels(s2$q.mmh))[as.integer(s2$q.mmh) ]               
if (class(s2$q.mmh)=="character") s2$q.mmh <-as.numeric(s2$q.mmh)
if (class(s2$q.interval)=="factor") s2$q.interval <-as.numeric(levels(s2$q.interval))[as.integer(s2$q.interval) ]               
if (class(s2$q.interval)=="character") s2$q.interval <-as.numeric(s2$q.interval)

# Convert Missing Values to NA for non-dates

s2$Q.cfs <- ifelse((trimws(as.character(s2$Q.cfs))==trimws("NA")),NA,s2$Q.cfs)               
suppressWarnings(s2$Q.cfs <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s2$Q.cfs))==as.character(as.numeric("NA"))),NA,s2$Q.cfs))
s2$q.mmh <- ifelse((trimws(as.character(s2$q.mmh))==trimws("NA")),NA,s2$q.mmh)               
suppressWarnings(s2$q.mmh <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s2$q.mmh))==as.character(as.numeric("NA"))),NA,s2$q.mmh))
s2$q.interval <- ifelse((trimws(as.character(s2$q.interval))==trimws("NA")),NA,s2$q.interval)               
suppressWarnings(s2$q.interval <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s2$q.interval))==as.character(as.numeric("NA"))),NA,s2$q.interval))


# Here is the structure of the input data frame:
str(s2)                            
attach(s2)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(Peatland)
summary(DateTime)
summary(Stage.ft)
summary(Q.cfs)
summary(q.mmh)
summary(q.interval) 
# Get more details on character variables

summary(as.factor(s2$Peatland))
detach(s2)               


inUrl2  <- "https://pasta.lternet.edu/package/data/eml/edi/573/1/740d38a23c01889992aede55916697f0" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")


s4n <-read.csv(infile2,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "Peatland",     
                 "DateTime",     
                 "Stage.ft",     
                 "Q.cfs",     
                 "q.mmh",     
                 "q.interval"    ), check.names=TRUE)

unlink(infile2)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(s4n$Peatland)!="factor") s4n$Peatland<- as.factor(s4n$Peatland)                                   
# attempting to convert s4n$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp2DateTime<-as.POSIXct(s4n$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp2DateTime) == length(tmp2DateTime[!is.na(tmp2DateTime)])){s4n$DateTime <- tmp2DateTime } else {print("Date conversion failed for s4n$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp2DateTime) 
if (class(s4n$Stage.ft)=="factor") s4n$Stage.ft <-as.numeric(levels(s4n$Stage.ft))[as.integer(s4n$Stage.ft) ]               
if (class(s4n$Stage.ft)=="character") s4n$Stage.ft <-as.numeric(s4n$Stage.ft)
if (class(s4n$Q.cfs)=="factor") s4n$Q.cfs <-as.numeric(levels(s4n$Q.cfs))[as.integer(s4n$Q.cfs) ]               
if (class(s4n$Q.cfs)=="character") s4n$Q.cfs <-as.numeric(s4n$Q.cfs)
if (class(s4n$q.mmh)=="factor") s4n$q.mmh <-as.numeric(levels(s4n$q.mmh))[as.integer(s4n$q.mmh) ]               
if (class(s4n$q.mmh)=="character") s4n$q.mmh <-as.numeric(s4n$q.mmh)
if (class(s4n$q.interval)=="factor") s4n$q.interval <-as.numeric(levels(s4n$q.interval))[as.integer(s4n$q.interval) ]               
if (class(s4n$q.interval)=="character") s4n$q.interval <-as.numeric(s4n$q.interval)

# Convert Missing Values to NA for non-dates

s4n$Q.cfs <- ifelse((trimws(as.character(s4n$Q.cfs))==trimws("NA")),NA,s4n$Q.cfs)               
suppressWarnings(s4n$Q.cfs <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s4n$Q.cfs))==as.character(as.numeric("NA"))),NA,s4n$Q.cfs))
s4n$q.mmh <- ifelse((trimws(as.character(s4n$q.mmh))==trimws("NA")),NA,s4n$q.mmh)               
suppressWarnings(s4n$q.mmh <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s4n$q.mmh))==as.character(as.numeric("NA"))),NA,s4n$q.mmh))
s4n$q.interval <- ifelse((trimws(as.character(s4n$q.interval))==trimws("NA")),NA,s4n$q.interval)               
suppressWarnings(s4n$q.interval <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s4n$q.interval))==as.character(as.numeric("NA"))),NA,s4n$q.interval))


# Here is the structure of the input data frame:
str(s4n)                            
attach(s4n)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(Peatland)
summary(DateTime)
summary(Stage.ft)
summary(Q.cfs)
summary(q.mmh)
summary(q.interval) 
# Get more details on character variables

summary(as.factor(s4n$Peatland))
detach(s4n)               


inUrl3  <- "https://pasta.lternet.edu/package/data/eml/edi/573/1/8c75f3dc7b96e91c164b220e3acb8b53" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")


s4s <-read.csv(infile3,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "Peatland",     
                 "DateTime",     
                 "Stage.ft",     
                 "Q.cfs",     
                 "q.mmh",     
                 "q.interval"    ), check.names=TRUE)

unlink(infile3)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(s4s$Peatland)!="factor") s4s$Peatland<- as.factor(s4s$Peatland)                                   
# attempting to convert s4s$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp3DateTime<-as.POSIXct(s4s$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3DateTime) == length(tmp3DateTime[!is.na(tmp3DateTime)])){s4s$DateTime <- tmp3DateTime } else {print("Date conversion failed for s4s$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp3DateTime) 
if (class(s4s$Stage.ft)=="factor") s4s$Stage.ft <-as.numeric(levels(s4s$Stage.ft))[as.integer(s4s$Stage.ft) ]               
if (class(s4s$Stage.ft)=="character") s4s$Stage.ft <-as.numeric(s4s$Stage.ft)
if (class(s4s$Q.cfs)=="factor") s4s$Q.cfs <-as.numeric(levels(s4s$Q.cfs))[as.integer(s4s$Q.cfs) ]               
if (class(s4s$Q.cfs)=="character") s4s$Q.cfs <-as.numeric(s4s$Q.cfs)
if (class(s4s$q.mmh)=="factor") s4s$q.mmh <-as.numeric(levels(s4s$q.mmh))[as.integer(s4s$q.mmh) ]               
if (class(s4s$q.mmh)=="character") s4s$q.mmh <-as.numeric(s4s$q.mmh)
if (class(s4s$q.interval)=="factor") s4s$q.interval <-as.numeric(levels(s4s$q.interval))[as.integer(s4s$q.interval) ]               
if (class(s4s$q.interval)=="character") s4s$q.interval <-as.numeric(s4s$q.interval)

# Convert Missing Values to NA for non-dates

s4s$Q.cfs <- ifelse((trimws(as.character(s4s$Q.cfs))==trimws("NA")),NA,s4s$Q.cfs)               
suppressWarnings(s4s$Q.cfs <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s4s$Q.cfs))==as.character(as.numeric("NA"))),NA,s4s$Q.cfs))
s4s$q.mmh <- ifelse((trimws(as.character(s4s$q.mmh))==trimws("NA")),NA,s4s$q.mmh)               
suppressWarnings(s4s$q.mmh <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s4s$q.mmh))==as.character(as.numeric("NA"))),NA,s4s$q.mmh))
s4s$q.interval <- ifelse((trimws(as.character(s4s$q.interval))==trimws("NA")),NA,s4s$q.interval)               
suppressWarnings(s4s$q.interval <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s4s$q.interval))==as.character(as.numeric("NA"))),NA,s4s$q.interval))


# Here is the structure of the input data frame:
str(s4s)                            
attach(s4s)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(Peatland)
summary(DateTime)
summary(Stage.ft)
summary(Q.cfs)
summary(q.mmh)
summary(q.interval) 
# Get more details on character variables

summary(as.factor(s4s$Peatland))
detach(s4s)               


inUrl4  <- "https://pasta.lternet.edu/package/data/eml/edi/573/1/50849e4bf795038c6fca2ecea096467d" 
infile4 <- tempfile()
try(download.file(inUrl4,infile4,method="curl"))
if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")


s5 <-read.csv(infile4,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "Peatland",     
                 "DateTime",     
                 "Stage.ft",     
                 "Q.cfs",     
                 "q.mmh",     
                 "q.interval"    ), check.names=TRUE)

unlink(infile4)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(s5$Peatland)!="factor") s5$Peatland<- as.factor(s5$Peatland)                                   
# attempting to convert s5$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp4DateTime<-as.POSIXct(s5$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp4DateTime) == length(tmp4DateTime[!is.na(tmp4DateTime)])){s5$DateTime <- tmp4DateTime } else {print("Date conversion failed for s5$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp4DateTime) 
if (class(s5$Stage.ft)=="factor") s5$Stage.ft <-as.numeric(levels(s5$Stage.ft))[as.integer(s5$Stage.ft) ]               
if (class(s5$Stage.ft)=="character") s5$Stage.ft <-as.numeric(s5$Stage.ft)
if (class(s5$Q.cfs)=="factor") s5$Q.cfs <-as.numeric(levels(s5$Q.cfs))[as.integer(s5$Q.cfs) ]               
if (class(s5$Q.cfs)=="character") s5$Q.cfs <-as.numeric(s5$Q.cfs)
if (class(s5$q.mmh)=="factor") s5$q.mmh <-as.numeric(levels(s5$q.mmh))[as.integer(s5$q.mmh) ]               
if (class(s5$q.mmh)=="character") s5$q.mmh <-as.numeric(s5$q.mmh)
if (class(s5$q.interval)=="factor") s5$q.interval <-as.numeric(levels(s5$q.interval))[as.integer(s5$q.interval) ]               
if (class(s5$q.interval)=="character") s5$q.interval <-as.numeric(s5$q.interval)

# Convert Missing Values to NA for non-dates

s5$Q.cfs <- ifelse((trimws(as.character(s5$Q.cfs))==trimws("NA")),NA,s5$Q.cfs)               
suppressWarnings(s5$Q.cfs <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s5$Q.cfs))==as.character(as.numeric("NA"))),NA,s5$Q.cfs))
s5$q.mmh <- ifelse((trimws(as.character(s5$q.mmh))==trimws("NA")),NA,s5$q.mmh)               
suppressWarnings(s5$q.mmh <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s5$q.mmh))==as.character(as.numeric("NA"))),NA,s5$q.mmh))
s5$q.interval <- ifelse((trimws(as.character(s5$q.interval))==trimws("NA")),NA,s5$q.interval)               
suppressWarnings(s5$q.interval <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s5$q.interval))==as.character(as.numeric("NA"))),NA,s5$q.interval))


# Here is the structure of the input data frame:
str(s5)                            
attach(s5)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(Peatland)
summary(DateTime)
summary(Stage.ft)
summary(Q.cfs)
summary(q.mmh)
summary(q.interval) 
# Get more details on character variables

summary(as.factor(s5$Peatland))
detach(s5)               


inUrl5  <- "https://pasta.lternet.edu/package/data/eml/edi/573/1/2c14eb3ea4f1bfb4cdce58e6070fb1fb" 
infile5 <- tempfile()
try(download.file(inUrl5,infile5,method="curl"))
if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")


s6 <-read.csv(infile5,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "Peatland",     
                 "DateTime",     
                 "Stage.ft",     
                 "Q.cfs",     
                 "q.mmh",     
                 "q.interval"    ), check.names=TRUE)

unlink(infile5)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(s6$Peatland)!="factor") s6$Peatland<- as.factor(s6$Peatland)                                   
# attempting to convert s6$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp5DateTime<-as.POSIXct(s6$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp5DateTime) == length(tmp5DateTime[!is.na(tmp5DateTime)])){s6$DateTime <- tmp5DateTime } else {print("Date conversion failed for s6$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp5DateTime) 
if (class(s6$Stage.ft)=="factor") s6$Stage.ft <-as.numeric(levels(s6$Stage.ft))[as.integer(s6$Stage.ft) ]               
if (class(s6$Stage.ft)=="character") s6$Stage.ft <-as.numeric(s6$Stage.ft)
if (class(s6$Q.cfs)=="factor") s6$Q.cfs <-as.numeric(levels(s6$Q.cfs))[as.integer(s6$Q.cfs) ]               
if (class(s6$Q.cfs)=="character") s6$Q.cfs <-as.numeric(s6$Q.cfs)
if (class(s6$q.mmh)=="factor") s6$q.mmh <-as.numeric(levels(s6$q.mmh))[as.integer(s6$q.mmh) ]               
if (class(s6$q.mmh)=="character") s6$q.mmh <-as.numeric(s6$q.mmh)
if (class(s6$q.interval)=="factor") s6$q.interval <-as.numeric(levels(s6$q.interval))[as.integer(s6$q.interval) ]               
if (class(s6$q.interval)=="character") s6$q.interval <-as.numeric(s6$q.interval)

# Convert Missing Values to NA for non-dates

s6$Q.cfs <- ifelse((trimws(as.character(s6$Q.cfs))==trimws("NA")),NA,s6$Q.cfs)               
suppressWarnings(s6$Q.cfs <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s6$Q.cfs))==as.character(as.numeric("NA"))),NA,s6$Q.cfs))
s6$q.mmh <- ifelse((trimws(as.character(s6$q.mmh))==trimws("NA")),NA,s6$q.mmh)               
suppressWarnings(s6$q.mmh <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s6$q.mmh))==as.character(as.numeric("NA"))),NA,s6$q.mmh))
s6$q.interval <- ifelse((trimws(as.character(s6$q.interval))==trimws("NA")),NA,s6$q.interval)               
suppressWarnings(s6$q.interval <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(s6$q.interval))==as.character(as.numeric("NA"))),NA,s6$q.interval))


# Here is the structure of the input data frame:
str(s6)                            
attach(s6)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(Peatland)
summary(DateTime)
summary(Stage.ft)
summary(Q.cfs)
summary(q.mmh)
summary(q.interval) 
# Get more details on character variables

summary(as.factor(s6$Peatland))
detach(s6)




## plot 
library(ggplot2)
library(dplyr)
library(lubridate)

#hist(s2$Q.cfs)
names(s2)[names(s2)=="DateTime"]<-"datetime"
names(s6)[names(s6)=="DateTime"]<-"datetime"
#s2 %>% select(datetime)%>% mutate (datetime=make_datetime(year,month,day,hour,minute))

# Assuming you have datasets named s2, s4n, s4s, and s5

# Load libraries
library(ggplot2)
library(dplyr)

s2$datetime<-as.POSIXct(s2$datetime,format="%Y-%m-%d %H:%M:%OS")
#str(s2)
s6$datetime<-as.POSIXct(s6$datetime,format="%Y-%m-%d %H:%M:%OS")


rm(s4n)
rm(s4s)
rm(s5)
rm(s6)












