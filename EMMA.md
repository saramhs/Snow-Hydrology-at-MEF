​​#setup
#Modern Applied Statistics with S
pkgs = c("dplyr", "ggplot2", "MASS") 
#install.packages(pkgs)
inst = lapply(pkgs, library, character.only = TRUE) 

getwd() 
dir() 
setwd("/Users/safl/Reference_folder/EMMA/data/Runoff/")

#Import the data
#runoff<-read.csv("/EMMA_Marcell/Data/Runoff/2024.02.27_ROChemistry2009-2011.csv") #does not give permission          >>>>>>>>solve thsi issue

runoff<-read.csv("2024.02.27_ROChemistry2009-2011.csv")

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/1179/1/826aa93418f6a48dd8cbb831cc7bd02b" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


auto <-read.csv(infile1,header=F 
                ,skip=1
                ,sep=","  
                , col.names=c(
                  "LAB_ID",     
                  "Peatland",     
                  "NAME",     
                  "DateTime",     
                  "PH",     
                  "SPCOND",     
                  "CL",     
                  "SO4",     
                  "CA",     
                  "K",     
                  "MG",     
                  "Na",     
                  "AL",     
                  "FE",     
                  "MN",     
                  "SI",     
                  "SR",     
                  "SRP",     
                  "TN",     
                  "TP",     
                  "NPOC",     
                  "TC.IC",     
                  "O18",     
                  "D"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(auto$LAB_ID)=="factor") auto$LAB_ID <-as.numeric(levels(auto$LAB_ID))[as.integer(auto$LAB_ID) ]               
if (class(auto$LAB_ID)=="character") auto$LAB_ID <-as.numeric(auto$LAB_ID)
if (class(auto$Peatland)!="factor") auto$Peatland<- as.factor(auto$Peatland)
if (class(auto$NAME)!="factor") auto$NAME<- as.factor(auto$NAME)                                   
# attempting to convert auto$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1DateTime<-as.POSIXct(auto$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DateTime) == length(tmp1DateTime[!is.na(tmp1DateTime)])){auto$DateTime <- tmp1DateTime } else {print("Date conversion failed for auto$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1DateTime) 
if (class(auto$PH)=="factor") auto$PH <-as.numeric(levels(auto$PH))[as.integer(auto$PH) ]               
if (class(auto$PH)=="character") auto$PH <-as.numeric(auto$PH)
if (class(auto$SPCOND)=="factor") auto$SPCOND <-as.numeric(levels(auto$SPCOND))[as.integer(auto$SPCOND) ]               
if (class(auto$SPCOND)=="character") auto$SPCOND <-as.numeric(auto$SPCOND)
if (class(auto$CL)=="factor") auto$CL <-as.numeric(levels(auto$CL))[as.integer(auto$CL) ]               
if (class(auto$CL)=="character") auto$CL <-as.numeric(auto$CL)
if (class(auto$SO4)=="factor") auto$SO4 <-as.numeric(levels(auto$SO4))[as.integer(auto$SO4) ]               
if (class(auto$SO4)=="character") auto$SO4 <-as.numeric(auto$SO4)
if (class(auto$CA)=="factor") auto$CA <-as.numeric(levels(auto$CA))[as.integer(auto$CA) ]               
if (class(auto$CA)=="character") auto$CA <-as.numeric(auto$CA)
if (class(auto$K)=="factor") auto$K <-as.numeric(levels(auto$K))[as.integer(auto$K) ]               
if (class(auto$K)=="character") auto$K <-as.numeric(auto$K)
if (class(auto$MG)=="factor") auto$MG <-as.numeric(levels(auto$MG))[as.integer(auto$MG) ]               
if (class(auto$MG)=="character") auto$MG <-as.numeric(auto$MG)
if (class(auto$Na)=="factor") auto$Na <-as.numeric(levels(auto$Na))[as.integer(auto$Na) ]               
if (class(auto$Na)=="character") auto$Na <-as.numeric(auto$Na)
if (class(auto$AL)=="factor") auto$AL <-as.numeric(levels(auto$AL))[as.integer(auto$AL) ]               
if (class(auto$AL)=="character") auto$AL <-as.numeric(auto$AL)
if (class(auto$FE)=="factor") auto$FE <-as.numeric(levels(auto$FE))[as.integer(auto$FE) ]               
if (class(auto$FE)=="character") auto$FE <-as.numeric(auto$FE)
if (class(auto$MN)=="factor") auto$MN <-as.numeric(levels(auto$MN))[as.integer(auto$MN) ]               
if (class(auto$MN)=="character") auto$MN <-as.numeric(auto$MN)
if (class(auto$SI)=="factor") auto$SI <-as.numeric(levels(auto$SI))[as.integer(auto$SI) ]               
if (class(auto$SI)=="character") auto$SI <-as.numeric(auto$SI)
if (class(auto$SR)=="factor") auto$SR <-as.numeric(levels(auto$SR))[as.integer(auto$SR) ]               
if (class(auto$SR)=="character") auto$SR <-as.numeric(auto$SR)
if (class(auto$SRP)=="factor") auto$SRP <-as.numeric(levels(auto$SRP))[as.integer(auto$SRP) ]               
if (class(auto$SRP)=="character") auto$SRP <-as.numeric(auto$SRP)
if (class(auto$TN)=="factor") auto$TN <-as.numeric(levels(auto$TN))[as.integer(auto$TN) ]               
if (class(auto$TN)=="character") auto$TN <-as.numeric(auto$TN)
if (class(auto$TP)=="factor") auto$TP <-as.numeric(levels(auto$TP))[as.integer(auto$TP) ]               
if (class(auto$TP)=="character") auto$TP <-as.numeric(auto$TP)
if (class(auto$NPOC)=="factor") auto$NPOC <-as.numeric(levels(auto$NPOC))[as.integer(auto$NPOC) ]               
if (class(auto$NPOC)=="character") auto$NPOC <-as.numeric(auto$NPOC)
if (class(auto$TC.IC)=="factor") auto$TC.IC <-as.numeric(levels(auto$TC.IC))[as.integer(auto$TC.IC) ]               
if (class(auto$TC.IC)=="character") auto$TC.IC <-as.numeric(auto$TC.IC)
if (class(auto$O18)=="factor") auto$O18 <-as.numeric(levels(auto$O18))[as.integer(auto$O18) ]               
if (class(auto$O18)=="character") auto$O18 <-as.numeric(auto$O18)
if (class(auto$D)=="factor") auto$D <-as.numeric(levels(auto$D))[as.integer(auto$D) ]               
if (class(auto$D)=="character") auto$D <-as.numeric(auto$D)

# Convert Missing Values to NA for non-dates

auto$PH <- ifelse((trimws(as.character(auto$PH))==trimws("NA")),NA,auto$PH)               
suppressWarnings(auto$PH <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$PH))==as.character(as.numeric("NA"))),NA,auto$PH))
auto$SPCOND <- ifelse((trimws(as.character(auto$SPCOND))==trimws("NA")),NA,auto$SPCOND)               
suppressWarnings(auto$SPCOND <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$SPCOND))==as.character(as.numeric("NA"))),NA,auto$SPCOND))
auto$CL <- ifelse((trimws(as.character(auto$CL))==trimws("NA")),NA,auto$CL)               
suppressWarnings(auto$CL <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$CL))==as.character(as.numeric("NA"))),NA,auto$CL))
auto$SO4 <- ifelse((trimws(as.character(auto$SO4))==trimws("NA")),NA,auto$SO4)               
suppressWarnings(auto$SO4 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$SO4))==as.character(as.numeric("NA"))),NA,auto$SO4))
auto$CA <- ifelse((trimws(as.character(auto$CA))==trimws("NA")),NA,auto$CA)               
suppressWarnings(auto$CA <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$CA))==as.character(as.numeric("NA"))),NA,auto$CA))
auto$K <- ifelse((trimws(as.character(auto$K))==trimws("NA")),NA,auto$K)               
suppressWarnings(auto$K <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$K))==as.character(as.numeric("NA"))),NA,auto$K))
auto$MG <- ifelse((trimws(as.character(auto$MG))==trimws("NA")),NA,auto$MG)               
suppressWarnings(auto$MG <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$MG))==as.character(as.numeric("NA"))),NA,auto$MG))
auto$Na <- ifelse((trimws(as.character(auto$Na))==trimws("NA")),NA,auto$Na)               
suppressWarnings(auto$Na <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$Na))==as.character(as.numeric("NA"))),NA,auto$Na))
auto$AL <- ifelse((trimws(as.character(auto$AL))==trimws("NA")),NA,auto$AL)               
suppressWarnings(auto$AL <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$AL))==as.character(as.numeric("NA"))),NA,auto$AL))
auto$FE <- ifelse((trimws(as.character(auto$FE))==trimws("NA")),NA,auto$FE)               
suppressWarnings(auto$FE <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$FE))==as.character(as.numeric("NA"))),NA,auto$FE))
auto$MN <- ifelse((trimws(as.character(auto$MN))==trimws("NA")),NA,auto$MN)               
suppressWarnings(auto$MN <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$MN))==as.character(as.numeric("NA"))),NA,auto$MN))
auto$SI <- ifelse((trimws(as.character(auto$SI))==trimws("NA")),NA,auto$SI)               
suppressWarnings(auto$SI <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$SI))==as.character(as.numeric("NA"))),NA,auto$SI))
auto$SR <- ifelse((trimws(as.character(auto$SR))==trimws("NA")),NA,auto$SR)               
suppressWarnings(auto$SR <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$SR))==as.character(as.numeric("NA"))),NA,auto$SR))
auto$SRP <- ifelse((trimws(as.character(auto$SRP))==trimws("NA")),NA,auto$SRP)               
suppressWarnings(auto$SRP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$SRP))==as.character(as.numeric("NA"))),NA,auto$SRP))
auto$TN <- ifelse((trimws(as.character(auto$TN))==trimws("NA")),NA,auto$TN)               
suppressWarnings(auto$TN <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$TN))==as.character(as.numeric("NA"))),NA,auto$TN))
auto$TP <- ifelse((trimws(as.character(auto$TP))==trimws("NA")),NA,auto$TP)               
suppressWarnings(auto$TP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$TP))==as.character(as.numeric("NA"))),NA,auto$TP))
auto$NPOC <- ifelse((trimws(as.character(auto$NPOC))==trimws("NA")),NA,auto$NPOC)               
suppressWarnings(auto$NPOC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$NPOC))==as.character(as.numeric("NA"))),NA,auto$NPOC))
auto$TC.IC <- ifelse((trimws(as.character(auto$TC.IC))==trimws("NA")),NA,auto$TC.IC)               
suppressWarnings(auto$TC.IC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$TC.IC))==as.character(as.numeric("NA"))),NA,auto$TC.IC))
auto$O18 <- ifelse((trimws(as.character(auto$O18))==trimws("NA")),NA,auto$O18)               
suppressWarnings(auto$O18 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$O18))==as.character(as.numeric("NA"))),NA,auto$O18))
auto$D <- ifelse((trimws(as.character(auto$D))==trimws("NA")),NA,auto$D)               
suppressWarnings(auto$D <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(auto$D))==as.character(as.numeric("NA"))),NA,auto$D))


# Here is the structure of the input data frame:
str(auto)                            
attach(auto)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(Peatland)
summary(NAME)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(SRP)
summary(TN)
summary(TP)
summary(NPOC)
summary(TC.IC)
summary(O18)
summary(D) 
# Get more details on character variables

summary(as.factor(auto$Peatland)) 
summary(as.factor(auto$NAME))
detach(auto)               


inUrl2  <- "https://pasta.lternet.edu/package/data/eml/edi/1179/1/f3127bddb8dcd2f6844e913319693d3c" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")


lagg <-read.csv(infile2,header=F 
                ,skip=1
                ,sep=","  
                , col.names=c(
                  "LAB_ID",     
                  "Peatland",     
                  "NAME",     
                  "DateTime",     
                  "PH",     
                  "SPCOND",     
                  "CL",     
                  "SO4",     
                  "CA",     
                  "K",     
                  "MG",     
                  "Na",     
                  "AL",     
                  "FE",     
                  "MN",     
                  "SI",     
                  "SR",     
                  "NH4",     
                  "NO3",     
                  "SRP",     
                  "TN",     
                  "TP",     
                  "NPOC",     
                  "TC.IC",     
                  "DOC",     
                  "UVA254",     
                  "UVA360",     
                  "THGF",     
                  "MEHGF",     
                  "PB",     
                  "O18",     
                  "D",     
                  "FEII",     
                  "FEIII",     
                  "STAGE",     
                  "q",     
                  "TEMPC"    ), check.names=TRUE)

unlink(infile2)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(lagg$LAB_ID)=="factor") lagg$LAB_ID <-as.numeric(levels(lagg$LAB_ID))[as.integer(lagg$LAB_ID) ]               
if (class(lagg$LAB_ID)=="character") lagg$LAB_ID <-as.numeric(lagg$LAB_ID)
if (class(lagg$Peatland)!="factor") lagg$Peatland<- as.factor(lagg$Peatland)
if (class(lagg$NAME)!="factor") lagg$NAME<- as.factor(lagg$NAME)                                   
# attempting to convert lagg$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp2DateTime<-as.POSIXct(lagg$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp2DateTime) == length(tmp2DateTime[!is.na(tmp2DateTime)])){lagg$DateTime <- tmp2DateTime } else {print("Date conversion failed for lagg$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp2DateTime) 
if (class(lagg$PH)=="factor") lagg$PH <-as.numeric(levels(lagg$PH))[as.integer(lagg$PH) ]               
if (class(lagg$PH)=="character") lagg$PH <-as.numeric(lagg$PH)
if (class(lagg$SPCOND)=="factor") lagg$SPCOND <-as.numeric(levels(lagg$SPCOND))[as.integer(lagg$SPCOND) ]               
if (class(lagg$SPCOND)=="character") lagg$SPCOND <-as.numeric(lagg$SPCOND)
if (class(lagg$CL)=="factor") lagg$CL <-as.numeric(levels(lagg$CL))[as.integer(lagg$CL) ]               
if (class(lagg$CL)=="character") lagg$CL <-as.numeric(lagg$CL)
if (class(lagg$SO4)=="factor") lagg$SO4 <-as.numeric(levels(lagg$SO4))[as.integer(lagg$SO4) ]               
if (class(lagg$SO4)=="character") lagg$SO4 <-as.numeric(lagg$SO4)
if (class(lagg$CA)=="factor") lagg$CA <-as.numeric(levels(lagg$CA))[as.integer(lagg$CA) ]               
if (class(lagg$CA)=="character") lagg$CA <-as.numeric(lagg$CA)
if (class(lagg$K)=="factor") lagg$K <-as.numeric(levels(lagg$K))[as.integer(lagg$K) ]               
if (class(lagg$K)=="character") lagg$K <-as.numeric(lagg$K)
if (class(lagg$MG)=="factor") lagg$MG <-as.numeric(levels(lagg$MG))[as.integer(lagg$MG) ]               
if (class(lagg$MG)=="character") lagg$MG <-as.numeric(lagg$MG)
if (class(lagg$Na)=="factor") lagg$Na <-as.numeric(levels(lagg$Na))[as.integer(lagg$Na) ]               
if (class(lagg$Na)=="character") lagg$Na <-as.numeric(lagg$Na)
if (class(lagg$AL)=="factor") lagg$AL <-as.numeric(levels(lagg$AL))[as.integer(lagg$AL) ]               
if (class(lagg$AL)=="character") lagg$AL <-as.numeric(lagg$AL)
if (class(lagg$FE)=="factor") lagg$FE <-as.numeric(levels(lagg$FE))[as.integer(lagg$FE) ]               
if (class(lagg$FE)=="character") lagg$FE <-as.numeric(lagg$FE)
if (class(lagg$MN)=="factor") lagg$MN <-as.numeric(levels(lagg$MN))[as.integer(lagg$MN) ]               
if (class(lagg$MN)=="character") lagg$MN <-as.numeric(lagg$MN)
if (class(lagg$SI)=="factor") lagg$SI <-as.numeric(levels(lagg$SI))[as.integer(lagg$SI) ]               
if (class(lagg$SI)=="character") lagg$SI <-as.numeric(lagg$SI)
if (class(lagg$SR)=="factor") lagg$SR <-as.numeric(levels(lagg$SR))[as.integer(lagg$SR) ]               
if (class(lagg$SR)=="character") lagg$SR <-as.numeric(lagg$SR)
if (class(lagg$NH4)=="factor") lagg$NH4 <-as.numeric(levels(lagg$NH4))[as.integer(lagg$NH4) ]               
if (class(lagg$NH4)=="character") lagg$NH4 <-as.numeric(lagg$NH4)
if (class(lagg$NO3)=="factor") lagg$NO3 <-as.numeric(levels(lagg$NO3))[as.integer(lagg$NO3) ]               
if (class(lagg$NO3)=="character") lagg$NO3 <-as.numeric(lagg$NO3)
if (class(lagg$SRP)=="factor") lagg$SRP <-as.numeric(levels(lagg$SRP))[as.integer(lagg$SRP) ]               
if (class(lagg$SRP)=="character") lagg$SRP <-as.numeric(lagg$SRP)
if (class(lagg$TN)=="factor") lagg$TN <-as.numeric(levels(lagg$TN))[as.integer(lagg$TN) ]               
if (class(lagg$TN)=="character") lagg$TN <-as.numeric(lagg$TN)
if (class(lagg$TP)=="factor") lagg$TP <-as.numeric(levels(lagg$TP))[as.integer(lagg$TP) ]               
if (class(lagg$TP)=="character") lagg$TP <-as.numeric(lagg$TP)
if (class(lagg$NPOC)=="factor") lagg$NPOC <-as.numeric(levels(lagg$NPOC))[as.integer(lagg$NPOC) ]               
if (class(lagg$NPOC)=="character") lagg$NPOC <-as.numeric(lagg$NPOC)
if (class(lagg$TC.IC)=="factor") lagg$TC.IC <-as.numeric(levels(lagg$TC.IC))[as.integer(lagg$TC.IC) ]               
if (class(lagg$TC.IC)=="character") lagg$TC.IC <-as.numeric(lagg$TC.IC)
if (class(lagg$DOC)=="factor") lagg$DOC <-as.numeric(levels(lagg$DOC))[as.integer(lagg$DOC) ]               
if (class(lagg$DOC)=="character") lagg$DOC <-as.numeric(lagg$DOC)
if (class(lagg$UVA254)=="factor") lagg$UVA254 <-as.numeric(levels(lagg$UVA254))[as.integer(lagg$UVA254) ]               
if (class(lagg$UVA254)=="character") lagg$UVA254 <-as.numeric(lagg$UVA254)
if (class(lagg$UVA360)=="factor") lagg$UVA360 <-as.numeric(levels(lagg$UVA360))[as.integer(lagg$UVA360) ]               
if (class(lagg$UVA360)=="character") lagg$UVA360 <-as.numeric(lagg$UVA360)
if (class(lagg$THGF)=="factor") lagg$THGF <-as.numeric(levels(lagg$THGF))[as.integer(lagg$THGF) ]               
if (class(lagg$THGF)=="character") lagg$THGF <-as.numeric(lagg$THGF)
if (class(lagg$MEHGF)=="factor") lagg$MEHGF <-as.numeric(levels(lagg$MEHGF))[as.integer(lagg$MEHGF) ]               
if (class(lagg$MEHGF)=="character") lagg$MEHGF <-as.numeric(lagg$MEHGF)
if (class(lagg$PB)=="factor") lagg$PB <-as.numeric(levels(lagg$PB))[as.integer(lagg$PB) ]               
if (class(lagg$PB)=="character") lagg$PB <-as.numeric(lagg$PB)
if (class(lagg$O18)=="factor") lagg$O18 <-as.numeric(levels(lagg$O18))[as.integer(lagg$O18) ]               
if (class(lagg$O18)=="character") lagg$O18 <-as.numeric(lagg$O18)
if (class(lagg$D)=="factor") lagg$D <-as.numeric(levels(lagg$D))[as.integer(lagg$D) ]               
if (class(lagg$D)=="character") lagg$D <-as.numeric(lagg$D)
if (class(lagg$FEII)=="factor") lagg$FEII <-as.numeric(levels(lagg$FEII))[as.integer(lagg$FEII) ]               
if (class(lagg$FEII)=="character") lagg$FEII <-as.numeric(lagg$FEII)
if (class(lagg$FEIII)=="factor") lagg$FEIII <-as.numeric(levels(lagg$FEIII))[as.integer(lagg$FEIII) ]               
if (class(lagg$FEIII)=="character") lagg$FEIII <-as.numeric(lagg$FEIII)
if (class(lagg$STAGE)=="factor") lagg$STAGE <-as.numeric(levels(lagg$STAGE))[as.integer(lagg$STAGE) ]               
if (class(lagg$STAGE)=="character") lagg$STAGE <-as.numeric(lagg$STAGE)
if (class(lagg$q)=="factor") lagg$q <-as.numeric(levels(lagg$q))[as.integer(lagg$q) ]               
if (class(lagg$q)=="character") lagg$q <-as.numeric(lagg$q)
if (class(lagg$TEMPC)=="factor") lagg$TEMPC <-as.numeric(levels(lagg$TEMPC))[as.integer(lagg$TEMPC) ]               
if (class(lagg$TEMPC)=="character") lagg$TEMPC <-as.numeric(lagg$TEMPC)

# Convert Missing Values to NA for non-dates

lagg$PH <- ifelse((trimws(as.character(lagg$PH))==trimws("NA")),NA,lagg$PH)               
suppressWarnings(lagg$PH <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$PH))==as.character(as.numeric("NA"))),NA,lagg$PH))
lagg$SPCOND <- ifelse((trimws(as.character(lagg$SPCOND))==trimws("NA")),NA,lagg$SPCOND)               
suppressWarnings(lagg$SPCOND <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$SPCOND))==as.character(as.numeric("NA"))),NA,lagg$SPCOND))
lagg$CL <- ifelse((trimws(as.character(lagg$CL))==trimws("NA")),NA,lagg$CL)               
suppressWarnings(lagg$CL <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$CL))==as.character(as.numeric("NA"))),NA,lagg$CL))
lagg$SO4 <- ifelse((trimws(as.character(lagg$SO4))==trimws("NA")),NA,lagg$SO4)               
suppressWarnings(lagg$SO4 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$SO4))==as.character(as.numeric("NA"))),NA,lagg$SO4))
lagg$CA <- ifelse((trimws(as.character(lagg$CA))==trimws("NA")),NA,lagg$CA)               
suppressWarnings(lagg$CA <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$CA))==as.character(as.numeric("NA"))),NA,lagg$CA))
lagg$K <- ifelse((trimws(as.character(lagg$K))==trimws("NA")),NA,lagg$K)               
suppressWarnings(lagg$K <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$K))==as.character(as.numeric("NA"))),NA,lagg$K))
lagg$MG <- ifelse((trimws(as.character(lagg$MG))==trimws("NA")),NA,lagg$MG)               
suppressWarnings(lagg$MG <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$MG))==as.character(as.numeric("NA"))),NA,lagg$MG))
lagg$Na <- ifelse((trimws(as.character(lagg$Na))==trimws("NA")),NA,lagg$Na)               
suppressWarnings(lagg$Na <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$Na))==as.character(as.numeric("NA"))),NA,lagg$Na))
lagg$AL <- ifelse((trimws(as.character(lagg$AL))==trimws("NA")),NA,lagg$AL)               
suppressWarnings(lagg$AL <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$AL))==as.character(as.numeric("NA"))),NA,lagg$AL))
lagg$FE <- ifelse((trimws(as.character(lagg$FE))==trimws("NA")),NA,lagg$FE)               
suppressWarnings(lagg$FE <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$FE))==as.character(as.numeric("NA"))),NA,lagg$FE))
lagg$MN <- ifelse((trimws(as.character(lagg$MN))==trimws("NA")),NA,lagg$MN)               
suppressWarnings(lagg$MN <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$MN))==as.character(as.numeric("NA"))),NA,lagg$MN))
lagg$SI <- ifelse((trimws(as.character(lagg$SI))==trimws("NA")),NA,lagg$SI)               
suppressWarnings(lagg$SI <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$SI))==as.character(as.numeric("NA"))),NA,lagg$SI))
lagg$SR <- ifelse((trimws(as.character(lagg$SR))==trimws("NA")),NA,lagg$SR)               
suppressWarnings(lagg$SR <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$SR))==as.character(as.numeric("NA"))),NA,lagg$SR))
lagg$NH4 <- ifelse((trimws(as.character(lagg$NH4))==trimws("NA")),NA,lagg$NH4)               
suppressWarnings(lagg$NH4 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$NH4))==as.character(as.numeric("NA"))),NA,lagg$NH4))
lagg$NO3 <- ifelse((trimws(as.character(lagg$NO3))==trimws("NA")),NA,lagg$NO3)               
suppressWarnings(lagg$NO3 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$NO3))==as.character(as.numeric("NA"))),NA,lagg$NO3))
lagg$SRP <- ifelse((trimws(as.character(lagg$SRP))==trimws("NA")),NA,lagg$SRP)               
suppressWarnings(lagg$SRP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$SRP))==as.character(as.numeric("NA"))),NA,lagg$SRP))
lagg$TN <- ifelse((trimws(as.character(lagg$TN))==trimws("NA")),NA,lagg$TN)               
suppressWarnings(lagg$TN <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$TN))==as.character(as.numeric("NA"))),NA,lagg$TN))
lagg$TP <- ifelse((trimws(as.character(lagg$TP))==trimws("NA")),NA,lagg$TP)               
suppressWarnings(lagg$TP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$TP))==as.character(as.numeric("NA"))),NA,lagg$TP))
lagg$NPOC <- ifelse((trimws(as.character(lagg$NPOC))==trimws("NA")),NA,lagg$NPOC)               
suppressWarnings(lagg$NPOC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$NPOC))==as.character(as.numeric("NA"))),NA,lagg$NPOC))
lagg$TC.IC <- ifelse((trimws(as.character(lagg$TC.IC))==trimws("NA")),NA,lagg$TC.IC)               
suppressWarnings(lagg$TC.IC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$TC.IC))==as.character(as.numeric("NA"))),NA,lagg$TC.IC))
lagg$DOC <- ifelse((trimws(as.character(lagg$DOC))==trimws("NA")),NA,lagg$DOC)               
suppressWarnings(lagg$DOC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$DOC))==as.character(as.numeric("NA"))),NA,lagg$DOC))
lagg$UVA254 <- ifelse((trimws(as.character(lagg$UVA254))==trimws("NA")),NA,lagg$UVA254)               
suppressWarnings(lagg$UVA254 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$UVA254))==as.character(as.numeric("NA"))),NA,lagg$UVA254))
lagg$UVA360 <- ifelse((trimws(as.character(lagg$UVA360))==trimws("NA")),NA,lagg$UVA360)               
suppressWarnings(lagg$UVA360 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$UVA360))==as.character(as.numeric("NA"))),NA,lagg$UVA360))
lagg$THGF <- ifelse((trimws(as.character(lagg$THGF))==trimws("NA")),NA,lagg$THGF)               
suppressWarnings(lagg$THGF <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$THGF))==as.character(as.numeric("NA"))),NA,lagg$THGF))
lagg$MEHGF <- ifelse((trimws(as.character(lagg$MEHGF))==trimws("NA")),NA,lagg$MEHGF)               
suppressWarnings(lagg$MEHGF <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$MEHGF))==as.character(as.numeric("NA"))),NA,lagg$MEHGF))
lagg$PB <- ifelse((trimws(as.character(lagg$PB))==trimws("NA")),NA,lagg$PB)               
suppressWarnings(lagg$PB <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$PB))==as.character(as.numeric("NA"))),NA,lagg$PB))
lagg$O18 <- ifelse((trimws(as.character(lagg$O18))==trimws("NA")),NA,lagg$O18)               
suppressWarnings(lagg$O18 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$O18))==as.character(as.numeric("NA"))),NA,lagg$O18))
lagg$D <- ifelse((trimws(as.character(lagg$D))==trimws("NA")),NA,lagg$D)               
suppressWarnings(lagg$D <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$D))==as.character(as.numeric("NA"))),NA,lagg$D))
lagg$FEII <- ifelse((trimws(as.character(lagg$FEII))==trimws("NA")),NA,lagg$FEII)               
suppressWarnings(lagg$FEII <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$FEII))==as.character(as.numeric("NA"))),NA,lagg$FEII))
lagg$FEIII <- ifelse((trimws(as.character(lagg$FEIII))==trimws("NA")),NA,lagg$FEIII)               
suppressWarnings(lagg$FEIII <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$FEIII))==as.character(as.numeric("NA"))),NA,lagg$FEIII))
lagg$STAGE <- ifelse((trimws(as.character(lagg$STAGE))==trimws("NA")),NA,lagg$STAGE)               
suppressWarnings(lagg$STAGE <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$STAGE))==as.character(as.numeric("NA"))),NA,lagg$STAGE))
lagg$q <- ifelse((trimws(as.character(lagg$q))==trimws("NA")),NA,lagg$q)               
suppressWarnings(lagg$q <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$q))==as.character(as.numeric("NA"))),NA,lagg$q))
lagg$TEMPC <- ifelse((trimws(as.character(lagg$TEMPC))==trimws("NA")),NA,lagg$TEMPC)               
suppressWarnings(lagg$TEMPC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(lagg$TEMPC))==as.character(as.numeric("NA"))),NA,lagg$TEMPC))


# Here is the structure of the input data frame:
str(lagg)                            
attach(lagg)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(Peatland)
summary(NAME)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(NPOC)
summary(TC.IC)
summary(DOC)
summary(UVA254)
summary(UVA360)
summary(THGF)
summary(MEHGF)
summary(PB)
summary(O18)
summary(D)
summary(FEII)
summary(FEIII)
summary(STAGE)
summary(q)
summary(TEMPC) 
# Get more details on character variables

summary(as.factor(lagg$Peatland)) 
summary(as.factor(lagg$NAME))
detach(lagg)               


inUrl3  <- "https://pasta.lternet.edu/package/data/eml/edi/1179/1/769ea4fc5a257d29f0c8b494121a792c" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")


grab <-read.csv(infile3,header=F 
                ,skip=1
                ,sep=","  
                , col.names=c(
                  "LAB_ID",     
                  "Peatland",     
                  "NAME",     
                  "DateTime",     
                  "PH",     
                  "SPCOND",     
                  "CL",     
                  "SO4",     
                  "CA",     
                  "K",     
                  "MG",     
                  "Na",     
                  "AL",     
                  "FE",     
                  "MN",     
                  "SI",     
                  "SR",     
                  "NH4",     
                  "NO3",     
                  "SRP",     
                  "TN",     
                  "TP",     
                  "NPOC",     
                  "TC.IC",     
                  "DOC",     
                  "UVA254",     
                  "UVA360",     
                  "UVA360S",     
                  "BDOC",     
                  "BR",     
                  "THGF",     
                  "MEHGF",     
                  "THGU",     
                  "MEHGU",     
                  "d202Hg",     
                  "MIF204Hg",     
                  "MIF201Hg",     
                  "MIF200Hg",     
                  "MIF199Hg",     
                  "PB",     
                  "O18",     
                  "D",     
                  "FEII",     
                  "FEIII",     
                  "STAGE",     
                  "q",     
                  "TEMPC"    ), check.names=TRUE)

unlink(infile3)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(grab$LAB_ID)=="factor") grab$LAB_ID <-as.numeric(levels(grab$LAB_ID))[as.integer(grab$LAB_ID) ]               
if (class(grab$LAB_ID)=="character") grab$LAB_ID <-as.numeric(grab$LAB_ID)
if (class(grab$Peatland)!="factor") grab$Peatland<- as.factor(grab$Peatland)
if (class(grab$NAME)!="factor") grab$NAME<- as.factor(grab$NAME)                                   
# attempting to convert grab$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp3DateTime<-as.POSIXct(grab$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3DateTime) == length(tmp3DateTime[!is.na(tmp3DateTime)])){grab$DateTime <- tmp3DateTime } else {print("Date conversion failed for grab$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp3DateTime) 
if (class(grab$PH)=="factor") grab$PH <-as.numeric(levels(grab$PH))[as.integer(grab$PH) ]               
if (class(grab$PH)=="character") grab$PH <-as.numeric(grab$PH)
if (class(grab$SPCOND)=="factor") grab$SPCOND <-as.numeric(levels(grab$SPCOND))[as.integer(grab$SPCOND) ]               
if (class(grab$SPCOND)=="character") grab$SPCOND <-as.numeric(grab$SPCOND)
if (class(grab$CL)=="factor") grab$CL <-as.numeric(levels(grab$CL))[as.integer(grab$CL) ]               
if (class(grab$CL)=="character") grab$CL <-as.numeric(grab$CL)
if (class(grab$SO4)=="factor") grab$SO4 <-as.numeric(levels(grab$SO4))[as.integer(grab$SO4) ]               
if (class(grab$SO4)=="character") grab$SO4 <-as.numeric(grab$SO4)
if (class(grab$CA)=="factor") grab$CA <-as.numeric(levels(grab$CA))[as.integer(grab$CA) ]               
if (class(grab$CA)=="character") grab$CA <-as.numeric(grab$CA)
if (class(grab$K)=="factor") grab$K <-as.numeric(levels(grab$K))[as.integer(grab$K) ]               
if (class(grab$K)=="character") grab$K <-as.numeric(grab$K)
if (class(grab$MG)=="factor") grab$MG <-as.numeric(levels(grab$MG))[as.integer(grab$MG) ]               
if (class(grab$MG)=="character") grab$MG <-as.numeric(grab$MG)
if (class(grab$Na)=="factor") grab$Na <-as.numeric(levels(grab$Na))[as.integer(grab$Na) ]               
if (class(grab$Na)=="character") grab$Na <-as.numeric(grab$Na)
if (class(grab$AL)=="factor") grab$AL <-as.numeric(levels(grab$AL))[as.integer(grab$AL) ]               
if (class(grab$AL)=="character") grab$AL <-as.numeric(grab$AL)
if (class(grab$FE)=="factor") grab$FE <-as.numeric(levels(grab$FE))[as.integer(grab$FE) ]               
if (class(grab$FE)=="character") grab$FE <-as.numeric(grab$FE)
if (class(grab$MN)=="factor") grab$MN <-as.numeric(levels(grab$MN))[as.integer(grab$MN) ]               
if (class(grab$MN)=="character") grab$MN <-as.numeric(grab$MN)
if (class(grab$SI)=="factor") grab$SI <-as.numeric(levels(grab$SI))[as.integer(grab$SI) ]               
if (class(grab$SI)=="character") grab$SI <-as.numeric(grab$SI)
if (class(grab$SR)=="factor") grab$SR <-as.numeric(levels(grab$SR))[as.integer(grab$SR) ]               
if (class(grab$SR)=="character") grab$SR <-as.numeric(grab$SR)
if (class(grab$NH4)=="factor") grab$NH4 <-as.numeric(levels(grab$NH4))[as.integer(grab$NH4) ]               
if (class(grab$NH4)=="character") grab$NH4 <-as.numeric(grab$NH4)
if (class(grab$NO3)=="factor") grab$NO3 <-as.numeric(levels(grab$NO3))[as.integer(grab$NO3) ]               
if (class(grab$NO3)=="character") grab$NO3 <-as.numeric(grab$NO3)
if (class(grab$SRP)=="factor") grab$SRP <-as.numeric(levels(grab$SRP))[as.integer(grab$SRP) ]               
if (class(grab$SRP)=="character") grab$SRP <-as.numeric(grab$SRP)
if (class(grab$TN)=="factor") grab$TN <-as.numeric(levels(grab$TN))[as.integer(grab$TN) ]               
if (class(grab$TN)=="character") grab$TN <-as.numeric(grab$TN)
if (class(grab$TP)=="factor") grab$TP <-as.numeric(levels(grab$TP))[as.integer(grab$TP) ]               
if (class(grab$TP)=="character") grab$TP <-as.numeric(grab$TP)
if (class(grab$NPOC)=="factor") grab$NPOC <-as.numeric(levels(grab$NPOC))[as.integer(grab$NPOC) ]               
if (class(grab$NPOC)=="character") grab$NPOC <-as.numeric(grab$NPOC)
if (class(grab$TC.IC)=="factor") grab$TC.IC <-as.numeric(levels(grab$TC.IC))[as.integer(grab$TC.IC) ]               
if (class(grab$TC.IC)=="character") grab$TC.IC <-as.numeric(grab$TC.IC)
if (class(grab$DOC)=="factor") grab$DOC <-as.numeric(levels(grab$DOC))[as.integer(grab$DOC) ]               
if (class(grab$DOC)=="character") grab$DOC <-as.numeric(grab$DOC)
if (class(grab$UVA254)=="factor") grab$UVA254 <-as.numeric(levels(grab$UVA254))[as.integer(grab$UVA254) ]               
if (class(grab$UVA254)=="character") grab$UVA254 <-as.numeric(grab$UVA254)
if (class(grab$UVA360)=="factor") grab$UVA360 <-as.numeric(levels(grab$UVA360))[as.integer(grab$UVA360) ]               
if (class(grab$UVA360)=="character") grab$UVA360 <-as.numeric(grab$UVA360)
if (class(grab$UVA360S)=="factor") grab$UVA360S <-as.numeric(levels(grab$UVA360S))[as.integer(grab$UVA360S) ]               
if (class(grab$UVA360S)=="character") grab$UVA360S <-as.numeric(grab$UVA360S)
if (class(grab$BDOC)=="factor") grab$BDOC <-as.numeric(levels(grab$BDOC))[as.integer(grab$BDOC) ]               
if (class(grab$BDOC)=="character") grab$BDOC <-as.numeric(grab$BDOC)
if (class(grab$BR)=="factor") grab$BR <-as.numeric(levels(grab$BR))[as.integer(grab$BR) ]               
if (class(grab$BR)=="character") grab$BR <-as.numeric(grab$BR)
if (class(grab$THGF)=="factor") grab$THGF <-as.numeric(levels(grab$THGF))[as.integer(grab$THGF) ]               
if (class(grab$THGF)=="character") grab$THGF <-as.numeric(grab$THGF)
if (class(grab$MEHGF)=="factor") grab$MEHGF <-as.numeric(levels(grab$MEHGF))[as.integer(grab$MEHGF) ]               
if (class(grab$MEHGF)=="character") grab$MEHGF <-as.numeric(grab$MEHGF)
if (class(grab$THGU)=="factor") grab$THGU <-as.numeric(levels(grab$THGU))[as.integer(grab$THGU) ]               
if (class(grab$THGU)=="character") grab$THGU <-as.numeric(grab$THGU)
if (class(grab$MEHGU)=="factor") grab$MEHGU <-as.numeric(levels(grab$MEHGU))[as.integer(grab$MEHGU) ]               
if (class(grab$MEHGU)=="character") grab$MEHGU <-as.numeric(grab$MEHGU)
if (class(grab$d202Hg)=="factor") grab$d202Hg <-as.numeric(levels(grab$d202Hg))[as.integer(grab$d202Hg) ]               
if (class(grab$d202Hg)=="character") grab$d202Hg <-as.numeric(grab$d202Hg)
if (class(grab$MIF204Hg)=="factor") grab$MIF204Hg <-as.numeric(levels(grab$MIF204Hg))[as.integer(grab$MIF204Hg) ]               
if (class(grab$MIF204Hg)=="character") grab$MIF204Hg <-as.numeric(grab$MIF204Hg)
if (class(grab$MIF201Hg)=="factor") grab$MIF201Hg <-as.numeric(levels(grab$MIF201Hg))[as.integer(grab$MIF201Hg) ]               
if (class(grab$MIF201Hg)=="character") grab$MIF201Hg <-as.numeric(grab$MIF201Hg)
if (class(grab$MIF200Hg)=="factor") grab$MIF200Hg <-as.numeric(levels(grab$MIF200Hg))[as.integer(grab$MIF200Hg) ]               
if (class(grab$MIF200Hg)=="character") grab$MIF200Hg <-as.numeric(grab$MIF200Hg)
if (class(grab$MIF199Hg)=="factor") grab$MIF199Hg <-as.numeric(levels(grab$MIF199Hg))[as.integer(grab$MIF199Hg) ]               
if (class(grab$MIF199Hg)=="character") grab$MIF199Hg <-as.numeric(grab$MIF199Hg)
if (class(grab$PB)=="factor") grab$PB <-as.numeric(levels(grab$PB))[as.integer(grab$PB) ]               
if (class(grab$PB)=="character") grab$PB <-as.numeric(grab$PB)
if (class(grab$O18)=="factor") grab$O18 <-as.numeric(levels(grab$O18))[as.integer(grab$O18) ]               
if (class(grab$O18)=="character") grab$O18 <-as.numeric(grab$O18)
if (class(grab$D)=="factor") grab$D <-as.numeric(levels(grab$D))[as.integer(grab$D) ]               
if (class(grab$D)=="character") grab$D <-as.numeric(grab$D)
if (class(grab$FEII)=="factor") grab$FEII <-as.numeric(levels(grab$FEII))[as.integer(grab$FEII) ]               
if (class(grab$FEII)=="character") grab$FEII <-as.numeric(grab$FEII)
if (class(grab$FEIII)=="factor") grab$FEIII <-as.numeric(levels(grab$FEIII))[as.integer(grab$FEIII) ]               
if (class(grab$FEIII)=="character") grab$FEIII <-as.numeric(grab$FEIII)
if (class(grab$STAGE)=="factor") grab$STAGE <-as.numeric(levels(grab$STAGE))[as.integer(grab$STAGE) ]               
if (class(grab$STAGE)=="character") grab$STAGE <-as.numeric(grab$STAGE)
if (class(grab$q)=="factor") grab$q <-as.numeric(levels(grab$q))[as.integer(grab$q) ]               
if (class(grab$q)=="character") grab$q <-as.numeric(grab$q)
if (class(grab$TEMPC)=="factor") grab$TEMPC <-as.numeric(levels(grab$TEMPC))[as.integer(grab$TEMPC) ]               
if (class(grab$TEMPC)=="character") grab$TEMPC <-as.numeric(grab$TEMPC)

# Convert Missing Values to NA for non-dates

grab$PH <- ifelse((trimws(as.character(grab$PH))==trimws("NA")),NA,grab$PH)               
suppressWarnings(grab$PH <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$PH))==as.character(as.numeric("NA"))),NA,grab$PH))
grab$SPCOND <- ifelse((trimws(as.character(grab$SPCOND))==trimws("NA")),NA,grab$SPCOND)               
suppressWarnings(grab$SPCOND <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$SPCOND))==as.character(as.numeric("NA"))),NA,grab$SPCOND))
grab$CL <- ifelse((trimws(as.character(grab$CL))==trimws("NA")),NA,grab$CL)               
suppressWarnings(grab$CL <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$CL))==as.character(as.numeric("NA"))),NA,grab$CL))
grab$SO4 <- ifelse((trimws(as.character(grab$SO4))==trimws("NA")),NA,grab$SO4)               
suppressWarnings(grab$SO4 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$SO4))==as.character(as.numeric("NA"))),NA,grab$SO4))
grab$CA <- ifelse((trimws(as.character(grab$CA))==trimws("NA")),NA,grab$CA)               
suppressWarnings(grab$CA <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$CA))==as.character(as.numeric("NA"))),NA,grab$CA))
grab$K <- ifelse((trimws(as.character(grab$K))==trimws("NA")),NA,grab$K)               
suppressWarnings(grab$K <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$K))==as.character(as.numeric("NA"))),NA,grab$K))
grab$MG <- ifelse((trimws(as.character(grab$MG))==trimws("NA")),NA,grab$MG)               
suppressWarnings(grab$MG <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MG))==as.character(as.numeric("NA"))),NA,grab$MG))
grab$Na <- ifelse((trimws(as.character(grab$Na))==trimws("NA")),NA,grab$Na)               
suppressWarnings(grab$Na <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$Na))==as.character(as.numeric("NA"))),NA,grab$Na))
grab$AL <- ifelse((trimws(as.character(grab$AL))==trimws("NA")),NA,grab$AL)               
suppressWarnings(grab$AL <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$AL))==as.character(as.numeric("NA"))),NA,grab$AL))
grab$FE <- ifelse((trimws(as.character(grab$FE))==trimws("NA")),NA,grab$FE)               
suppressWarnings(grab$FE <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$FE))==as.character(as.numeric("NA"))),NA,grab$FE))
grab$MN <- ifelse((trimws(as.character(grab$MN))==trimws("NA")),NA,grab$MN)               
suppressWarnings(grab$MN <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MN))==as.character(as.numeric("NA"))),NA,grab$MN))
grab$SI <- ifelse((trimws(as.character(grab$SI))==trimws("NA")),NA,grab$SI)               
suppressWarnings(grab$SI <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$SI))==as.character(as.numeric("NA"))),NA,grab$SI))
grab$SR <- ifelse((trimws(as.character(grab$SR))==trimws("NA")),NA,grab$SR)               
suppressWarnings(grab$SR <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$SR))==as.character(as.numeric("NA"))),NA,grab$SR))
grab$NH4 <- ifelse((trimws(as.character(grab$NH4))==trimws("NA")),NA,grab$NH4)               
suppressWarnings(grab$NH4 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$NH4))==as.character(as.numeric("NA"))),NA,grab$NH4))
grab$NO3 <- ifelse((trimws(as.character(grab$NO3))==trimws("NA")),NA,grab$NO3)               
suppressWarnings(grab$NO3 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$NO3))==as.character(as.numeric("NA"))),NA,grab$NO3))
grab$SRP <- ifelse((trimws(as.character(grab$SRP))==trimws("NA")),NA,grab$SRP)               
suppressWarnings(grab$SRP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$SRP))==as.character(as.numeric("NA"))),NA,grab$SRP))
grab$TN <- ifelse((trimws(as.character(grab$TN))==trimws("NA")),NA,grab$TN)               
suppressWarnings(grab$TN <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$TN))==as.character(as.numeric("NA"))),NA,grab$TN))
grab$TP <- ifelse((trimws(as.character(grab$TP))==trimws("NA")),NA,grab$TP)               
suppressWarnings(grab$TP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$TP))==as.character(as.numeric("NA"))),NA,grab$TP))
grab$NPOC <- ifelse((trimws(as.character(grab$NPOC))==trimws("NA")),NA,grab$NPOC)               
suppressWarnings(grab$NPOC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$NPOC))==as.character(as.numeric("NA"))),NA,grab$NPOC))
grab$TC.IC <- ifelse((trimws(as.character(grab$TC.IC))==trimws("NA")),NA,grab$TC.IC)               
suppressWarnings(grab$TC.IC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$TC.IC))==as.character(as.numeric("NA"))),NA,grab$TC.IC))
grab$DOC <- ifelse((trimws(as.character(grab$DOC))==trimws("NA")),NA,grab$DOC)               
suppressWarnings(grab$DOC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$DOC))==as.character(as.numeric("NA"))),NA,grab$DOC))
grab$UVA254 <- ifelse((trimws(as.character(grab$UVA254))==trimws("NA")),NA,grab$UVA254)               
suppressWarnings(grab$UVA254 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$UVA254))==as.character(as.numeric("NA"))),NA,grab$UVA254))
grab$UVA360 <- ifelse((trimws(as.character(grab$UVA360))==trimws("NA")),NA,grab$UVA360)               
suppressWarnings(grab$UVA360 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$UVA360))==as.character(as.numeric("NA"))),NA,grab$UVA360))
grab$UVA360S <- ifelse((trimws(as.character(grab$UVA360S))==trimws("NA")),NA,grab$UVA360S)               
suppressWarnings(grab$UVA360S <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$UVA360S))==as.character(as.numeric("NA"))),NA,grab$UVA360S))
grab$BDOC <- ifelse((trimws(as.character(grab$BDOC))==trimws("NA")),NA,grab$BDOC)               
suppressWarnings(grab$BDOC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$BDOC))==as.character(as.numeric("NA"))),NA,grab$BDOC))
grab$BR <- ifelse((trimws(as.character(grab$BR))==trimws("NA")),NA,grab$BR)               
suppressWarnings(grab$BR <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$BR))==as.character(as.numeric("NA"))),NA,grab$BR))
grab$THGF <- ifelse((trimws(as.character(grab$THGF))==trimws("NA")),NA,grab$THGF)               
suppressWarnings(grab$THGF <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$THGF))==as.character(as.numeric("NA"))),NA,grab$THGF))
grab$MEHGF <- ifelse((trimws(as.character(grab$MEHGF))==trimws("NA")),NA,grab$MEHGF)               
suppressWarnings(grab$MEHGF <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MEHGF))==as.character(as.numeric("NA"))),NA,grab$MEHGF))
grab$THGU <- ifelse((trimws(as.character(grab$THGU))==trimws("NA")),NA,grab$THGU)               
suppressWarnings(grab$THGU <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$THGU))==as.character(as.numeric("NA"))),NA,grab$THGU))
grab$MEHGU <- ifelse((trimws(as.character(grab$MEHGU))==trimws("NA")),NA,grab$MEHGU)               
suppressWarnings(grab$MEHGU <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MEHGU))==as.character(as.numeric("NA"))),NA,grab$MEHGU))
grab$d202Hg <- ifelse((trimws(as.character(grab$d202Hg))==trimws("NA")),NA,grab$d202Hg)               
suppressWarnings(grab$d202Hg <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$d202Hg))==as.character(as.numeric("NA"))),NA,grab$d202Hg))
grab$MIF204Hg <- ifelse((trimws(as.character(grab$MIF204Hg))==trimws("NA")),NA,grab$MIF204Hg)               
suppressWarnings(grab$MIF204Hg <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MIF204Hg))==as.character(as.numeric("NA"))),NA,grab$MIF204Hg))
grab$MIF201Hg <- ifelse((trimws(as.character(grab$MIF201Hg))==trimws("NA")),NA,grab$MIF201Hg)               
suppressWarnings(grab$MIF201Hg <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MIF201Hg))==as.character(as.numeric("NA"))),NA,grab$MIF201Hg))
grab$MIF200Hg <- ifelse((trimws(as.character(grab$MIF200Hg))==trimws("NA")),NA,grab$MIF200Hg)               
suppressWarnings(grab$MIF200Hg <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MIF200Hg))==as.character(as.numeric("NA"))),NA,grab$MIF200Hg))
grab$MIF199Hg <- ifelse((trimws(as.character(grab$MIF199Hg))==trimws("NA")),NA,grab$MIF199Hg)               
suppressWarnings(grab$MIF199Hg <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$MIF199Hg))==as.character(as.numeric("NA"))),NA,grab$MIF199Hg))
grab$PB <- ifelse((trimws(as.character(grab$PB))==trimws("NA")),NA,grab$PB)               
suppressWarnings(grab$PB <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$PB))==as.character(as.numeric("NA"))),NA,grab$PB))
grab$O18 <- ifelse((trimws(as.character(grab$O18))==trimws("NA")),NA,grab$O18)               
suppressWarnings(grab$O18 <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$O18))==as.character(as.numeric("NA"))),NA,grab$O18))
grab$D <- ifelse((trimws(as.character(grab$D))==trimws("NA")),NA,grab$D)               
suppressWarnings(grab$D <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$D))==as.character(as.numeric("NA"))),NA,grab$D))
grab$FEII <- ifelse((trimws(as.character(grab$FEII))==trimws("NA")),NA,grab$FEII)               
suppressWarnings(grab$FEII <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$FEII))==as.character(as.numeric("NA"))),NA,grab$FEII))
grab$FEIII <- ifelse((trimws(as.character(grab$FEIII))==trimws("NA")),NA,grab$FEIII)               
suppressWarnings(grab$FEIII <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$FEIII))==as.character(as.numeric("NA"))),NA,grab$FEIII))
grab$STAGE <- ifelse((trimws(as.character(grab$STAGE))==trimws("NA")),NA,grab$STAGE)               
suppressWarnings(grab$STAGE <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$STAGE))==as.character(as.numeric("NA"))),NA,grab$STAGE))
grab$q <- ifelse((trimws(as.character(grab$q))==trimws("NA")),NA,grab$q)               
suppressWarnings(grab$q <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$q))==as.character(as.numeric("NA"))),NA,grab$q))
grab$TEMPC <- ifelse((trimws(as.character(grab$TEMPC))==trimws("NA")),NA,grab$TEMPC)               
suppressWarnings(grab$TEMPC <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(grab$TEMPC))==as.character(as.numeric("NA"))),NA,grab$TEMPC))


# Here is the structure of the input data frame:
str(grab)                            
attach(grab)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(Peatland)
summary(NAME)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(NPOC)
summary(TC.IC)
summary(DOC)
summary(UVA254)
summary(UVA360)
summary(UVA360S)
summary(BDOC)
summary(BR)
summary(THGF)
summary(MEHGF)
summary(THGU)
summary(MEHGU)
summary(d202Hg)
summary(MIF204Hg)
summary(MIF201Hg)
summary(MIF200Hg)
summary(MIF199Hg)
summary(PB)
summary(O18)
summary(D)
summary(FEII)
summary(FEIII)
summary(STAGE)
summary(q)
summary(TEMPC) 
# Get more details on character variables

summary(as.factor(grab$Peatland)) 
summary(as.factor(grab$NAME))
detach(grab)     

#bog+lagg porewater
# Package ID: edi.712.2 Cataloging System:https://pasta.edirepository.org.
# Data set title: Marcell Experimental Forest porewater chemistry at the S2 catchment, 2009 - ongoing.
# Data set creator:  Stephen Sebestyen - USDA Forest Service, Northern Research Station 
# Data set creator:  Nina Lany - USDA Forest Service, Northern Research Station 
# Data set creator:  John Larson - USDA Forest Service, Northern Research Station 
# Data set creator:  Nathan Aspelin - USDA Forest Service, Northern Research Station 
# Data set creator:  Keith Oleheiser - XCEL Engineering 
# Data set creator:  Doris Nelson - USDA Forest Service, Northern Research Station 
# Data set creator:  Steven Hall - Iowa State University 
# Data set creator:  Holly Curtinrich - Iowa State University 
# Contact:    -  Data Manager, Marcell Experimental Forest  - nina.lany@usda.gov
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/6108c9dac7d837a4955f233eb4467ff2" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


bog_pore_month <-read.csv(infile1,header=F 
                          ,skip=1
                          ,sep=","  
                          , col.names=c(
                            "LAB_ID",     
                            "NAME",     
                            "PIEZOMETER",     
                            "DEPTH",     
                            "DateTime",     
                            "PH",     
                            "SPCOND",     
                            "CL",     
                            "SO4",     
                            "CA",     
                            "K",     
                            "MG",     
                            "Na",     
                            "AL",     
                            "FE",     
                            "MN",     
                            "SI",     
                            "SR",     
                            "NH4",     
                            "NO3",     
                            "SRP",     
                            "TN",     
                            "TP",     
                            "TOC"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(bog_pore_month$LAB_ID)!="factor") bog_pore_month$LAB_ID<- as.factor(bog_pore_month$LAB_ID)
if (class(bog_pore_month$NAME)!="factor") bog_pore_month$NAME<- as.factor(bog_pore_month$NAME)
if (class(bog_pore_month$PIEZOMETER)!="factor") bog_pore_month$PIEZOMETER<- as.factor(bog_pore_month$PIEZOMETER)
if (class(bog_pore_month$DEPTH)=="factor") bog_pore_month$DEPTH <-as.numeric(levels(bog_pore_month$DEPTH))[as.integer(bog_pore_month$DEPTH) ]               
if (class(bog_pore_month$DEPTH)=="character") bog_pore_month$DEPTH <-as.numeric(bog_pore_month$DEPTH)                                   
# attempting to convert bog_pore_month$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1DateTime<-as.POSIXct(bog_pore_month$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DateTime) == length(tmp1DateTime[!is.na(tmp1DateTime)])){bog_pore_month$DateTime <- tmp1DateTime } else {print("Date conversion failed for bog_pore_month$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1DateTime) 
if (class(bog_pore_month$PH)=="factor") bog_pore_month$PH <-as.numeric(levels(bog_pore_month$PH))[as.integer(bog_pore_month$PH) ]               
if (class(bog_pore_month$PH)=="character") bog_pore_month$PH <-as.numeric(bog_pore_month$PH)
if (class(bog_pore_month$SPCOND)=="factor") bog_pore_month$SPCOND <-as.numeric(levels(bog_pore_month$SPCOND))[as.integer(bog_pore_month$SPCOND) ]               
if (class(bog_pore_month$SPCOND)=="character") bog_pore_month$SPCOND <-as.numeric(bog_pore_month$SPCOND)
if (class(bog_pore_month$CL)=="factor") bog_pore_month$CL <-as.numeric(levels(bog_pore_month$CL))[as.integer(bog_pore_month$CL) ]               
if (class(bog_pore_month$CL)=="character") bog_pore_month$CL <-as.numeric(bog_pore_month$CL)
if (class(bog_pore_month$SO4)=="factor") bog_pore_month$SO4 <-as.numeric(levels(bog_pore_month$SO4))[as.integer(bog_pore_month$SO4) ]               
if (class(bog_pore_month$SO4)=="character") bog_pore_month$SO4 <-as.numeric(bog_pore_month$SO4)
if (class(bog_pore_month$CA)=="factor") bog_pore_month$CA <-as.numeric(levels(bog_pore_month$CA))[as.integer(bog_pore_month$CA) ]               
if (class(bog_pore_month$CA)=="character") bog_pore_month$CA <-as.numeric(bog_pore_month$CA)
if (class(bog_pore_month$K)=="factor") bog_pore_month$K <-as.numeric(levels(bog_pore_month$K))[as.integer(bog_pore_month$K) ]               
if (class(bog_pore_month$K)=="character") bog_pore_month$K <-as.numeric(bog_pore_month$K)
if (class(bog_pore_month$MG)=="factor") bog_pore_month$MG <-as.numeric(levels(bog_pore_month$MG))[as.integer(bog_pore_month$MG) ]               
if (class(bog_pore_month$MG)=="character") bog_pore_month$MG <-as.numeric(bog_pore_month$MG)
if (class(bog_pore_month$Na)=="factor") bog_pore_month$Na <-as.numeric(levels(bog_pore_month$Na))[as.integer(bog_pore_month$Na) ]               
if (class(bog_pore_month$Na)=="character") bog_pore_month$Na <-as.numeric(bog_pore_month$Na)
if (class(bog_pore_month$AL)=="factor") bog_pore_month$AL <-as.numeric(levels(bog_pore_month$AL))[as.integer(bog_pore_month$AL) ]               
if (class(bog_pore_month$AL)=="character") bog_pore_month$AL <-as.numeric(bog_pore_month$AL)
if (class(bog_pore_month$FE)=="factor") bog_pore_month$FE <-as.numeric(levels(bog_pore_month$FE))[as.integer(bog_pore_month$FE) ]               
if (class(bog_pore_month$FE)=="character") bog_pore_month$FE <-as.numeric(bog_pore_month$FE)
if (class(bog_pore_month$MN)=="factor") bog_pore_month$MN <-as.numeric(levels(bog_pore_month$MN))[as.integer(bog_pore_month$MN) ]               
if (class(bog_pore_month$MN)=="character") bog_pore_month$MN <-as.numeric(bog_pore_month$MN)
if (class(bog_pore_month$SI)=="factor") bog_pore_month$SI <-as.numeric(levels(bog_pore_month$SI))[as.integer(bog_pore_month$SI) ]               
if (class(bog_pore_month$SI)=="character") bog_pore_month$SI <-as.numeric(bog_pore_month$SI)
if (class(bog_pore_month$SR)=="factor") bog_pore_month$SR <-as.numeric(levels(bog_pore_month$SR))[as.integer(bog_pore_month$SR) ]               
if (class(bog_pore_month$SR)=="character") bog_pore_month$SR <-as.numeric(bog_pore_month$SR)
if (class(bog_pore_month$NH4)=="factor") bog_pore_month$NH4 <-as.numeric(levels(bog_pore_month$NH4))[as.integer(bog_pore_month$NH4) ]               
if (class(bog_pore_month$NH4)=="character") bog_pore_month$NH4 <-as.numeric(bog_pore_month$NH4)
if (class(bog_pore_month$NO3)=="factor") bog_pore_month$NO3 <-as.numeric(levels(bog_pore_month$NO3))[as.integer(bog_pore_month$NO3) ]               
if (class(bog_pore_month$NO3)=="character") bog_pore_month$NO3 <-as.numeric(bog_pore_month$NO3)
if (class(bog_pore_month$SRP)=="factor") bog_pore_month$SRP <-as.numeric(levels(bog_pore_month$SRP))[as.integer(bog_pore_month$SRP) ]               
if (class(bog_pore_month$SRP)=="character") bog_pore_month$SRP <-as.numeric(bog_pore_month$SRP)
if (class(bog_pore_month$TN)=="factor") bog_pore_month$TN <-as.numeric(levels(bog_pore_month$TN))[as.integer(bog_pore_month$TN) ]               
if (class(bog_pore_month$TN)=="character") bog_pore_month$TN <-as.numeric(bog_pore_month$TN)
if (class(bog_pore_month$TP)=="factor") bog_pore_month$TP <-as.numeric(levels(bog_pore_month$TP))[as.integer(bog_pore_month$TP) ]               
if (class(bog_pore_month$TP)=="character") bog_pore_month$TP <-as.numeric(bog_pore_month$TP)
if (class(bog_pore_month$TOC)=="factor") bog_pore_month$TOC <-as.numeric(levels(bog_pore_month$TOC))[as.integer(bog_pore_month$TOC) ]               
if (class(bog_pore_month$TOC)=="character") bog_pore_month$TOC <-as.numeric(bog_pore_month$TOC)

# Convert Missing Values to NA for non-dates

bog_pore_month$PH <- ifelse((trimws(as.character(bog_pore_month$PH))==trimws("-9999")),NA,bog_pore_month$PH)               
suppressWarnings(bog_pore_month$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$PH))==as.character(as.numeric("-9999"))),NA,bog_pore_month$PH))
bog_pore_month$SPCOND <- ifelse((trimws(as.character(bog_pore_month$SPCOND))==trimws("-9999")),NA,bog_pore_month$SPCOND)               
suppressWarnings(bog_pore_month$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$SPCOND))==as.character(as.numeric("-9999"))),NA,bog_pore_month$SPCOND))
bog_pore_month$CL <- ifelse((trimws(as.character(bog_pore_month$CL))==trimws("-9999")),NA,bog_pore_month$CL)               
suppressWarnings(bog_pore_month$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$CL))==as.character(as.numeric("-9999"))),NA,bog_pore_month$CL))
bog_pore_month$SO4 <- ifelse((trimws(as.character(bog_pore_month$SO4))==trimws("-9999")),NA,bog_pore_month$SO4)               
suppressWarnings(bog_pore_month$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$SO4))==as.character(as.numeric("-9999"))),NA,bog_pore_month$SO4))
bog_pore_month$CA <- ifelse((trimws(as.character(bog_pore_month$CA))==trimws("-9999")),NA,bog_pore_month$CA)               
suppressWarnings(bog_pore_month$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$CA))==as.character(as.numeric("-9999"))),NA,bog_pore_month$CA))
bog_pore_month$K <- ifelse((trimws(as.character(bog_pore_month$K))==trimws("-9999")),NA,bog_pore_month$K)               
suppressWarnings(bog_pore_month$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$K))==as.character(as.numeric("-9999"))),NA,bog_pore_month$K))
bog_pore_month$MG <- ifelse((trimws(as.character(bog_pore_month$MG))==trimws("-9999")),NA,bog_pore_month$MG)               
suppressWarnings(bog_pore_month$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$MG))==as.character(as.numeric("-9999"))),NA,bog_pore_month$MG))
bog_pore_month$Na <- ifelse((trimws(as.character(bog_pore_month$Na))==trimws("-9999")),NA,bog_pore_month$Na)               
suppressWarnings(bog_pore_month$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$Na))==as.character(as.numeric("-9999"))),NA,bog_pore_month$Na))
bog_pore_month$AL <- ifelse((trimws(as.character(bog_pore_month$AL))==trimws("-9999")),NA,bog_pore_month$AL)               
suppressWarnings(bog_pore_month$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$AL))==as.character(as.numeric("-9999"))),NA,bog_pore_month$AL))
bog_pore_month$FE <- ifelse((trimws(as.character(bog_pore_month$FE))==trimws("-9999")),NA,bog_pore_month$FE)               
suppressWarnings(bog_pore_month$FE <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$FE))==as.character(as.numeric("-9999"))),NA,bog_pore_month$FE))
bog_pore_month$MN <- ifelse((trimws(as.character(bog_pore_month$MN))==trimws("-9999")),NA,bog_pore_month$MN)               
suppressWarnings(bog_pore_month$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$MN))==as.character(as.numeric("-9999"))),NA,bog_pore_month$MN))
bog_pore_month$SI <- ifelse((trimws(as.character(bog_pore_month$SI))==trimws("-9999")),NA,bog_pore_month$SI)               
suppressWarnings(bog_pore_month$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$SI))==as.character(as.numeric("-9999"))),NA,bog_pore_month$SI))
bog_pore_month$SR <- ifelse((trimws(as.character(bog_pore_month$SR))==trimws("-9999")),NA,bog_pore_month$SR)               
suppressWarnings(bog_pore_month$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$SR))==as.character(as.numeric("-9999"))),NA,bog_pore_month$SR))
bog_pore_month$NH4 <- ifelse((trimws(as.character(bog_pore_month$NH4))==trimws("-9999")),NA,bog_pore_month$NH4)               
suppressWarnings(bog_pore_month$NH4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$NH4))==as.character(as.numeric("-9999"))),NA,bog_pore_month$NH4))
bog_pore_month$NO3 <- ifelse((trimws(as.character(bog_pore_month$NO3))==trimws("-9999")),NA,bog_pore_month$NO3)               
suppressWarnings(bog_pore_month$NO3 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$NO3))==as.character(as.numeric("-9999"))),NA,bog_pore_month$NO3))
bog_pore_month$SRP <- ifelse((trimws(as.character(bog_pore_month$SRP))==trimws("-9999")),NA,bog_pore_month$SRP)               
suppressWarnings(bog_pore_month$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$SRP))==as.character(as.numeric("-9999"))),NA,bog_pore_month$SRP))
bog_pore_month$TN <- ifelse((trimws(as.character(bog_pore_month$TN))==trimws("-9999")),NA,bog_pore_month$TN)               
suppressWarnings(bog_pore_month$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$TN))==as.character(as.numeric("-9999"))),NA,bog_pore_month$TN))
bog_pore_month$TP <- ifelse((trimws(as.character(bog_pore_month$TP))==trimws("-9999")),NA,bog_pore_month$TP)               
suppressWarnings(bog_pore_month$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$TP))==as.character(as.numeric("-9999"))),NA,bog_pore_month$TP))
bog_pore_month$TOC <- ifelse((trimws(as.character(bog_pore_month$TOC))==trimws("-9999")),NA,bog_pore_month$TOC)               
suppressWarnings(bog_pore_month$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_month$TOC))==as.character(as.numeric("-9999"))),NA,bog_pore_month$TOC))


# Here is the structure of the input data frame:
str(bog_pore_month)                            
attach(bog_pore_month)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(NAME)
summary(PIEZOMETER)
summary(DEPTH)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC) 
# Get more details on character variables

summary(as.factor(bog_pore_month$LAB_ID)) 
summary(as.factor(bog_pore_month$NAME)) 
summary(as.factor(bog_pore_month$PIEZOMETER))
detach(bog_pore_month)               


inUrl2  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/0c95f59906b6d579b9304a8b474617c6" 
infile2 <- tempfile()
try(download.file(inUrl2,infile2,method="curl"))
if (is.na(file.size(infile2))) download.file(inUrl2,infile2,method="auto")


bog_pore_synop <-read.csv(infile2,header=F 
                          ,skip=1
                          ,sep=","  
                          , col.names=c(
                            "LAB_ID",     
                            "PIEZOMETER",     
                            "DateTime",     
                            "PH",     
                            "SPCOND",     
                            "CL",     
                            "SO4",     
                            "CA",     
                            "K",     
                            "MG",     
                            "Na",     
                            "AL",     
                            "FE",     
                            "MN",     
                            "SI",     
                            "SR",     
                            "SRP",     
                            "TN",     
                            "TP",     
                            "TOC",     
                            "O18",     
                            "D"    ), check.names=TRUE)

unlink(infile2)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(bog_pore_synop$LAB_ID)!="factor") bog_pore_synop$LAB_ID<- as.factor(bog_pore_synop$LAB_ID)
if (class(bog_pore_synop$PIEZOMETER)!="factor") bog_pore_synop$PIEZOMETER<- as.factor(bog_pore_synop$PIEZOMETER)                                   
# attempting to convert bog_pore_synop$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp2DateTime<-as.POSIXct(bog_pore_synop$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp2DateTime) == length(tmp2DateTime[!is.na(tmp2DateTime)])){bog_pore_synop$DateTime <- tmp2DateTime } else {print("Date conversion failed for bog_pore_synop$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp2DateTime) 
if (class(bog_pore_synop$PH)=="factor") bog_pore_synop$PH <-as.numeric(levels(bog_pore_synop$PH))[as.integer(bog_pore_synop$PH) ]               
if (class(bog_pore_synop$PH)=="character") bog_pore_synop$PH <-as.numeric(bog_pore_synop$PH)
if (class(bog_pore_synop$SPCOND)=="factor") bog_pore_synop$SPCOND <-as.numeric(levels(bog_pore_synop$SPCOND))[as.integer(bog_pore_synop$SPCOND) ]               
if (class(bog_pore_synop$SPCOND)=="character") bog_pore_synop$SPCOND <-as.numeric(bog_pore_synop$SPCOND)
if (class(bog_pore_synop$CL)=="factor") bog_pore_synop$CL <-as.numeric(levels(bog_pore_synop$CL))[as.integer(bog_pore_synop$CL) ]               
if (class(bog_pore_synop$CL)=="character") bog_pore_synop$CL <-as.numeric(bog_pore_synop$CL)
if (class(bog_pore_synop$SO4)=="factor") bog_pore_synop$SO4 <-as.numeric(levels(bog_pore_synop$SO4))[as.integer(bog_pore_synop$SO4) ]               
if (class(bog_pore_synop$SO4)=="character") bog_pore_synop$SO4 <-as.numeric(bog_pore_synop$SO4)
if (class(bog_pore_synop$CA)=="factor") bog_pore_synop$CA <-as.numeric(levels(bog_pore_synop$CA))[as.integer(bog_pore_synop$CA) ]               
if (class(bog_pore_synop$CA)=="character") bog_pore_synop$CA <-as.numeric(bog_pore_synop$CA)
if (class(bog_pore_synop$K)=="factor") bog_pore_synop$K <-as.numeric(levels(bog_pore_synop$K))[as.integer(bog_pore_synop$K) ]               
if (class(bog_pore_synop$K)=="character") bog_pore_synop$K <-as.numeric(bog_pore_synop$K)
if (class(bog_pore_synop$MG)=="factor") bog_pore_synop$MG <-as.numeric(levels(bog_pore_synop$MG))[as.integer(bog_pore_synop$MG) ]               
if (class(bog_pore_synop$MG)=="character") bog_pore_synop$MG <-as.numeric(bog_pore_synop$MG)
if (class(bog_pore_synop$Na)=="factor") bog_pore_synop$Na <-as.numeric(levels(bog_pore_synop$Na))[as.integer(bog_pore_synop$Na) ]               
if (class(bog_pore_synop$Na)=="character") bog_pore_synop$Na <-as.numeric(bog_pore_synop$Na)
if (class(bog_pore_synop$AL)=="factor") bog_pore_synop$AL <-as.numeric(levels(bog_pore_synop$AL))[as.integer(bog_pore_synop$AL) ]               
if (class(bog_pore_synop$AL)=="character") bog_pore_synop$AL <-as.numeric(bog_pore_synop$AL)
if (class(bog_pore_synop$FE)=="factor") bog_pore_synop$FE <-as.numeric(levels(bog_pore_synop$FE))[as.integer(bog_pore_synop$FE) ]               
if (class(bog_pore_synop$FE)=="character") bog_pore_synop$FE <-as.numeric(bog_pore_synop$FE)
if (class(bog_pore_synop$MN)=="factor") bog_pore_synop$MN <-as.numeric(levels(bog_pore_synop$MN))[as.integer(bog_pore_synop$MN) ]               
if (class(bog_pore_synop$MN)=="character") bog_pore_synop$MN <-as.numeric(bog_pore_synop$MN)
if (class(bog_pore_synop$SI)=="factor") bog_pore_synop$SI <-as.numeric(levels(bog_pore_synop$SI))[as.integer(bog_pore_synop$SI) ]               
if (class(bog_pore_synop$SI)=="character") bog_pore_synop$SI <-as.numeric(bog_pore_synop$SI)
if (class(bog_pore_synop$SR)=="factor") bog_pore_synop$SR <-as.numeric(levels(bog_pore_synop$SR))[as.integer(bog_pore_synop$SR) ]               
if (class(bog_pore_synop$SR)=="character") bog_pore_synop$SR <-as.numeric(bog_pore_synop$SR)
if (class(bog_pore_synop$SRP)=="factor") bog_pore_synop$SRP <-as.numeric(levels(bog_pore_synop$SRP))[as.integer(bog_pore_synop$SRP) ]               
if (class(bog_pore_synop$SRP)=="character") bog_pore_synop$SRP <-as.numeric(bog_pore_synop$SRP)
if (class(bog_pore_synop$TN)=="factor") bog_pore_synop$TN <-as.numeric(levels(bog_pore_synop$TN))[as.integer(bog_pore_synop$TN) ]               
if (class(bog_pore_synop$TN)=="character") bog_pore_synop$TN <-as.numeric(bog_pore_synop$TN)
if (class(bog_pore_synop$TP)=="factor") bog_pore_synop$TP <-as.numeric(levels(bog_pore_synop$TP))[as.integer(bog_pore_synop$TP) ]               
if (class(bog_pore_synop$TP)=="character") bog_pore_synop$TP <-as.numeric(bog_pore_synop$TP)
if (class(bog_pore_synop$TOC)=="factor") bog_pore_synop$TOC <-as.numeric(levels(bog_pore_synop$TOC))[as.integer(bog_pore_synop$TOC) ]               
if (class(bog_pore_synop$TOC)=="character") bog_pore_synop$TOC <-as.numeric(bog_pore_synop$TOC)
if (class(bog_pore_synop$O18)=="factor") bog_pore_synop$O18 <-as.numeric(levels(bog_pore_synop$O18))[as.integer(bog_pore_synop$O18) ]               
if (class(bog_pore_synop$O18)=="character") bog_pore_synop$O18 <-as.numeric(bog_pore_synop$O18)
if (class(bog_pore_synop$D)=="factor") bog_pore_synop$D <-as.numeric(levels(bog_pore_synop$D))[as.integer(bog_pore_synop$D) ]               
if (class(bog_pore_synop$D)=="character") bog_pore_synop$D <-as.numeric(bog_pore_synop$D)

# Convert Missing Values to NA for non-dates

bog_pore_synop$PH <- ifelse((trimws(as.character(bog_pore_synop$PH))==trimws("-9999")),NA,bog_pore_synop$PH)               
suppressWarnings(bog_pore_synop$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$PH))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$PH))
bog_pore_synop$SPCOND <- ifelse((trimws(as.character(bog_pore_synop$SPCOND))==trimws("-9999")),NA,bog_pore_synop$SPCOND)               
suppressWarnings(bog_pore_synop$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$SPCOND))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$SPCOND))
bog_pore_synop$CL <- ifelse((trimws(as.character(bog_pore_synop$CL))==trimws("-9999")),NA,bog_pore_synop$CL)               
suppressWarnings(bog_pore_synop$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$CL))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$CL))
bog_pore_synop$SO4 <- ifelse((trimws(as.character(bog_pore_synop$SO4))==trimws("-9999")),NA,bog_pore_synop$SO4)               
suppressWarnings(bog_pore_synop$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$SO4))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$SO4))
bog_pore_synop$CA <- ifelse((trimws(as.character(bog_pore_synop$CA))==trimws("-9999")),NA,bog_pore_synop$CA)               
suppressWarnings(bog_pore_synop$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$CA))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$CA))
bog_pore_synop$K <- ifelse((trimws(as.character(bog_pore_synop$K))==trimws("-9999")),NA,bog_pore_synop$K)               
suppressWarnings(bog_pore_synop$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$K))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$K))
bog_pore_synop$MG <- ifelse((trimws(as.character(bog_pore_synop$MG))==trimws("-9999")),NA,bog_pore_synop$MG)               
suppressWarnings(bog_pore_synop$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$MG))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$MG))
bog_pore_synop$Na <- ifelse((trimws(as.character(bog_pore_synop$Na))==trimws("-9999")),NA,bog_pore_synop$Na)               
suppressWarnings(bog_pore_synop$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$Na))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$Na))
bog_pore_synop$AL <- ifelse((trimws(as.character(bog_pore_synop$AL))==trimws("-9999")),NA,bog_pore_synop$AL)               
suppressWarnings(bog_pore_synop$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$AL))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$AL))
bog_pore_synop$FE <- ifelse((trimws(as.character(bog_pore_synop$FE))==trimws("-9999")),NA,bog_pore_synop$FE)               
suppressWarnings(bog_pore_synop$FE <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$FE))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$FE))
bog_pore_synop$MN <- ifelse((trimws(as.character(bog_pore_synop$MN))==trimws("-9999")),NA,bog_pore_synop$MN)               
suppressWarnings(bog_pore_synop$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$MN))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$MN))
bog_pore_synop$SI <- ifelse((trimws(as.character(bog_pore_synop$SI))==trimws("-9999")),NA,bog_pore_synop$SI)               
suppressWarnings(bog_pore_synop$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$SI))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$SI))
bog_pore_synop$SR <- ifelse((trimws(as.character(bog_pore_synop$SR))==trimws("-9999")),NA,bog_pore_synop$SR)               
suppressWarnings(bog_pore_synop$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$SR))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$SR))
bog_pore_synop$SRP <- ifelse((trimws(as.character(bog_pore_synop$SRP))==trimws("-9999")),NA,bog_pore_synop$SRP)               
suppressWarnings(bog_pore_synop$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$SRP))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$SRP))
bog_pore_synop$TN <- ifelse((trimws(as.character(bog_pore_synop$TN))==trimws("-9999")),NA,bog_pore_synop$TN)               
suppressWarnings(bog_pore_synop$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$TN))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$TN))
bog_pore_synop$TP <- ifelse((trimws(as.character(bog_pore_synop$TP))==trimws("-9999")),NA,bog_pore_synop$TP)               
suppressWarnings(bog_pore_synop$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$TP))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$TP))
bog_pore_synop$TOC <- ifelse((trimws(as.character(bog_pore_synop$TOC))==trimws("-9999")),NA,bog_pore_synop$TOC)               
suppressWarnings(bog_pore_synop$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$TOC))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$TOC))
bog_pore_synop$O18 <- ifelse((trimws(as.character(bog_pore_synop$O18))==trimws("-9999")),NA,bog_pore_synop$O18)               
suppressWarnings(bog_pore_synop$O18 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$O18))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$O18))
bog_pore_synop$D <- ifelse((trimws(as.character(bog_pore_synop$D))==trimws("-9999")),NA,bog_pore_synop$D)               
suppressWarnings(bog_pore_synop$D <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_synop$D))==as.character(as.numeric("-9999"))),NA,bog_pore_synop$D))


# Here is the structure of the input data frame:
str(bog_pore_synop)                            
attach(bog_pore_synop)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(PIEZOMETER)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC)
summary(O18)
summary(D) 
# Get more details on character variables

summary(as.factor(bog_pore_synop$LAB_ID)) 
summary(as.factor(bog_pore_synop$PIEZOMETER))
detach(bog_pore_synop)               


inUrl3  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/8f2373caa4839f0922378c24e00e3906" 
infile3 <- tempfile()
try(download.file(inUrl3,infile3,method="curl"))
if (is.na(file.size(infile3))) download.file(inUrl3,infile3,method="auto")


bog_pore_week <-read.csv(infile3,header=F 
                         ,skip=1
                         ,sep=","  
                         , col.names=c(
                           "LAB_ID",     
                           "PIEZOMETER",     
                           "DateTime",     
                           "PH",     
                           "SPCOND",     
                           "CL",     
                           "SO4",     
                           "CA",     
                           "K",     
                           "MG",     
                           "Na",     
                           "AL",     
                           "FE",     
                           "MN",     
                           "SI",     
                           "SR",     
                           "NH4",     
                           "NO3",     
                           "SRP",     
                           "TN",     
                           "TP",     
                           "TOC",     
                           "O18",     
                           "D",     
                           "FEII",     
                           "FEIII"    ), check.names=TRUE)

unlink(infile3)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(bog_pore_week$LAB_ID)!="factor") bog_pore_week$LAB_ID<- as.factor(bog_pore_week$LAB_ID)
if (class(bog_pore_week$PIEZOMETER)!="factor") bog_pore_week$PIEZOMETER<- as.factor(bog_pore_week$PIEZOMETER)                                   
# attempting to convert bog_pore_week$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp3DateTime<-as.POSIXct(bog_pore_week$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp3DateTime) == length(tmp3DateTime[!is.na(tmp3DateTime)])){bog_pore_week$DateTime <- tmp3DateTime } else {print("Date conversion failed for bog_pore_week$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp3DateTime) 
if (class(bog_pore_week$PH)=="factor") bog_pore_week$PH <-as.numeric(levels(bog_pore_week$PH))[as.integer(bog_pore_week$PH) ]               
if (class(bog_pore_week$PH)=="character") bog_pore_week$PH <-as.numeric(bog_pore_week$PH)
if (class(bog_pore_week$SPCOND)=="factor") bog_pore_week$SPCOND <-as.numeric(levels(bog_pore_week$SPCOND))[as.integer(bog_pore_week$SPCOND) ]               
if (class(bog_pore_week$SPCOND)=="character") bog_pore_week$SPCOND <-as.numeric(bog_pore_week$SPCOND)
if (class(bog_pore_week$CL)=="factor") bog_pore_week$CL <-as.numeric(levels(bog_pore_week$CL))[as.integer(bog_pore_week$CL) ]               
if (class(bog_pore_week$CL)=="character") bog_pore_week$CL <-as.numeric(bog_pore_week$CL)
if (class(bog_pore_week$SO4)=="factor") bog_pore_week$SO4 <-as.numeric(levels(bog_pore_week$SO4))[as.integer(bog_pore_week$SO4) ]               
if (class(bog_pore_week$SO4)=="character") bog_pore_week$SO4 <-as.numeric(bog_pore_week$SO4)
if (class(bog_pore_week$CA)=="factor") bog_pore_week$CA <-as.numeric(levels(bog_pore_week$CA))[as.integer(bog_pore_week$CA) ]               
if (class(bog_pore_week$CA)=="character") bog_pore_week$CA <-as.numeric(bog_pore_week$CA)
if (class(bog_pore_week$K)=="factor") bog_pore_week$K <-as.numeric(levels(bog_pore_week$K))[as.integer(bog_pore_week$K) ]               
if (class(bog_pore_week$K)=="character") bog_pore_week$K <-as.numeric(bog_pore_week$K)
if (class(bog_pore_week$MG)=="factor") bog_pore_week$MG <-as.numeric(levels(bog_pore_week$MG))[as.integer(bog_pore_week$MG) ]               
if (class(bog_pore_week$MG)=="character") bog_pore_week$MG <-as.numeric(bog_pore_week$MG)
if (class(bog_pore_week$Na)=="factor") bog_pore_week$Na <-as.numeric(levels(bog_pore_week$Na))[as.integer(bog_pore_week$Na) ]               
if (class(bog_pore_week$Na)=="character") bog_pore_week$Na <-as.numeric(bog_pore_week$Na)
if (class(bog_pore_week$AL)=="factor") bog_pore_week$AL <-as.numeric(levels(bog_pore_week$AL))[as.integer(bog_pore_week$AL) ]               
if (class(bog_pore_week$AL)=="character") bog_pore_week$AL <-as.numeric(bog_pore_week$AL)
if (class(bog_pore_week$FE)=="factor") bog_pore_week$FE <-as.numeric(levels(bog_pore_week$FE))[as.integer(bog_pore_week$FE) ]               
if (class(bog_pore_week$FE)=="character") bog_pore_week$FE <-as.numeric(bog_pore_week$FE)
if (class(bog_pore_week$MN)=="factor") bog_pore_week$MN <-as.numeric(levels(bog_pore_week$MN))[as.integer(bog_pore_week$MN) ]               
if (class(bog_pore_week$MN)=="character") bog_pore_week$MN <-as.numeric(bog_pore_week$MN)
if (class(bog_pore_week$SI)=="factor") bog_pore_week$SI <-as.numeric(levels(bog_pore_week$SI))[as.integer(bog_pore_week$SI) ]               
if (class(bog_pore_week$SI)=="character") bog_pore_week$SI <-as.numeric(bog_pore_week$SI)
if (class(bog_pore_week$SR)=="factor") bog_pore_week$SR <-as.numeric(levels(bog_pore_week$SR))[as.integer(bog_pore_week$SR) ]               
if (class(bog_pore_week$SR)=="character") bog_pore_week$SR <-as.numeric(bog_pore_week$SR)
if (class(bog_pore_week$NH4)=="factor") bog_pore_week$NH4 <-as.numeric(levels(bog_pore_week$NH4))[as.integer(bog_pore_week$NH4) ]               
if (class(bog_pore_week$NH4)=="character") bog_pore_week$NH4 <-as.numeric(bog_pore_week$NH4)
if (class(bog_pore_week$NO3)=="factor") bog_pore_week$NO3 <-as.numeric(levels(bog_pore_week$NO3))[as.integer(bog_pore_week$NO3) ]               
if (class(bog_pore_week$NO3)=="character") bog_pore_week$NO3 <-as.numeric(bog_pore_week$NO3)
if (class(bog_pore_week$SRP)=="factor") bog_pore_week$SRP <-as.numeric(levels(bog_pore_week$SRP))[as.integer(bog_pore_week$SRP) ]               
if (class(bog_pore_week$SRP)=="character") bog_pore_week$SRP <-as.numeric(bog_pore_week$SRP)
if (class(bog_pore_week$TN)=="factor") bog_pore_week$TN <-as.numeric(levels(bog_pore_week$TN))[as.integer(bog_pore_week$TN) ]               
if (class(bog_pore_week$TN)=="character") bog_pore_week$TN <-as.numeric(bog_pore_week$TN)
if (class(bog_pore_week$TP)=="factor") bog_pore_week$TP <-as.numeric(levels(bog_pore_week$TP))[as.integer(bog_pore_week$TP) ]               
if (class(bog_pore_week$TP)=="character") bog_pore_week$TP <-as.numeric(bog_pore_week$TP)
if (class(bog_pore_week$TOC)=="factor") bog_pore_week$TOC <-as.numeric(levels(bog_pore_week$TOC))[as.integer(bog_pore_week$TOC) ]               
if (class(bog_pore_week$TOC)=="character") bog_pore_week$TOC <-as.numeric(bog_pore_week$TOC)
if (class(bog_pore_week$O18)=="factor") bog_pore_week$O18 <-as.numeric(levels(bog_pore_week$O18))[as.integer(bog_pore_week$O18) ]               
if (class(bog_pore_week$O18)=="character") bog_pore_week$O18 <-as.numeric(bog_pore_week$O18)
if (class(bog_pore_week$D)=="factor") bog_pore_week$D <-as.numeric(levels(bog_pore_week$D))[as.integer(bog_pore_week$D) ]               
if (class(bog_pore_week$D)=="character") bog_pore_week$D <-as.numeric(bog_pore_week$D)
if (class(bog_pore_week$FEII)=="factor") bog_pore_week$FEII <-as.numeric(levels(bog_pore_week$FEII))[as.integer(bog_pore_week$FEII) ]               
if (class(bog_pore_week$FEII)=="character") bog_pore_week$FEII <-as.numeric(bog_pore_week$FEII)
if (class(bog_pore_week$FEIII)=="factor") bog_pore_week$FEIII <-as.numeric(levels(bog_pore_week$FEIII))[as.integer(bog_pore_week$FEIII) ]               
if (class(bog_pore_week$FEIII)=="character") bog_pore_week$FEIII <-as.numeric(bog_pore_week$FEIII)

# Convert Missing Values to NA for non-dates

bog_pore_week$PH <- ifelse((trimws(as.character(bog_pore_week$PH))==trimws("-9999")),NA,bog_pore_week$PH)               
suppressWarnings(bog_pore_week$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$PH))==as.character(as.numeric("-9999"))),NA,bog_pore_week$PH))
bog_pore_week$SPCOND <- ifelse((trimws(as.character(bog_pore_week$SPCOND))==trimws("-9999")),NA,bog_pore_week$SPCOND)               
suppressWarnings(bog_pore_week$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$SPCOND))==as.character(as.numeric("-9999"))),NA,bog_pore_week$SPCOND))
bog_pore_week$CL <- ifelse((trimws(as.character(bog_pore_week$CL))==trimws("-9999")),NA,bog_pore_week$CL)               
suppressWarnings(bog_pore_week$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$CL))==as.character(as.numeric("-9999"))),NA,bog_pore_week$CL))
bog_pore_week$SO4 <- ifelse((trimws(as.character(bog_pore_week$SO4))==trimws("-9999")),NA,bog_pore_week$SO4)               
suppressWarnings(bog_pore_week$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$SO4))==as.character(as.numeric("-9999"))),NA,bog_pore_week$SO4))
bog_pore_week$CA <- ifelse((trimws(as.character(bog_pore_week$CA))==trimws("-9999")),NA,bog_pore_week$CA)               
suppressWarnings(bog_pore_week$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$CA))==as.character(as.numeric("-9999"))),NA,bog_pore_week$CA))
bog_pore_week$K <- ifelse((trimws(as.character(bog_pore_week$K))==trimws("-9999")),NA,bog_pore_week$K)               
suppressWarnings(bog_pore_week$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$K))==as.character(as.numeric("-9999"))),NA,bog_pore_week$K))
bog_pore_week$MG <- ifelse((trimws(as.character(bog_pore_week$MG))==trimws("-9999")),NA,bog_pore_week$MG)               
suppressWarnings(bog_pore_week$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$MG))==as.character(as.numeric("-9999"))),NA,bog_pore_week$MG))
bog_pore_week$Na <- ifelse((trimws(as.character(bog_pore_week$Na))==trimws("-9999")),NA,bog_pore_week$Na)               
suppressWarnings(bog_pore_week$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$Na))==as.character(as.numeric("-9999"))),NA,bog_pore_week$Na))
bog_pore_week$AL <- ifelse((trimws(as.character(bog_pore_week$AL))==trimws("-9999")),NA,bog_pore_week$AL)               
suppressWarnings(bog_pore_week$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$AL))==as.character(as.numeric("-9999"))),NA,bog_pore_week$AL))
bog_pore_week$FE <- ifelse((trimws(as.character(bog_pore_week$FE))==trimws("-9999")),NA,bog_pore_week$FE)               
suppressWarnings(bog_pore_week$FE <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$FE))==as.character(as.numeric("-9999"))),NA,bog_pore_week$FE))
bog_pore_week$MN <- ifelse((trimws(as.character(bog_pore_week$MN))==trimws("-9999")),NA,bog_pore_week$MN)               
suppressWarnings(bog_pore_week$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$MN))==as.character(as.numeric("-9999"))),NA,bog_pore_week$MN))
bog_pore_week$SI <- ifelse((trimws(as.character(bog_pore_week$SI))==trimws("-9999")),NA,bog_pore_week$SI)               
suppressWarnings(bog_pore_week$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$SI))==as.character(as.numeric("-9999"))),NA,bog_pore_week$SI))
bog_pore_week$SR <- ifelse((trimws(as.character(bog_pore_week$SR))==trimws("-9999")),NA,bog_pore_week$SR)               
suppressWarnings(bog_pore_week$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$SR))==as.character(as.numeric("-9999"))),NA,bog_pore_week$SR))
bog_pore_week$NH4 <- ifelse((trimws(as.character(bog_pore_week$NH4))==trimws("-9999")),NA,bog_pore_week$NH4)               
suppressWarnings(bog_pore_week$NH4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$NH4))==as.character(as.numeric("-9999"))),NA,bog_pore_week$NH4))
bog_pore_week$NO3 <- ifelse((trimws(as.character(bog_pore_week$NO3))==trimws("-9999")),NA,bog_pore_week$NO3)               
suppressWarnings(bog_pore_week$NO3 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$NO3))==as.character(as.numeric("-9999"))),NA,bog_pore_week$NO3))
bog_pore_week$SRP <- ifelse((trimws(as.character(bog_pore_week$SRP))==trimws("-9999")),NA,bog_pore_week$SRP)               
suppressWarnings(bog_pore_week$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$SRP))==as.character(as.numeric("-9999"))),NA,bog_pore_week$SRP))
bog_pore_week$TN <- ifelse((trimws(as.character(bog_pore_week$TN))==trimws("-9999")),NA,bog_pore_week$TN)               
suppressWarnings(bog_pore_week$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$TN))==as.character(as.numeric("-9999"))),NA,bog_pore_week$TN))
bog_pore_week$TP <- ifelse((trimws(as.character(bog_pore_week$TP))==trimws("-9999")),NA,bog_pore_week$TP)               
suppressWarnings(bog_pore_week$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$TP))==as.character(as.numeric("-9999"))),NA,bog_pore_week$TP))
bog_pore_week$TOC <- ifelse((trimws(as.character(bog_pore_week$TOC))==trimws("-9999")),NA,bog_pore_week$TOC)               
suppressWarnings(bog_pore_week$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$TOC))==as.character(as.numeric("-9999"))),NA,bog_pore_week$TOC))
bog_pore_week$O18 <- ifelse((trimws(as.character(bog_pore_week$O18))==trimws("-9999")),NA,bog_pore_week$O18)               
suppressWarnings(bog_pore_week$O18 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$O18))==as.character(as.numeric("-9999"))),NA,bog_pore_week$O18))
bog_pore_week$D <- ifelse((trimws(as.character(bog_pore_week$D))==trimws("-9999")),NA,bog_pore_week$D)               
suppressWarnings(bog_pore_week$D <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$D))==as.character(as.numeric("-9999"))),NA,bog_pore_week$D))
bog_pore_week$FEII <- ifelse((trimws(as.character(bog_pore_week$FEII))==trimws("-9999")),NA,bog_pore_week$FEII)               
suppressWarnings(bog_pore_week$FEII <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$FEII))==as.character(as.numeric("-9999"))),NA,bog_pore_week$FEII))
bog_pore_week$FEIII <- ifelse((trimws(as.character(bog_pore_week$FEIII))==trimws("-9999")),NA,bog_pore_week$FEIII)               
suppressWarnings(bog_pore_week$FEIII <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(bog_pore_week$FEIII))==as.character(as.numeric("-9999"))),NA,bog_pore_week$FEIII))


# Here is the structure of the input data frame:
str(bog_pore_week)                            
attach(bog_pore_week)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(PIEZOMETER)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC)
summary(O18)
summary(D)
summary(FEII)
summary(FEIII) 
# Get more details on character variables

summary(as.factor(bog_pore_week$LAB_ID)) 
summary(as.factor(bog_pore_week$PIEZOMETER))
detach(bog_pore_week)               


inUrl4  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/a2540ed6f622b41a308f14cd94c3cc32" 
infile4 <- tempfile()
try(download.file(inUrl4,infile4,method="curl"))
if (is.na(file.size(infile4))) download.file(inUrl4,infile4,method="auto")


lagg_pore_synop <-read.csv(infile4,header=F 
                           ,skip=1
                           ,sep=","  
                           , col.names=c(
                             "LAB_ID",     
                             "PIEZOMETER",     
                             "DateTime",     
                             "PH",     
                             "SPCOND",     
                             "CL",     
                             "SO4",     
                             "CA",     
                             "K",     
                             "MG",     
                             "Na",     
                             "AL",     
                             "FE",     
                             "MN",     
                             "SI",     
                             "SR",     
                             "SRP",     
                             "TN",     
                             "TP",     
                             "TOC",     
                             "O18",     
                             "D"    ), check.names=TRUE)

unlink(infile4)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(lagg_pore_synop$LAB_ID)!="factor") lagg_pore_synop$LAB_ID<- as.factor(lagg_pore_synop$LAB_ID)
if (class(lagg_pore_synop$PIEZOMETER)!="factor") lagg_pore_synop$PIEZOMETER<- as.factor(lagg_pore_synop$PIEZOMETER)                                   
# attempting to convert lagg_pore_synop$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp4DateTime<-as.POSIXct(lagg_pore_synop$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp4DateTime) == length(tmp4DateTime[!is.na(tmp4DateTime)])){lagg_pore_synop$DateTime <- tmp4DateTime } else {print("Date conversion failed for lagg_pore_synop$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp4DateTime) 
if (class(lagg_pore_synop$PH)=="factor") lagg_pore_synop$PH <-as.numeric(levels(lagg_pore_synop$PH))[as.integer(lagg_pore_synop$PH) ]               
if (class(lagg_pore_synop$PH)=="character") lagg_pore_synop$PH <-as.numeric(lagg_pore_synop$PH)
if (class(lagg_pore_synop$SPCOND)=="factor") lagg_pore_synop$SPCOND <-as.numeric(levels(lagg_pore_synop$SPCOND))[as.integer(lagg_pore_synop$SPCOND) ]               
if (class(lagg_pore_synop$SPCOND)=="character") lagg_pore_synop$SPCOND <-as.numeric(lagg_pore_synop$SPCOND)
if (class(lagg_pore_synop$CL)=="factor") lagg_pore_synop$CL <-as.numeric(levels(lagg_pore_synop$CL))[as.integer(lagg_pore_synop$CL) ]               
if (class(lagg_pore_synop$CL)=="character") lagg_pore_synop$CL <-as.numeric(lagg_pore_synop$CL)
if (class(lagg_pore_synop$SO4)=="factor") lagg_pore_synop$SO4 <-as.numeric(levels(lagg_pore_synop$SO4))[as.integer(lagg_pore_synop$SO4) ]               
if (class(lagg_pore_synop$SO4)=="character") lagg_pore_synop$SO4 <-as.numeric(lagg_pore_synop$SO4)
if (class(lagg_pore_synop$CA)=="factor") lagg_pore_synop$CA <-as.numeric(levels(lagg_pore_synop$CA))[as.integer(lagg_pore_synop$CA) ]               
if (class(lagg_pore_synop$CA)=="character") lagg_pore_synop$CA <-as.numeric(lagg_pore_synop$CA)
if (class(lagg_pore_synop$K)=="factor") lagg_pore_synop$K <-as.numeric(levels(lagg_pore_synop$K))[as.integer(lagg_pore_synop$K) ]               
if (class(lagg_pore_synop$K)=="character") lagg_pore_synop$K <-as.numeric(lagg_pore_synop$K)
if (class(lagg_pore_synop$MG)=="factor") lagg_pore_synop$MG <-as.numeric(levels(lagg_pore_synop$MG))[as.integer(lagg_pore_synop$MG) ]               
if (class(lagg_pore_synop$MG)=="character") lagg_pore_synop$MG <-as.numeric(lagg_pore_synop$MG)
if (class(lagg_pore_synop$Na)=="factor") lagg_pore_synop$Na <-as.numeric(levels(lagg_pore_synop$Na))[as.integer(lagg_pore_synop$Na) ]               
if (class(lagg_pore_synop$Na)=="character") lagg_pore_synop$Na <-as.numeric(lagg_pore_synop$Na)
if (class(lagg_pore_synop$AL)=="factor") lagg_pore_synop$AL <-as.numeric(levels(lagg_pore_synop$AL))[as.integer(lagg_pore_synop$AL) ]               
if (class(lagg_pore_synop$AL)=="character") lagg_pore_synop$AL <-as.numeric(lagg_pore_synop$AL)
if (class(lagg_pore_synop$FE)=="factor") lagg_pore_synop$FE <-as.numeric(levels(lagg_pore_synop$FE))[as.integer(lagg_pore_synop$FE) ]               
if (class(lagg_pore_synop$FE)=="character") lagg_pore_synop$FE <-as.numeric(lagg_pore_synop$FE)
if (class(lagg_pore_synop$MN)=="factor") lagg_pore_synop$MN <-as.numeric(levels(lagg_pore_synop$MN))[as.integer(lagg_pore_synop$MN) ]               
if (class(lagg_pore_synop$MN)=="character") lagg_pore_synop$MN <-as.numeric(lagg_pore_synop$MN)
if (class(lagg_pore_synop$SI)=="factor") lagg_pore_synop$SI <-as.numeric(levels(lagg_pore_synop$SI))[as.integer(lagg_pore_synop$SI) ]               
if (class(lagg_pore_synop$SI)=="character") lagg_pore_synop$SI <-as.numeric(lagg_pore_synop$SI)
if (class(lagg_pore_synop$SR)=="factor") lagg_pore_synop$SR <-as.numeric(levels(lagg_pore_synop$SR))[as.integer(lagg_pore_synop$SR) ]               
if (class(lagg_pore_synop$SR)=="character") lagg_pore_synop$SR <-as.numeric(lagg_pore_synop$SR)
if (class(lagg_pore_synop$SRP)=="factor") lagg_pore_synop$SRP <-as.numeric(levels(lagg_pore_synop$SRP))[as.integer(lagg_pore_synop$SRP) ]               
if (class(lagg_pore_synop$SRP)=="character") lagg_pore_synop$SRP <-as.numeric(lagg_pore_synop$SRP)
if (class(lagg_pore_synop$TN)=="factor") lagg_pore_synop$TN <-as.numeric(levels(lagg_pore_synop$TN))[as.integer(lagg_pore_synop$TN) ]               
if (class(lagg_pore_synop$TN)=="character") lagg_pore_synop$TN <-as.numeric(lagg_pore_synop$TN)
if (class(lagg_pore_synop$TP)=="factor") lagg_pore_synop$TP <-as.numeric(levels(lagg_pore_synop$TP))[as.integer(lagg_pore_synop$TP) ]               
if (class(lagg_pore_synop$TP)=="character") lagg_pore_synop$TP <-as.numeric(lagg_pore_synop$TP)
if (class(lagg_pore_synop$TOC)=="factor") lagg_pore_synop$TOC <-as.numeric(levels(lagg_pore_synop$TOC))[as.integer(lagg_pore_synop$TOC) ]               
if (class(lagg_pore_synop$TOC)=="character") lagg_pore_synop$TOC <-as.numeric(lagg_pore_synop$TOC)
if (class(lagg_pore_synop$O18)=="factor") lagg_pore_synop$O18 <-as.numeric(levels(lagg_pore_synop$O18))[as.integer(lagg_pore_synop$O18) ]               
if (class(lagg_pore_synop$O18)=="character") lagg_pore_synop$O18 <-as.numeric(lagg_pore_synop$O18)
if (class(lagg_pore_synop$D)=="factor") lagg_pore_synop$D <-as.numeric(levels(lagg_pore_synop$D))[as.integer(lagg_pore_synop$D) ]               
if (class(lagg_pore_synop$D)=="character") lagg_pore_synop$D <-as.numeric(lagg_pore_synop$D)

# Convert Missing Values to NA for non-dates

lagg_pore_synop$PH <- ifelse((trimws(as.character(lagg_pore_synop$PH))==trimws("-9999")),NA,lagg_pore_synop$PH)               
suppressWarnings(lagg_pore_synop$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$PH))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$PH))
lagg_pore_synop$SPCOND <- ifelse((trimws(as.character(lagg_pore_synop$SPCOND))==trimws("-9999")),NA,lagg_pore_synop$SPCOND)               
suppressWarnings(lagg_pore_synop$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$SPCOND))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$SPCOND))
lagg_pore_synop$CL <- ifelse((trimws(as.character(lagg_pore_synop$CL))==trimws("-9999")),NA,lagg_pore_synop$CL)               
suppressWarnings(lagg_pore_synop$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$CL))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$CL))
lagg_pore_synop$SO4 <- ifelse((trimws(as.character(lagg_pore_synop$SO4))==trimws("-9999")),NA,lagg_pore_synop$SO4)               
suppressWarnings(lagg_pore_synop$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$SO4))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$SO4))
lagg_pore_synop$CA <- ifelse((trimws(as.character(lagg_pore_synop$CA))==trimws("-9999")),NA,lagg_pore_synop$CA)               
suppressWarnings(lagg_pore_synop$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$CA))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$CA))
lagg_pore_synop$K <- ifelse((trimws(as.character(lagg_pore_synop$K))==trimws("-9999")),NA,lagg_pore_synop$K)               
suppressWarnings(lagg_pore_synop$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$K))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$K))
lagg_pore_synop$MG <- ifelse((trimws(as.character(lagg_pore_synop$MG))==trimws("-9999")),NA,lagg_pore_synop$MG)               
suppressWarnings(lagg_pore_synop$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$MG))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$MG))
lagg_pore_synop$Na <- ifelse((trimws(as.character(lagg_pore_synop$Na))==trimws("-9999")),NA,lagg_pore_synop$Na)               
suppressWarnings(lagg_pore_synop$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$Na))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$Na))
lagg_pore_synop$AL <- ifelse((trimws(as.character(lagg_pore_synop$AL))==trimws("-9999")),NA,lagg_pore_synop$AL)               
suppressWarnings(lagg_pore_synop$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$AL))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$AL))
lagg_pore_synop$FE <- ifelse((trimws(as.character(lagg_pore_synop$FE))==trimws("-9999")),NA,lagg_pore_synop$FE)               
suppressWarnings(lagg_pore_synop$FE <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$FE))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$FE))
lagg_pore_synop$MN <- ifelse((trimws(as.character(lagg_pore_synop$MN))==trimws("-9999")),NA,lagg_pore_synop$MN)               
suppressWarnings(lagg_pore_synop$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$MN))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$MN))
lagg_pore_synop$SI <- ifelse((trimws(as.character(lagg_pore_synop$SI))==trimws("-9999")),NA,lagg_pore_synop$SI)               
suppressWarnings(lagg_pore_synop$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$SI))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$SI))
lagg_pore_synop$SR <- ifelse((trimws(as.character(lagg_pore_synop$SR))==trimws("-9999")),NA,lagg_pore_synop$SR)               
suppressWarnings(lagg_pore_synop$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$SR))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$SR))
lagg_pore_synop$SRP <- ifelse((trimws(as.character(lagg_pore_synop$SRP))==trimws("-9999")),NA,lagg_pore_synop$SRP)               
suppressWarnings(lagg_pore_synop$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$SRP))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$SRP))
lagg_pore_synop$TN <- ifelse((trimws(as.character(lagg_pore_synop$TN))==trimws("-9999")),NA,lagg_pore_synop$TN)               
suppressWarnings(lagg_pore_synop$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$TN))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$TN))
lagg_pore_synop$TP <- ifelse((trimws(as.character(lagg_pore_synop$TP))==trimws("-9999")),NA,lagg_pore_synop$TP)               
suppressWarnings(lagg_pore_synop$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$TP))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$TP))
lagg_pore_synop$TOC <- ifelse((trimws(as.character(lagg_pore_synop$TOC))==trimws("-9999")),NA,lagg_pore_synop$TOC)               
suppressWarnings(lagg_pore_synop$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$TOC))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$TOC))
lagg_pore_synop$O18 <- ifelse((trimws(as.character(lagg_pore_synop$O18))==trimws("-9999")),NA,lagg_pore_synop$O18)               
suppressWarnings(lagg_pore_synop$O18 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$O18))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$O18))
lagg_pore_synop$D <- ifelse((trimws(as.character(lagg_pore_synop$D))==trimws("-9999")),NA,lagg_pore_synop$D)               
suppressWarnings(lagg_pore_synop$D <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_synop$D))==as.character(as.numeric("-9999"))),NA,lagg_pore_synop$D))


# Here is the structure of the input data frame:
str(lagg_pore_synop)                            
attach(lagg_pore_synop)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(PIEZOMETER)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC)
summary(O18)
summary(D) 
# Get more details on character variables

summary(as.factor(lagg_pore_synop$LAB_ID)) 
summary(as.factor(lagg_pore_synop$PIEZOMETER))
detach(lagg_pore_synop)               


inUrl5  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/c53ed302cae125ef38f4e0e71adf9b29" 
infile5 <- tempfile()
try(download.file(inUrl5,infile5,method="curl"))
if (is.na(file.size(infile5))) download.file(inUrl5,infile5,method="auto")


lagg_pore_week <-read.csv(infile5,header=F 
                          ,skip=1
                          ,sep=","  
                          , col.names=c(
                            "LAB_ID",     
                            "PIEZOMETER",     
                            "DateTime",     
                            "PH",     
                            "SPCOND",     
                            "CL",     
                            "SO4",     
                            "CA",     
                            "K",     
                            "MG",     
                            "Na",     
                            "AL",     
                            "FE",     
                            "MN",     
                            "SI",     
                            "SR",     
                            "NH4",     
                            "NO3",     
                            "SRP",     
                            "TN",     
                            "TP",     
                            "TOC",     
                            "O18",     
                            "D",     
                            "FEII",     
                            "FEIII"    ), check.names=TRUE)

unlink(infile5)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(lagg_pore_week$LAB_ID)!="factor") lagg_pore_week$LAB_ID<- as.factor(lagg_pore_week$LAB_ID)
if (class(lagg_pore_week$PIEZOMETER)!="factor") lagg_pore_week$PIEZOMETER<- as.factor(lagg_pore_week$PIEZOMETER)                                   
# attempting to convert lagg_pore_week$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp5DateTime<-as.POSIXct(lagg_pore_week$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp5DateTime) == length(tmp5DateTime[!is.na(tmp5DateTime)])){lagg_pore_week$DateTime <- tmp5DateTime } else {print("Date conversion failed for lagg_pore_week$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp5DateTime) 
if (class(lagg_pore_week$PH)=="factor") lagg_pore_week$PH <-as.numeric(levels(lagg_pore_week$PH))[as.integer(lagg_pore_week$PH) ]               
if (class(lagg_pore_week$PH)=="character") lagg_pore_week$PH <-as.numeric(lagg_pore_week$PH)
if (class(lagg_pore_week$SPCOND)=="factor") lagg_pore_week$SPCOND <-as.numeric(levels(lagg_pore_week$SPCOND))[as.integer(lagg_pore_week$SPCOND) ]               
if (class(lagg_pore_week$SPCOND)=="character") lagg_pore_week$SPCOND <-as.numeric(lagg_pore_week$SPCOND)
if (class(lagg_pore_week$CL)=="factor") lagg_pore_week$CL <-as.numeric(levels(lagg_pore_week$CL))[as.integer(lagg_pore_week$CL) ]               
if (class(lagg_pore_week$CL)=="character") lagg_pore_week$CL <-as.numeric(lagg_pore_week$CL)
if (class(lagg_pore_week$SO4)=="factor") lagg_pore_week$SO4 <-as.numeric(levels(lagg_pore_week$SO4))[as.integer(lagg_pore_week$SO4) ]               
if (class(lagg_pore_week$SO4)=="character") lagg_pore_week$SO4 <-as.numeric(lagg_pore_week$SO4)
if (class(lagg_pore_week$CA)=="factor") lagg_pore_week$CA <-as.numeric(levels(lagg_pore_week$CA))[as.integer(lagg_pore_week$CA) ]               
if (class(lagg_pore_week$CA)=="character") lagg_pore_week$CA <-as.numeric(lagg_pore_week$CA)
if (class(lagg_pore_week$K)=="factor") lagg_pore_week$K <-as.numeric(levels(lagg_pore_week$K))[as.integer(lagg_pore_week$K) ]               
if (class(lagg_pore_week$K)=="character") lagg_pore_week$K <-as.numeric(lagg_pore_week$K)
if (class(lagg_pore_week$MG)=="factor") lagg_pore_week$MG <-as.numeric(levels(lagg_pore_week$MG))[as.integer(lagg_pore_week$MG) ]               
if (class(lagg_pore_week$MG)=="character") lagg_pore_week$MG <-as.numeric(lagg_pore_week$MG)
if (class(lagg_pore_week$Na)=="factor") lagg_pore_week$Na <-as.numeric(levels(lagg_pore_week$Na))[as.integer(lagg_pore_week$Na) ]               
if (class(lagg_pore_week$Na)=="character") lagg_pore_week$Na <-as.numeric(lagg_pore_week$Na)
if (class(lagg_pore_week$AL)=="factor") lagg_pore_week$AL <-as.numeric(levels(lagg_pore_week$AL))[as.integer(lagg_pore_week$AL) ]               
if (class(lagg_pore_week$AL)=="character") lagg_pore_week$AL <-as.numeric(lagg_pore_week$AL)
if (class(lagg_pore_week$FE)=="factor") lagg_pore_week$FE <-as.numeric(levels(lagg_pore_week$FE))[as.integer(lagg_pore_week$FE) ]               
if (class(lagg_pore_week$FE)=="character") lagg_pore_week$FE <-as.numeric(lagg_pore_week$FE)
if (class(lagg_pore_week$MN)=="factor") lagg_pore_week$MN <-as.numeric(levels(lagg_pore_week$MN))[as.integer(lagg_pore_week$MN) ]               
if (class(lagg_pore_week$MN)=="character") lagg_pore_week$MN <-as.numeric(lagg_pore_week$MN)
if (class(lagg_pore_week$SI)=="factor") lagg_pore_week$SI <-as.numeric(levels(lagg_pore_week$SI))[as.integer(lagg_pore_week$SI) ]               
if (class(lagg_pore_week$SI)=="character") lagg_pore_week$SI <-as.numeric(lagg_pore_week$SI)
if (class(lagg_pore_week$SR)=="factor") lagg_pore_week$SR <-as.numeric(levels(lagg_pore_week$SR))[as.integer(lagg_pore_week$SR) ]               
if (class(lagg_pore_week$SR)=="character") lagg_pore_week$SR <-as.numeric(lagg_pore_week$SR)
if (class(lagg_pore_week$NH4)=="factor") lagg_pore_week$NH4 <-as.numeric(levels(lagg_pore_week$NH4))[as.integer(lagg_pore_week$NH4) ]               
if (class(lagg_pore_week$NH4)=="character") lagg_pore_week$NH4 <-as.numeric(lagg_pore_week$NH4)
if (class(lagg_pore_week$NO3)=="factor") lagg_pore_week$NO3 <-as.numeric(levels(lagg_pore_week$NO3))[as.integer(lagg_pore_week$NO3) ]               
if (class(lagg_pore_week$NO3)=="character") lagg_pore_week$NO3 <-as.numeric(lagg_pore_week$NO3)
if (class(lagg_pore_week$SRP)=="factor") lagg_pore_week$SRP <-as.numeric(levels(lagg_pore_week$SRP))[as.integer(lagg_pore_week$SRP) ]               
if (class(lagg_pore_week$SRP)=="character") lagg_pore_week$SRP <-as.numeric(lagg_pore_week$SRP)
if (class(lagg_pore_week$TN)=="factor") lagg_pore_week$TN <-as.numeric(levels(lagg_pore_week$TN))[as.integer(lagg_pore_week$TN) ]               
if (class(lagg_pore_week$TN)=="character") lagg_pore_week$TN <-as.numeric(lagg_pore_week$TN)
if (class(lagg_pore_week$TP)=="factor") lagg_pore_week$TP <-as.numeric(levels(lagg_pore_week$TP))[as.integer(lagg_pore_week$TP) ]               
if (class(lagg_pore_week$TP)=="character") lagg_pore_week$TP <-as.numeric(lagg_pore_week$TP)
if (class(lagg_pore_week$TOC)=="factor") lagg_pore_week$TOC <-as.numeric(levels(lagg_pore_week$TOC))[as.integer(lagg_pore_week$TOC) ]               
if (class(lagg_pore_week$TOC)=="character") lagg_pore_week$TOC <-as.numeric(lagg_pore_week$TOC)
if (class(lagg_pore_week$O18)=="factor") lagg_pore_week$O18 <-as.numeric(levels(lagg_pore_week$O18))[as.integer(lagg_pore_week$O18) ]               
if (class(lagg_pore_week$O18)=="character") lagg_pore_week$O18 <-as.numeric(lagg_pore_week$O18)
if (class(lagg_pore_week$D)=="factor") lagg_pore_week$D <-as.numeric(levels(lagg_pore_week$D))[as.integer(lagg_pore_week$D) ]               
if (class(lagg_pore_week$D)=="character") lagg_pore_week$D <-as.numeric(lagg_pore_week$D)
if (class(lagg_pore_week$FEII)=="factor") lagg_pore_week$FEII <-as.numeric(levels(lagg_pore_week$FEII))[as.integer(lagg_pore_week$FEII) ]               
if (class(lagg_pore_week$FEII)=="character") lagg_pore_week$FEII <-as.numeric(lagg_pore_week$FEII)
if (class(lagg_pore_week$FEIII)=="factor") lagg_pore_week$FEIII <-as.numeric(levels(lagg_pore_week$FEIII))[as.integer(lagg_pore_week$FEIII) ]               
if (class(lagg_pore_week$FEIII)=="character") lagg_pore_week$FEIII <-as.numeric(lagg_pore_week$FEIII)

# Convert Missing Values to NA for non-dates

lagg_pore_week$PH <- ifelse((trimws(as.character(lagg_pore_week$PH))==trimws("-9999")),NA,lagg_pore_week$PH)               
suppressWarnings(lagg_pore_week$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$PH))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$PH))
lagg_pore_week$SPCOND <- ifelse((trimws(as.character(lagg_pore_week$SPCOND))==trimws("-9999")),NA,lagg_pore_week$SPCOND)               
suppressWarnings(lagg_pore_week$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$SPCOND))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$SPCOND))
lagg_pore_week$CL <- ifelse((trimws(as.character(lagg_pore_week$CL))==trimws("-9999")),NA,lagg_pore_week$CL)               
suppressWarnings(lagg_pore_week$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$CL))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$CL))
lagg_pore_week$SO4 <- ifelse((trimws(as.character(lagg_pore_week$SO4))==trimws("-9999")),NA,lagg_pore_week$SO4)               
suppressWarnings(lagg_pore_week$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$SO4))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$SO4))
lagg_pore_week$CA <- ifelse((trimws(as.character(lagg_pore_week$CA))==trimws("-9999")),NA,lagg_pore_week$CA)               
suppressWarnings(lagg_pore_week$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$CA))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$CA))
lagg_pore_week$K <- ifelse((trimws(as.character(lagg_pore_week$K))==trimws("-9999")),NA,lagg_pore_week$K)               
suppressWarnings(lagg_pore_week$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$K))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$K))
lagg_pore_week$MG <- ifelse((trimws(as.character(lagg_pore_week$MG))==trimws("-9999")),NA,lagg_pore_week$MG)               
suppressWarnings(lagg_pore_week$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$MG))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$MG))
lagg_pore_week$Na <- ifelse((trimws(as.character(lagg_pore_week$Na))==trimws("-9999")),NA,lagg_pore_week$Na)               
suppressWarnings(lagg_pore_week$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$Na))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$Na))
lagg_pore_week$AL <- ifelse((trimws(as.character(lagg_pore_week$AL))==trimws("-9999")),NA,lagg_pore_week$AL)               
suppressWarnings(lagg_pore_week$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$AL))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$AL))
lagg_pore_week$FE <- ifelse((trimws(as.character(lagg_pore_week$FE))==trimws("-9999")),NA,lagg_pore_week$FE)               
suppressWarnings(lagg_pore_week$FE <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$FE))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$FE))
lagg_pore_week$MN <- ifelse((trimws(as.character(lagg_pore_week$MN))==trimws("-9999")),NA,lagg_pore_week$MN)               
suppressWarnings(lagg_pore_week$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$MN))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$MN))
lagg_pore_week$SI <- ifelse((trimws(as.character(lagg_pore_week$SI))==trimws("-9999")),NA,lagg_pore_week$SI)               
suppressWarnings(lagg_pore_week$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$SI))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$SI))
lagg_pore_week$SR <- ifelse((trimws(as.character(lagg_pore_week$SR))==trimws("-9999")),NA,lagg_pore_week$SR)               
suppressWarnings(lagg_pore_week$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$SR))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$SR))
lagg_pore_week$NH4 <- ifelse((trimws(as.character(lagg_pore_week$NH4))==trimws("-9999")),NA,lagg_pore_week$NH4)               
suppressWarnings(lagg_pore_week$NH4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$NH4))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$NH4))
lagg_pore_week$NO3 <- ifelse((trimws(as.character(lagg_pore_week$NO3))==trimws("-9999")),NA,lagg_pore_week$NO3)               
suppressWarnings(lagg_pore_week$NO3 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$NO3))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$NO3))
lagg_pore_week$SRP <- ifelse((trimws(as.character(lagg_pore_week$SRP))==trimws("-9999")),NA,lagg_pore_week$SRP)               
suppressWarnings(lagg_pore_week$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$SRP))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$SRP))
lagg_pore_week$TN <- ifelse((trimws(as.character(lagg_pore_week$TN))==trimws("-9999")),NA,lagg_pore_week$TN)               
suppressWarnings(lagg_pore_week$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$TN))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$TN))
lagg_pore_week$TP <- ifelse((trimws(as.character(lagg_pore_week$TP))==trimws("-9999")),NA,lagg_pore_week$TP)               
suppressWarnings(lagg_pore_week$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$TP))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$TP))
lagg_pore_week$TOC <- ifelse((trimws(as.character(lagg_pore_week$TOC))==trimws("-9999")),NA,lagg_pore_week$TOC)               
suppressWarnings(lagg_pore_week$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$TOC))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$TOC))
lagg_pore_week$O18 <- ifelse((trimws(as.character(lagg_pore_week$O18))==trimws("-9999")),NA,lagg_pore_week$O18)               
suppressWarnings(lagg_pore_week$O18 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$O18))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$O18))
lagg_pore_week$D <- ifelse((trimws(as.character(lagg_pore_week$D))==trimws("-9999")),NA,lagg_pore_week$D)               
suppressWarnings(lagg_pore_week$D <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$D))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$D))
lagg_pore_week$FEII <- ifelse((trimws(as.character(lagg_pore_week$FEII))==trimws("-9999")),NA,lagg_pore_week$FEII)               
suppressWarnings(lagg_pore_week$FEII <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$FEII))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$FEII))
lagg_pore_week$FEIII <- ifelse((trimws(as.character(lagg_pore_week$FEIII))==trimws("-9999")),NA,lagg_pore_week$FEIII)               
suppressWarnings(lagg_pore_week$FEIII <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(lagg_pore_week$FEIII))==as.character(as.numeric("-9999"))),NA,lagg_pore_week$FEIII))


# Here is the structure of the input data frame:
str(lagg_pore_week)                            
attach(lagg_pore_week)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(PIEZOMETER)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC)
summary(O18)
summary(D)
summary(FEII)
summary(FEIII) 
# Get more details on character variables

summary(as.factor(lagg_pore_week$LAB_ID)) 
summary(as.factor(lagg_pore_week$PIEZOMETER))
detach(lagg_pore_week)               


inUrl6  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/90fe9126cc7c9922d5a4f1b771cc8e0c" 
infile6 <- tempfile()
try(download.file(inUrl6,infile6,method="curl"))
if (is.na(file.size(infile6))) download.file(inUrl6,infile6,method="auto")

#precipitation

# Package ID: edi.609.1 Cataloging System:https://pasta.edirepository.org.
# Data set title: Marcell Experimental Forest event based precipitation chemistry, 2008 - ongoing.
# Data set creator:  Stephen Sebestyen - USDA Forest Service, Northern Research Station 
# Data set creator:  Keith Oleheiser - XCEL Engineering 
# Data set creator:  John Larson - USDA Forest Service, Northern Research Station 
# Data set creator:  Nathan Aspelin - USDA Forest Service, Northern Research Station 
# Data set creator:  Jonathan Stelling - University of Minnesota 
# Data set creator:  Natalie Griffiths - Oak Ridge National Laboratory 
# Data set creator:  Nina Lany - USDA Forest Service, Northern Research Station 
# Contact:    -  Data Manager, Marcell Experimental Forest  - nina.lany@usda.gov
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/609/1/759dac4390593331bf1335a94b15af60" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


event_precip <-read.csv(infile1,header=F 
                        ,skip=1
                        ,sep=","  
                        , col.names=c(
                          "LAB_ID",     
                          "Location",     
                          "DateTime",     
                          "pH",     
                          "SpCond",     
                          "Cl",     
                          "SO4",     
                          "Ca",     
                          "Mg",     
                          "NH4",     
                          "NO3",     
                          "SRP",     
                          "TN",     
                          "TOC",     
                          "d18O",     
                          "d2H"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(event_precip$LAB_ID)!="factor") event_precip$LAB_ID<- as.factor(event_precip$LAB_ID)
if (class(event_precip$Location)!="factor") event_precip$Location<- as.factor(event_precip$Location)                                   
# attempting to convert event_precip$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1DateTime<-as.POSIXct(event_precip$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DateTime) == length(tmp1DateTime[!is.na(tmp1DateTime)])){event_precip$DateTime <- tmp1DateTime } else {print("Date conversion failed for event_precip$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1DateTime) 
if (class(event_precip$pH)=="factor") event_precip$pH <-as.numeric(levels(event_precip$pH))[as.integer(event_precip$pH) ]               
if (class(event_precip$pH)=="character") event_precip$pH <-as.numeric(event_precip$pH)
if (class(event_precip$SpCond)=="factor") event_precip$SpCond <-as.numeric(levels(event_precip$SpCond))[as.integer(event_precip$SpCond) ]               
if (class(event_precip$SpCond)=="character") event_precip$SpCond <-as.numeric(event_precip$SpCond)
if (class(event_precip$Cl)=="factor") event_precip$Cl <-as.numeric(levels(event_precip$Cl))[as.integer(event_precip$Cl) ]               
if (class(event_precip$Cl)=="character") event_precip$Cl <-as.numeric(event_precip$Cl)
if (class(event_precip$SO4)=="factor") event_precip$SO4 <-as.numeric(levels(event_precip$SO4))[as.integer(event_precip$SO4) ]               
if (class(event_precip$SO4)=="character") event_precip$SO4 <-as.numeric(event_precip$SO4)
if (class(event_precip$Ca)=="factor") event_precip$Ca <-as.numeric(levels(event_precip$Ca))[as.integer(event_precip$Ca) ]               
if (class(event_precip$Ca)=="character") event_precip$Ca <-as.numeric(event_precip$Ca)
if (class(event_precip$Mg)=="factor") event_precip$Mg <-as.numeric(levels(event_precip$Mg))[as.integer(event_precip$Mg) ]               
if (class(event_precip$Mg)=="character") event_precip$Mg <-as.numeric(event_precip$Mg)
if (class(event_precip$NH4)=="factor") event_precip$NH4 <-as.numeric(levels(event_precip$NH4))[as.integer(event_precip$NH4) ]               
if (class(event_precip$NH4)=="character") event_precip$NH4 <-as.numeric(event_precip$NH4)
if (class(event_precip$NO3)=="factor") event_precip$NO3 <-as.numeric(levels(event_precip$NO3))[as.integer(event_precip$NO3) ]               
if (class(event_precip$NO3)=="character") event_precip$NO3 <-as.numeric(event_precip$NO3)
if (class(event_precip$SRP)=="factor") event_precip$SRP <-as.numeric(levels(event_precip$SRP))[as.integer(event_precip$SRP) ]               
if (class(event_precip$SRP)=="character") event_precip$SRP <-as.numeric(event_precip$SRP)
if (class(event_precip$TN)=="factor") event_precip$TN <-as.numeric(levels(event_precip$TN))[as.integer(event_precip$TN) ]               
if (class(event_precip$TN)=="character") event_precip$TN <-as.numeric(event_precip$TN)
if (class(event_precip$TOC)=="factor") event_precip$TOC <-as.numeric(levels(event_precip$TOC))[as.integer(event_precip$TOC) ]               
if (class(event_precip$TOC)=="character") event_precip$TOC <-as.numeric(event_precip$TOC)
if (class(event_precip$d18O)=="factor") event_precip$d18O <-as.numeric(levels(event_precip$d18O))[as.integer(event_precip$d18O) ]               
if (class(event_precip$d18O)=="character") event_precip$d18O <-as.numeric(event_precip$d18O)
if (class(event_precip$d2H)=="factor") event_precip$d2H <-as.numeric(levels(event_precip$d2H))[as.integer(event_precip$d2H) ]               
if (class(event_precip$d2H)=="character") event_precip$d2H <-as.numeric(event_precip$d2H)

# Convert Missing Values to NA for non-dates

event_precip$pH <- ifelse((trimws(as.character(event_precip$pH))==trimws("-9999")),NA,event_precip$pH)               
suppressWarnings(event_precip$pH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$pH))==as.character(as.numeric("-9999"))),NA,event_precip$pH))
event_precip$SpCond <- ifelse((trimws(as.character(event_precip$SpCond))==trimws("-9999")),NA,event_precip$SpCond)               
suppressWarnings(event_precip$SpCond <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$SpCond))==as.character(as.numeric("-9999"))),NA,event_precip$SpCond))
event_precip$Cl <- ifelse((trimws(as.character(event_precip$Cl))==trimws("-9999")),NA,event_precip$Cl)               
suppressWarnings(event_precip$Cl <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$Cl))==as.character(as.numeric("-9999"))),NA,event_precip$Cl))
event_precip$SO4 <- ifelse((trimws(as.character(event_precip$SO4))==trimws("-9999")),NA,event_precip$SO4)               
suppressWarnings(event_precip$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$SO4))==as.character(as.numeric("-9999"))),NA,event_precip$SO4))
event_precip$Ca <- ifelse((trimws(as.character(event_precip$Ca))==trimws("-9999")),NA,event_precip$Ca)               
suppressWarnings(event_precip$Ca <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$Ca))==as.character(as.numeric("-9999"))),NA,event_precip$Ca))
event_precip$Mg <- ifelse((trimws(as.character(event_precip$Mg))==trimws("-9999")),NA,event_precip$Mg)               
suppressWarnings(event_precip$Mg <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$Mg))==as.character(as.numeric("-9999"))),NA,event_precip$Mg))
event_precip$NH4 <- ifelse((trimws(as.character(event_precip$NH4))==trimws("-9999")),NA,event_precip$NH4)               
suppressWarnings(event_precip$NH4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$NH4))==as.character(as.numeric("-9999"))),NA,event_precip$NH4))
event_precip$NO3 <- ifelse((trimws(as.character(event_precip$NO3))==trimws("-9999")),NA,event_precip$NO3)               
suppressWarnings(event_precip$NO3 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$NO3))==as.character(as.numeric("-9999"))),NA,event_precip$NO3))
event_precip$SRP <- ifelse((trimws(as.character(event_precip$SRP))==trimws("-9999")),NA,event_precip$SRP)               
suppressWarnings(event_precip$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$SRP))==as.character(as.numeric("-9999"))),NA,event_precip$SRP))
event_precip$TN <- ifelse((trimws(as.character(event_precip$TN))==trimws("-9999")),NA,event_precip$TN)               
suppressWarnings(event_precip$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$TN))==as.character(as.numeric("-9999"))),NA,event_precip$TN))
event_precip$TOC <- ifelse((trimws(as.character(event_precip$TOC))==trimws("-9999")),NA,event_precip$TOC)               
suppressWarnings(event_precip$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$TOC))==as.character(as.numeric("-9999"))),NA,event_precip$TOC))
event_precip$d18O <- ifelse((trimws(as.character(event_precip$d18O))==trimws("-9999")),NA,event_precip$d18O)               
suppressWarnings(event_precip$d18O <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$d18O))==as.character(as.numeric("-9999"))),NA,event_precip$d18O))
event_precip$d2H <- ifelse((trimws(as.character(event_precip$d2H))==trimws("-9999")),NA,event_precip$d2H)               
suppressWarnings(event_precip$d2H <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(event_precip$d2H))==as.character(as.numeric("-9999"))),NA,event_precip$d2H))


# Here is the structure of the input data frame:
str(event_precip)                            
attach(event_precip)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(Location)
summary(DateTime)
summary(pH)
summary(SpCond)
summary(Cl)
summary(SO4)
summary(Ca)
summary(Mg)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TOC)
summary(d18O)
summary(d2H) 
# Get more details on character variables

summary(as.factor(event_precip$LAB_ID)) 
summary(as.factor(event_precip$Location))
detach(event_precip)             


############################################################## ground water############################################################## 
############################################################## ############################################################## 
# Package ID: edi.711.1 Cataloging System:https://pasta.edirepository.org.
# Data set title: Marcell Experimental Forest monthly aquifer groundwater chemistry at the S2 catchment, 2007 - ongoing.
# Data set creator:  Stephen Sebestyen - USDA Forest Service, Northern Research Station 
# Data set creator:  Richard Kyllander - USDA Forest Service, Northern Research Station 
# Data set creator:  John Larson - USDA Forest Service, Northern Research Station 
# Data set creator:  Nathan Aspelin - USDA Forest Service, Northern Research Station 
# Data set creator:  Keith Oleheiser - XCEL Engineering 
# Data set creator:  Doris Nelson - USDA Forest Service, Northern Research Station 
# Data set creator:  Jonathan Stelling - University of Minnesota 
# Data set creator:  Nina Lany - USDA Forest Service, Northern Research Station 
# Data set creator:  Randall Kolka - USDA Forest Service, Northern Research Station 
# Contact:    -  Data Manager, Marcell Experimental Forest  - nina.lany@usda.gov
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/711/1/646af91a1a2a2a503af868ed50b4bdd8" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


gw_month <-read.csv(infile1,header=F 
                    ,skip=1
                    ,sep=","  
                    , col.names=c(
                      "LAB_ID",     
                      "NAME",     
                      "DateTime",     
                      "PH",     
                      "SPCOND",     
                      "CL",     
                      "SO4",     
                      "CA",     
                      "K",     
                      "MG",     
                      "Na",     
                      "AL",     
                      "MN",     
                      "SI",     
                      "SR",     
                      "NH4",     
                      "NO3",     
                      "SRP",     
                      "TN",     
                      "TP",     
                      "TOC",     
                      "O18",     
                      "D"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(gw_month$LAB_ID)!="factor") gw_month$LAB_ID<- as.factor(gw_month$LAB_ID)
if (class(gw_month$NAME)!="factor") gw_month$NAME<- as.factor(gw_month$NAME)                                   
# attempting to convert gw_month$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1DateTime<-as.POSIXct(gw_month$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DateTime) == length(tmp1DateTime[!is.na(tmp1DateTime)])){gw_month$DateTime <- tmp1DateTime } else {print("Date conversion failed for gw_month$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1DateTime) 
if (class(gw_month$PH)=="factor") gw_month$PH <-as.numeric(levels(gw_month$PH))[as.integer(gw_month$PH) ]               
if (class(gw_month$PH)=="character") gw_month$PH <-as.numeric(gw_month$PH)
if (class(gw_month$SPCOND)=="factor") gw_month$SPCOND <-as.numeric(levels(gw_month$SPCOND))[as.integer(gw_month$SPCOND) ]               
if (class(gw_month$SPCOND)=="character") gw_month$SPCOND <-as.numeric(gw_month$SPCOND)
if (class(gw_month$CL)=="factor") gw_month$CL <-as.numeric(levels(gw_month$CL))[as.integer(gw_month$CL) ]               
if (class(gw_month$CL)=="character") gw_month$CL <-as.numeric(gw_month$CL)
if (class(gw_month$SO4)=="factor") gw_month$SO4 <-as.numeric(levels(gw_month$SO4))[as.integer(gw_month$SO4) ]               
if (class(gw_month$SO4)=="character") gw_month$SO4 <-as.numeric(gw_month$SO4)
if (class(gw_month$CA)=="factor") gw_month$CA <-as.numeric(levels(gw_month$CA))[as.integer(gw_month$CA) ]               
if (class(gw_month$CA)=="character") gw_month$CA <-as.numeric(gw_month$CA)
if (class(gw_month$K)=="factor") gw_month$K <-as.numeric(levels(gw_month$K))[as.integer(gw_month$K) ]               
if (class(gw_month$K)=="character") gw_month$K <-as.numeric(gw_month$K)
if (class(gw_month$MG)=="factor") gw_month$MG <-as.numeric(levels(gw_month$MG))[as.integer(gw_month$MG) ]               
if (class(gw_month$MG)=="character") gw_month$MG <-as.numeric(gw_month$MG)
if (class(gw_month$Na)=="factor") gw_month$Na <-as.numeric(levels(gw_month$Na))[as.integer(gw_month$Na) ]               
if (class(gw_month$Na)=="character") gw_month$Na <-as.numeric(gw_month$Na)
if (class(gw_month$AL)=="factor") gw_month$AL <-as.numeric(levels(gw_month$AL))[as.integer(gw_month$AL) ]               
if (class(gw_month$AL)=="character") gw_month$AL <-as.numeric(gw_month$AL)
if (class(gw_month$MN)=="factor") gw_month$MN <-as.numeric(levels(gw_month$MN))[as.integer(gw_month$MN) ]               
if (class(gw_month$MN)=="character") gw_month$MN <-as.numeric(gw_month$MN)
if (class(gw_month$SI)=="factor") gw_month$SI <-as.numeric(levels(gw_month$SI))[as.integer(gw_month$SI) ]               
if (class(gw_month$SI)=="character") gw_month$SI <-as.numeric(gw_month$SI)
if (class(gw_month$SR)=="factor") gw_month$SR <-as.numeric(levels(gw_month$SR))[as.integer(gw_month$SR) ]               
if (class(gw_month$SR)=="character") gw_month$SR <-as.numeric(gw_month$SR)
if (class(gw_month$NH4)=="factor") gw_month$NH4 <-as.numeric(levels(gw_month$NH4))[as.integer(gw_month$NH4) ]               
if (class(gw_month$NH4)=="character") gw_month$NH4 <-as.numeric(gw_month$NH4)
if (class(gw_month$NO3)=="factor") gw_month$NO3 <-as.numeric(levels(gw_month$NO3))[as.integer(gw_month$NO3) ]               
if (class(gw_month$NO3)=="character") gw_month$NO3 <-as.numeric(gw_month$NO3)
if (class(gw_month$SRP)=="factor") gw_month$SRP <-as.numeric(levels(gw_month$SRP))[as.integer(gw_month$SRP) ]               
if (class(gw_month$SRP)=="character") gw_month$SRP <-as.numeric(gw_month$SRP)
if (class(gw_month$TN)=="factor") gw_month$TN <-as.numeric(levels(gw_month$TN))[as.integer(gw_month$TN) ]               
if (class(gw_month$TN)=="character") gw_month$TN <-as.numeric(gw_month$TN)
if (class(gw_month$TP)=="factor") gw_month$TP <-as.numeric(levels(gw_month$TP))[as.integer(gw_month$TP) ]               
if (class(gw_month$TP)=="character") gw_month$TP <-as.numeric(gw_month$TP)
if (class(gw_month$TOC)=="factor") gw_month$TOC <-as.numeric(levels(gw_month$TOC))[as.integer(gw_month$TOC) ]               
if (class(gw_month$TOC)=="character") gw_month$TOC <-as.numeric(gw_month$TOC)
if (class(gw_month$O18)=="factor") gw_month$O18 <-as.numeric(levels(gw_month$O18))[as.integer(gw_month$O18) ]               
if (class(gw_month$O18)=="character") gw_month$O18 <-as.numeric(gw_month$O18)
if (class(gw_month$D)=="factor") gw_month$D <-as.numeric(levels(gw_month$D))[as.integer(gw_month$D) ]               
if (class(gw_month$D)=="character") gw_month$D <-as.numeric(gw_month$D)

# Convert Missing Values to NA for non-dates

gw_month$PH <- ifelse((trimws(as.character(gw_month$PH))==trimws("-9999")),NA,gw_month$PH)               
suppressWarnings(gw_month$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$PH))==as.character(as.numeric("-9999"))),NA,gw_month$PH))
gw_month$SPCOND <- ifelse((trimws(as.character(gw_month$SPCOND))==trimws("-9999")),NA,gw_month$SPCOND)               
suppressWarnings(gw_month$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$SPCOND))==as.character(as.numeric("-9999"))),NA,gw_month$SPCOND))
gw_month$CL <- ifelse((trimws(as.character(gw_month$CL))==trimws("-9999")),NA,gw_month$CL)               
suppressWarnings(gw_month$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$CL))==as.character(as.numeric("-9999"))),NA,gw_month$CL))
gw_month$SO4 <- ifelse((trimws(as.character(gw_month$SO4))==trimws("-9999")),NA,gw_month$SO4)               
suppressWarnings(gw_month$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$SO4))==as.character(as.numeric("-9999"))),NA,gw_month$SO4))
gw_month$CA <- ifelse((trimws(as.character(gw_month$CA))==trimws("-9999")),NA,gw_month$CA)               
suppressWarnings(gw_month$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$CA))==as.character(as.numeric("-9999"))),NA,gw_month$CA))
gw_month$K <- ifelse((trimws(as.character(gw_month$K))==trimws("-9999")),NA,gw_month$K)               
suppressWarnings(gw_month$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$K))==as.character(as.numeric("-9999"))),NA,gw_month$K))
gw_month$MG <- ifelse((trimws(as.character(gw_month$MG))==trimws("-9999")),NA,gw_month$MG)               
suppressWarnings(gw_month$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$MG))==as.character(as.numeric("-9999"))),NA,gw_month$MG))
gw_month$Na <- ifelse((trimws(as.character(gw_month$Na))==trimws("-9999")),NA,gw_month$Na)               
suppressWarnings(gw_month$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$Na))==as.character(as.numeric("-9999"))),NA,gw_month$Na))
gw_month$AL <- ifelse((trimws(as.character(gw_month$AL))==trimws("-9999")),NA,gw_month$AL)               
suppressWarnings(gw_month$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$AL))==as.character(as.numeric("-9999"))),NA,gw_month$AL))
gw_month$MN <- ifelse((trimws(as.character(gw_month$MN))==trimws("-9999")),NA,gw_month$MN)               
suppressWarnings(gw_month$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$MN))==as.character(as.numeric("-9999"))),NA,gw_month$MN))
gw_month$SI <- ifelse((trimws(as.character(gw_month$SI))==trimws("-9999")),NA,gw_month$SI)               
suppressWarnings(gw_month$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$SI))==as.character(as.numeric("-9999"))),NA,gw_month$SI))
gw_month$SR <- ifelse((trimws(as.character(gw_month$SR))==trimws("-9999")),NA,gw_month$SR)               
suppressWarnings(gw_month$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$SR))==as.character(as.numeric("-9999"))),NA,gw_month$SR))
gw_month$NH4 <- ifelse((trimws(as.character(gw_month$NH4))==trimws("-9999")),NA,gw_month$NH4)               
suppressWarnings(gw_month$NH4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$NH4))==as.character(as.numeric("-9999"))),NA,gw_month$NH4))
gw_month$NO3 <- ifelse((trimws(as.character(gw_month$NO3))==trimws("-9999")),NA,gw_month$NO3)               
suppressWarnings(gw_month$NO3 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$NO3))==as.character(as.numeric("-9999"))),NA,gw_month$NO3))
gw_month$SRP <- ifelse((trimws(as.character(gw_month$SRP))==trimws("-9999")),NA,gw_month$SRP)               
suppressWarnings(gw_month$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$SRP))==as.character(as.numeric("-9999"))),NA,gw_month$SRP))
gw_month$TN <- ifelse((trimws(as.character(gw_month$TN))==trimws("-9999")),NA,gw_month$TN)               
suppressWarnings(gw_month$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$TN))==as.character(as.numeric("-9999"))),NA,gw_month$TN))
gw_month$TP <- ifelse((trimws(as.character(gw_month$TP))==trimws("-9999")),NA,gw_month$TP)               
suppressWarnings(gw_month$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$TP))==as.character(as.numeric("-9999"))),NA,gw_month$TP))
gw_month$TOC <- ifelse((trimws(as.character(gw_month$TOC))==trimws("-9999")),NA,gw_month$TOC)               
suppressWarnings(gw_month$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$TOC))==as.character(as.numeric("-9999"))),NA,gw_month$TOC))
gw_month$O18 <- ifelse((trimws(as.character(gw_month$O18))==trimws("-9999")),NA,gw_month$O18)               
suppressWarnings(gw_month$O18 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$O18))==as.character(as.numeric("-9999"))),NA,gw_month$O18))
gw_month$D <- ifelse((trimws(as.character(gw_month$D))==trimws("-9999")),NA,gw_month$D)               
suppressWarnings(gw_month$D <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(gw_month$D))==as.character(as.numeric("-9999"))),NA,gw_month$D))


# Here is the structure of the input data frame:
str(gw_month)                            
attach(gw_month)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(NAME)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC)
summary(O18)
summary(D) 
# Get more details on character variables

summary(as.factor(gw_month$LAB_ID)) 
summary(as.factor(gw_month$NAME))
detach(gw_month)  



##########################################################################
# Package ID: edi.712.2 Cataloging System:https://pasta.edirepository.org.
# Data set title: Marcell Experimental Forest porewater chemistry at the S2 catchment, 2009 - ongoing.
# Data set creator:  Stephen Sebestyen - USDA Forest Service, Northern Research Station 
# Data set creator:  Nina Lany - USDA Forest Service, Northern Research Station 
# Data set creator:  John Larson - USDA Forest Service, Northern Research Station 
# Data set creator:  Nathan Aspelin - USDA Forest Service, Northern Research Station 
# Data set creator:  Keith Oleheiser - XCEL Engineering 
# Data set creator:  Doris Nelson - USDA Forest Service, Northern Research Station 
# Data set creator:  Steven Hall - Iowa State University 
# Data set creator:  Holly Curtinrich - Iowa State University 
# Contact:    -  Data Manager, Marcell Experimental Forest  - nina.lany@usda.gov
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/712/2/6108c9dac7d837a4955f233eb4467ff2" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


dt1 <-read.csv(infile1,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "LAB_ID",     
                 "NAME",     
                 "PIEZOMETER",     
                 "DEPTH",     
                 "DateTime",     
                 "PH",     
                 "SPCOND",     
                 "CL",     
                 "SO4",     
                 "CA",     
                 "K",     
                 "MG",     
                 "Na",     
                 "AL",     
                 "FE",     
                 "MN",     
                 "SI",     
                 "SR",     
                 "NH4",     
                 "NO3",     
                 "SRP",     
                 "TN",     
                 "TP",     
                 "TOC"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

if (class(dt1$LAB_ID)!="factor") dt1$LAB_ID<- as.factor(dt1$LAB_ID)
if (class(dt1$NAME)!="factor") dt1$NAME<- as.factor(dt1$NAME)
if (class(dt1$PIEZOMETER)!="factor") dt1$PIEZOMETER<- as.factor(dt1$PIEZOMETER)
if (class(dt1$DEPTH)=="factor") dt1$DEPTH <-as.numeric(levels(dt1$DEPTH))[as.integer(dt1$DEPTH) ]               
if (class(dt1$DEPTH)=="character") dt1$DEPTH <-as.numeric(dt1$DEPTH)                                   
# attempting to convert dt1$DateTime dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
tmp1DateTime<-as.POSIXct(dt1$DateTime,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(length(tmp1DateTime) == length(tmp1DateTime[!is.na(tmp1DateTime)])){dt1$DateTime <- tmp1DateTime } else {print("Date conversion failed for dt1$DateTime. Please inspect the data and do the date conversion yourself.")}                                                                    
rm(tmpDateFormat,tmp1DateTime) 
if (class(dt1$PH)=="factor") dt1$PH <-as.numeric(levels(dt1$PH))[as.integer(dt1$PH) ]               
if (class(dt1$PH)=="character") dt1$PH <-as.numeric(dt1$PH)
if (class(dt1$SPCOND)=="factor") dt1$SPCOND <-as.numeric(levels(dt1$SPCOND))[as.integer(dt1$SPCOND) ]               
if (class(dt1$SPCOND)=="character") dt1$SPCOND <-as.numeric(dt1$SPCOND)
if (class(dt1$CL)=="factor") dt1$CL <-as.numeric(levels(dt1$CL))[as.integer(dt1$CL) ]               
if (class(dt1$CL)=="character") dt1$CL <-as.numeric(dt1$CL)
if (class(dt1$SO4)=="factor") dt1$SO4 <-as.numeric(levels(dt1$SO4))[as.integer(dt1$SO4) ]               
if (class(dt1$SO4)=="character") dt1$SO4 <-as.numeric(dt1$SO4)
if (class(dt1$CA)=="factor") dt1$CA <-as.numeric(levels(dt1$CA))[as.integer(dt1$CA) ]               
if (class(dt1$CA)=="character") dt1$CA <-as.numeric(dt1$CA)
if (class(dt1$K)=="factor") dt1$K <-as.numeric(levels(dt1$K))[as.integer(dt1$K) ]               
if (class(dt1$K)=="character") dt1$K <-as.numeric(dt1$K)
if (class(dt1$MG)=="factor") dt1$MG <-as.numeric(levels(dt1$MG))[as.integer(dt1$MG) ]               
if (class(dt1$MG)=="character") dt1$MG <-as.numeric(dt1$MG)
if (class(dt1$Na)=="factor") dt1$Na <-as.numeric(levels(dt1$Na))[as.integer(dt1$Na) ]               
if (class(dt1$Na)=="character") dt1$Na <-as.numeric(dt1$Na)
if (class(dt1$AL)=="factor") dt1$AL <-as.numeric(levels(dt1$AL))[as.integer(dt1$AL) ]               
if (class(dt1$AL)=="character") dt1$AL <-as.numeric(dt1$AL)
if (class(dt1$FE)=="factor") dt1$FE <-as.numeric(levels(dt1$FE))[as.integer(dt1$FE) ]               
if (class(dt1$FE)=="character") dt1$FE <-as.numeric(dt1$FE)
if (class(dt1$MN)=="factor") dt1$MN <-as.numeric(levels(dt1$MN))[as.integer(dt1$MN) ]               
if (class(dt1$MN)=="character") dt1$MN <-as.numeric(dt1$MN)
if (class(dt1$SI)=="factor") dt1$SI <-as.numeric(levels(dt1$SI))[as.integer(dt1$SI) ]               
if (class(dt1$SI)=="character") dt1$SI <-as.numeric(dt1$SI)
if (class(dt1$SR)=="factor") dt1$SR <-as.numeric(levels(dt1$SR))[as.integer(dt1$SR) ]               
if (class(dt1$SR)=="character") dt1$SR <-as.numeric(dt1$SR)
if (class(dt1$NH4)=="factor") dt1$NH4 <-as.numeric(levels(dt1$NH4))[as.integer(dt1$NH4) ]               
if (class(dt1$NH4)=="character") dt1$NH4 <-as.numeric(dt1$NH4)
if (class(dt1$NO3)=="factor") dt1$NO3 <-as.numeric(levels(dt1$NO3))[as.integer(dt1$NO3) ]               
if (class(dt1$NO3)=="character") dt1$NO3 <-as.numeric(dt1$NO3)
if (class(dt1$SRP)=="factor") dt1$SRP <-as.numeric(levels(dt1$SRP))[as.integer(dt1$SRP) ]               
if (class(dt1$SRP)=="character") dt1$SRP <-as.numeric(dt1$SRP)
if (class(dt1$TN)=="factor") dt1$TN <-as.numeric(levels(dt1$TN))[as.integer(dt1$TN) ]               
if (class(dt1$TN)=="character") dt1$TN <-as.numeric(dt1$TN)
if (class(dt1$TP)=="factor") dt1$TP <-as.numeric(levels(dt1$TP))[as.integer(dt1$TP) ]               
if (class(dt1$TP)=="character") dt1$TP <-as.numeric(dt1$TP)
if (class(dt1$TOC)=="factor") dt1$TOC <-as.numeric(levels(dt1$TOC))[as.integer(dt1$TOC) ]               
if (class(dt1$TOC)=="character") dt1$TOC <-as.numeric(dt1$TOC)

# Convert Missing Values to NA for non-dates

dt1$PH <- ifelse((trimws(as.character(dt1$PH))==trimws("-9999")),NA,dt1$PH)               
suppressWarnings(dt1$PH <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$PH))==as.character(as.numeric("-9999"))),NA,dt1$PH))
dt1$SPCOND <- ifelse((trimws(as.character(dt1$SPCOND))==trimws("-9999")),NA,dt1$SPCOND)               
suppressWarnings(dt1$SPCOND <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$SPCOND))==as.character(as.numeric("-9999"))),NA,dt1$SPCOND))
dt1$CL <- ifelse((trimws(as.character(dt1$CL))==trimws("-9999")),NA,dt1$CL)               
suppressWarnings(dt1$CL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$CL))==as.character(as.numeric("-9999"))),NA,dt1$CL))
dt1$SO4 <- ifelse((trimws(as.character(dt1$SO4))==trimws("-9999")),NA,dt1$SO4)               
suppressWarnings(dt1$SO4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$SO4))==as.character(as.numeric("-9999"))),NA,dt1$SO4))
dt1$CA <- ifelse((trimws(as.character(dt1$CA))==trimws("-9999")),NA,dt1$CA)               
suppressWarnings(dt1$CA <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$CA))==as.character(as.numeric("-9999"))),NA,dt1$CA))
dt1$K <- ifelse((trimws(as.character(dt1$K))==trimws("-9999")),NA,dt1$K)               
suppressWarnings(dt1$K <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$K))==as.character(as.numeric("-9999"))),NA,dt1$K))
dt1$MG <- ifelse((trimws(as.character(dt1$MG))==trimws("-9999")),NA,dt1$MG)               
suppressWarnings(dt1$MG <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$MG))==as.character(as.numeric("-9999"))),NA,dt1$MG))
dt1$Na <- ifelse((trimws(as.character(dt1$Na))==trimws("-9999")),NA,dt1$Na)               
suppressWarnings(dt1$Na <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$Na))==as.character(as.numeric("-9999"))),NA,dt1$Na))
dt1$AL <- ifelse((trimws(as.character(dt1$AL))==trimws("-9999")),NA,dt1$AL)               
suppressWarnings(dt1$AL <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$AL))==as.character(as.numeric("-9999"))),NA,dt1$AL))
dt1$FE <- ifelse((trimws(as.character(dt1$FE))==trimws("-9999")),NA,dt1$FE)               
suppressWarnings(dt1$FE <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$FE))==as.character(as.numeric("-9999"))),NA,dt1$FE))
dt1$MN <- ifelse((trimws(as.character(dt1$MN))==trimws("-9999")),NA,dt1$MN)               
suppressWarnings(dt1$MN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$MN))==as.character(as.numeric("-9999"))),NA,dt1$MN))
dt1$SI <- ifelse((trimws(as.character(dt1$SI))==trimws("-9999")),NA,dt1$SI)               
suppressWarnings(dt1$SI <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$SI))==as.character(as.numeric("-9999"))),NA,dt1$SI))
dt1$SR <- ifelse((trimws(as.character(dt1$SR))==trimws("-9999")),NA,dt1$SR)               
suppressWarnings(dt1$SR <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$SR))==as.character(as.numeric("-9999"))),NA,dt1$SR))
dt1$NH4 <- ifelse((trimws(as.character(dt1$NH4))==trimws("-9999")),NA,dt1$NH4)               
suppressWarnings(dt1$NH4 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$NH4))==as.character(as.numeric("-9999"))),NA,dt1$NH4))
dt1$NO3 <- ifelse((trimws(as.character(dt1$NO3))==trimws("-9999")),NA,dt1$NO3)               
suppressWarnings(dt1$NO3 <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$NO3))==as.character(as.numeric("-9999"))),NA,dt1$NO3))
dt1$SRP <- ifelse((trimws(as.character(dt1$SRP))==trimws("-9999")),NA,dt1$SRP)               
suppressWarnings(dt1$SRP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$SRP))==as.character(as.numeric("-9999"))),NA,dt1$SRP))
dt1$TN <- ifelse((trimws(as.character(dt1$TN))==trimws("-9999")),NA,dt1$TN)               
suppressWarnings(dt1$TN <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$TN))==as.character(as.numeric("-9999"))),NA,dt1$TN))
dt1$TP <- ifelse((trimws(as.character(dt1$TP))==trimws("-9999")),NA,dt1$TP)               
suppressWarnings(dt1$TP <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$TP))==as.character(as.numeric("-9999"))),NA,dt1$TP))
dt1$TOC <- ifelse((trimws(as.character(dt1$TOC))==trimws("-9999")),NA,dt1$TOC)               
suppressWarnings(dt1$TOC <- ifelse(!is.na(as.numeric("-9999")) & (trimws(as.character(dt1$TOC))==as.character(as.numeric("-9999"))),NA,dt1$TOC))


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(LAB_ID)
summary(NAME)
summary(PIEZOMETER)
summary(DEPTH)
summary(DateTime)
summary(PH)
summary(SPCOND)
summary(CL)
summary(SO4)
summary(CA)
summary(K)
summary(MG)
summary(Na)
summary(AL)
summary(FE)
summary(MN)
summary(SI)
summary(SR)
summary(NH4)
summary(NO3)
summary(SRP)
summary(TN)
summary(TP)
summary(TOC) 
# Get more details on character variables

summary(as.factor(dt1$LAB_ID)) 
summary(as.factor(dt1$NAME)) 
summary(as.factor(dt1$PIEZOMETER))
detach(dt1)               
bog_porewater_month<-dt1
rm(dt1)
##################################################################
rm(bog_pore_month)
rm(bog_pore_synop)
rm(lagg_pore_synop)
rm(auto)




###########################Functions##########################

#lowercase the column names
lowercase<-function(df){
  colnames(df)<-tolower(colnames(df))
  return(df)
}

#runoff date column has a different name  
change_column_name <- function(df, old_colname, new_colname) {
  colnames(df)[which(names(df) == old_colname)] <- new_colname
  return(df)
}

#make sure df's date column is of type "date" and is of the same format "year month day"
date_column_chr<-function (df){
  df$date <- as.Date(strptime(df$date, format = "%m/%d/%Y %H:%M"))
  return(df)
}
date_column_chr_nohours<-function (df){
  df$date <- as.Date(strptime(df$date, format = "%m/%d/%Y"))
  return(df)
}


date_column<-function (df){
  df$date <- as.Date(df$date, format = "%m/%d/%Y %H:%M")
  return(df)
}
#df$date<-as.Date(df$date,format="%d/%m/%Y %H:%M")

#filter for the shared time
filter_date <- function(df, start_date, end_date) {
  filtered_df <- df %>%
    filter(as.Date(date, format = "%Y-%m-%d") >= as.Date(start_date) &
             as.Date(date, format = "%Y-%m-%d") <= as.Date(end_date))
  
  return(filtered_df)
}


#month, month_name,month_range, season_name
add_month_season <- function(df) {
  
  df$date<-as.Date(df$date,format="%Y-%m-%d") #this is only for Contributions #"%m-%d-%Y") THIS IS FOR ALL OTHER DATA
  #create month column
  df$month <- lubridate::month(df$date)
  #create month name
  df$month_name <- case_when(
    df$month == 1 ~ "January",
    df$month == 2 ~ "February",
    df$month == 3 ~ "March",
    df$month == 4 ~ "April",
    df$month == 5 ~ "May",
    df$month == 6 ~ "June",
    df$month == 7 ~ "July",
    df$month == 8 ~ "August",
    df$month == 9 ~ "September",
    df$month == 10 ~ "October",
    df$month == 11 ~ "November",
    df$month == 12 ~ "December",
    TRUE ~ NA_character_  # Handle any other cases (optional)
  )
  # Create month range
  df$month_range <- case_when(
    df$month %in% 7:10 ~ "Jul-Oct",
    df$month %in% c(11:12, 1:3) ~ "Nov-Mar",
    df$month %in% 4:6 ~ "Apr-June",
    TRUE ~ "Other"
  )
  
  # Create season_name
  df$season_name <- case_when(
    df$month_range %in% "Jul-Oct" ~ "Growing",
    df$month_range %in% "Apr-June" ~ "Melt",
    df$month_range %in% "Nov-Mar" ~ "Dormant",
    TRUE ~ NA_character_
  )
  return(df)
}

#daily average
daily_avg<-function(df){
  df%>%
    mutate(year=year(date),month=month(date),day=day(date))%>%
    group_by(year,month,day)%>%
    summarise(across(where(is.numeric), ~mean(., na.rm=TRUE)))%>%
    mutate(date=as.Date(paste(year,month,day,sep='-')))
}
#when combining two dataset that have data for same date
avg_same_date<-function(df){ 
  result<-df%>%
    group_by(date) %>%
    summarise(across(where(is.numeric), mean, na.rm = TRUE))
  return(result)
}

avg_same_date <- function(df) { 
  result <- df %>%
    group_by(date) %>%
    summarise(across(where(is.numeric), ~ mean(., na.rm = TRUE)))
  
  print(result)
  
  return(result)
}

#unique(surf_rf_s2n$date)

#check if same date exist among all observations?!
check_same_date<-function(stream,event_precip,bog_pore,lagg_pore,surf_rf_s2n,surf_rf_s2s, sub_rf_s2n, sub_rf_s2s){
  # Extracting the dates from the summaries
  dates_stream <- stream$date
  dates_event_precip <- event_precip$date
  dates_bog_pore_week <-bog_pore$date
  dates_lagg_pore_week <- lagg_pore$date
  dates_surf_rf_s2n <- surf_rf_s2n$date
  dates_surf_rf_s2s <- surf_rf_s2s$date
  dates_sub_rf_s2n <- sub_rf_s2n$date
  dates_sub_rf_s2s <- sub_rf_s2s$date
}


transform_ph<-function(df){
  #the negative logarithm (base 10) of the concentration of hydrogen ions in a solution
  #convert pH back to concentration, you would use the inverse of the logarithmic function,which is the exponentiation function.
  df<-mutate(df,h_ion = 10^(-ph))
  return(df)
}

select_and_order_columns <- function(df) {
  selected_df <- df %>%
    #select(spcond, cl, so4, ca, k, mg, na, al, fe, mn, si, sr,nh4, srp,tn,tp,npoc,tc.ic,doc,br,thgf,mehgf,pb,o18,d,tempc,h_ion)
    #remove nh4 tc.ic doc br thgf mehgf pb o18 d
    #select(spcond, cl, so4, ca, k, mg, na, al, fe, mn, si, sr, srp,tn,tp,npoc,tempc,h_ion)
    #select(cl, so4, ca, k, mg, na, al, fe, mn, si, sr, srp,tn,tp,npoc,tempc,h_ion,doc)
    #select(ca, mg,sr, srp,npoc,tempc,doc)
    #select(ca, mg,sr, srp)
    select(cl,so4,ca,k,mg,na,al,fe,mn,si,sr,srp,tn,tp,h_ion)
  return(selected_df)
}

rm_columns<-function(df){
  #stream_col<-c("lab_id","peatland","name","date","month","month_name","month_range","season_name","temp_c","stage") #summary(stream_data)
  #bog_lagg_col<-c("lab_id","piezometer","date","month","month_name","month_range","season_name") #summary(bog_pore_week)
  #runoff_col<-c("lab_id","name","type","date","month","month_name","month_range","season_name") #summary(surf_rf)
  #precip_col<-c("lab_id","location","date","month","month_name","month_range","season_name") #summary(event_precip)
  col_rm<-c("lab_id","peatland","piezometer","name","date","type","location","month","month_name","month_range","season_name","temp_c","stage","thgu","mehgu","d202hg","mif204hg","mif201","hg","mif200hg","mif199hg","br","npoc",'tc.ic','uva360s',"bdoc","uva360",'mehgf','thgf','uva254',"mif201hg","feii","feiii","fe3","fe2","uva360f","no3","nh4","tempc","runoffvolume_l","ph")
  selected_df<-df[, !(names(df) %in% col_rm)] #,"date"
  #stream_col) |!(names(df) %in%bog_lagg_col) |!(names(df) %in%runoff_col) |!(names(df) %in%precip_col)
}

#residul plot
#Rbias and RRMSE 
corrected_function <- function(stflow_df, residual, solute) {
  rbias <- (sum(residual[[solute]], na.rm = TRUE)) / (mean(stflow_df[[solute]], na.rm = TRUE))
  rrmse <- sqrt(sum(residual[[solute]]^2, na.rm = TRUE)) / (nrow(residual) * mean(stflow_df[[solute]], na.rm = TRUE))
  return(list(rbias = rbias, rrmse = rrmse))
}
#metrics <- corrected_function(stream_20092011_slct, residuals, "spcond")
#rbias <- metrics$rbias
#rrmse <- metrics$rrmse

#plot residual
plot_residual <- function(df_slct, residuals, solute, rbias, rrmse) {
  par(mar = c(4, 4, 2, 2))
  plot(df_slct[[solute]], residuals[[solute]], 
       xlab = solute, 
       ylab = "Residuals")
  abline(h = 0, col = "red", lty = 2)
  
  # Calculate max and min values of x and y coordinates
  max_x <- max(df_slct[[solute]])
  min_x <- min(df_slct[[solute]])
  max_y <- max(residuals[[solute]])
  min_y <- min(residuals[[solute]])
  
  # Add RRMSE and relative bias as text annotations
  text(x = 0.5, y = 0, 
       labels = paste("RRMSE:", round(rrmse, 2), "\nRelative Bias:", round(rbias, 2)),
       pos = 4,font = 2,cex = 1, family = "Times New Roman")  # pos = 4 places text to the right of the coordinates
}


#standardize
standardize_columns <- function(data) {  
  col_means <- colMeans(data, na.rm = TRUE) #[,4:9]
  col_sds <- apply(data, 2, sd, na.rm = TRUE) #[,4:9]
  standardized_data <- na.omit(scale(data, center = col_means, scale = col_sds)) #[,4:9]
  
  return(standardized_data)
}


#projection
proj_on_pcs<- function(data){
  projected_EM<-data %*% pca_result$rotation #loadings <- pca_result$rotation
  return(projected_EM)
}


#extracting indices of different dimensions for the ones that have low or high slope

#when all dimensions are gathered in one column in the indices dataset and you wnat to separate rows with different col name
indices_dim <- function(indices_slope, col) {
  # Filter rows based on the current column
  indices <- indices_slope[indices_slope[, "col"] == col, ]
  indices<-as.data.frame(indices)
  # Create a new variable using the column name
  new_var_name <- paste0(deparse(substitute(indices_slope)),"_", col, "d")
  
  # Assign the result to the new variable
  assign(new_var_name, indices, envir = .GlobalEnv)
}


#add zero to data so that all have the same period
add_zero<-function(df){
  start_date<- min(stream_data$date)
  end_date<- max(stream_data$date)
  empty_df <- data.frame(date = seq.Date(from = start_date, to = end_date, by = "day"))
  
  # Merge the empty dataframe with your original dataframe
  merged_df <- merge(df, empty_df, by = "date", all = TRUE)
}




########################## Data Corerction ####################

#lowercase
runoff<-lowercase(runoff)
event_precip<-lowercase(event_precip)
#auto<-lowercase(auto)
grab<-lowercase(grab)
lagg<-lowercase(lagg)
bog_pore_week<-lowercase(bog_pore_week)
lagg_pore_week<-lowercase(lagg_pore_week)
gw_month<-lowercase(gw_month)
bog_pore_month<-bog_porewater_month
bog_pore_month<-lowercase(bog_pore_month)

#add inverse ph column
runoff<-transform_ph(runoff)
event_precip<-transform_ph(event_precip)
#auto<-transform_ph(auto)
grab<-transform_ph(grab)
lagg<-transform_ph(lagg)
bog_pore_week<-transform_ph(bog_pore_week)
lagg_pore_week<-transform_ph(lagg_pore_week)
gw_month<-transform_ph(gw_month)
bog_pore_month<-transform_ph(bog_pore_month)
#date
#runoff's date column has a different name
runoff <- change_column_name(runoff, "date.time", "datetime")
runoff <- change_column_name(runoff, "datetime", "date")
#auto <- change_column_name(auto, "datetime", "date") #sub-daily
grab <- change_column_name(grab, "datetime", "date") #weekly
lagg <- change_column_name(lagg, "datetime", "date") #weekly
bog_pore_week <- change_column_name(bog_pore_week, "datetime", "date") #porewater
lagg_pore_week <- change_column_name(lagg_pore_week, "datetime", "date") #porewater
event_precip <- change_column_name(event_precip, "datetime", "date") #sporadic
gw_month <- change_column_name(gw_month, "datetime", "date")
bog_pore_month <- change_column_name(bog_pore_month, "datetime", "date")

#make sure date is date
runoff<-date_column_chr(runoff)
colnames(runoff)[colnames(runoff) == "tp_"] <- "tp"
#auto<-date_column(auto)
grab<-date_column(grab)
lagg<-date_column(lagg)
bog_pore_week<-date_column(bog_pore_week)
lagg_pore_week<-date_column(lagg_pore_week)
event_precip<-date_column(event_precip)
gw_month<-date_column(gw_month)
bog_pore_month<-date_column(bog_pore_month)

#separate runoff
sub_rf<-runoff[runoff$name=="S2N SUB" | runoff$name=="S2S SUB",]
surf_rf<-runoff[runoff$name=="S2N SURF" | runoff$name=="S2S SURF",] 

bog_pore_month<-date_column(bog_pore_month)
#seasonو month and month range
runoff<-add_month_season(runoff)
colnames(runoff)[colnames(runoff) == "tp_"] <- "tp"
event_precip<-add_month_season(event_precip)
bog_pore_week<-add_month_season(bog_pore_week)
lagg_pore_week<-add_month_season(lagg_pore_week)
#surf_rf_s2n<-add_month_season(surf_rf_s2n)
#surf_rf_s2s<-add_month_season(surf_rf_s2s)
#sub_rf_s2n<-add_month_season(sub_rf_s2n)
#sub_rf_s2s<-add_month_season(sub_rf_s2s)
surf_rf<-add_month_season(surf_rf)
sub_rf<-add_month_season(sub_rf)
grab<-add_month_season(grab)
lagg<-add_month_season(lagg)
gw_month<-add_month_season(gw_month)
bog_pore_month<-add_month_season(bog_pore_month)


grab$name<-"grab_SF"
lagg$name<-"lagg_SF"

#combine streamflow grab and lagg samples
combined_data <- bind_rows(grab_SF=grab,lagg_SF=lagg,.id = "name")
combined_data<-combined_data[order(as.Date(combined_data$date, format="%Y-%m-%d")), ] 
stream_data<-combined_data
#1259 (for grab) +734 (for lagg) = 1993 data exist for stream_data
#the grab+lagg data is from 1986/24/03 to 2021/16/11

rm(combined_data)

#only select the required variables
select_and_order_columns <- function(df) {
  selected_df <-select(df,cl,so4,ca,k,mg,na,al,fe,mn,si,sr,srp,tn,tp,h_ion)
  return(selected_df)
}

#stream_slct<-as.data.frame(select_and_order_columns(stream_data))
stream_slct<-dplyr::select(stream_data,cl,so4,ca,k,mg,na,al,fe,mn,si,sr,srp,tn,tp,h_ion,doc) #stream_data is teh grab+lagg samples
stream_slct_rmNa<-na.omit(stream_slct)
#rm(stream_slct)

data<-stream_slct_rmNa
#rm(stream_slct_rmNa)


#when plotting Missing Map, neede to add zero values to cover the same time period
#stream<-as.data.frame(rm_columns(stream_data))
#precip_add_zero<-as.data.frame(add_zero(event_precip))
#surf_rf_add_zero<-as.data.frame(add_zero(surf_rf))
#sub_rf_add_zero<-as.data.frame(add_zero(sub_rf))
#bog_pore_add_zero<-as.data.frame(add_zero(bog_pore_week))
#lagg_pore_wadd_zero<-as.data.frame(add_zero(lagg_pore_week))


#when plotting Missing Map, neede to drop some columns such as lab_id
#stream_rm<-as.data.frame(rm_columns(stream_data))
#precip_rm<-as.data.frame(rm_columns(precip))
#surf_rf_rm<-as.data.frame(rm_columns(surf_rf))
#sub_rf_rm<-as.data.frame(rm_columns(sub_rf))
#bog_pore_week_rm<-as.data.frame(rm_columns(bog_pore_week))
#lagg_pore_week_rm<-as.data.frame(rm_columns(lagg_pore_week))

#substituting 0.5*detection limit for elements in precipitation
event_precip <- event_precip %>%
  mutate(al = 0.005,
         mn = 0.005,
         si = 0.025,
         sr = 0.005)

print("done with data correction")




########################################### PCA #################################
pca <-princomp(data, cor=TRUE) #this is somehow similar to  prcomp(cleaned_data,center=TRUE, scale. = TRUE). (only the first PC is different)
#print(pca_result2)

#loadings or eigenvectors ; specifically is the eigenvector of the correlation or covariance matrix
PCs<-pca$loading #similar to loadings <- pca_result$rotation (loadings are eigenvectors of the correlation matrix)
#View(PCs)

#variances
summary(pca)
print(summary(pca))

# Extracts Necessary Components
columns<-ncol(data) #columns=14
Comp1<-pca$loading[1:columns]
Comp2<-pca$loading[ (columns+1) : (2*columns) ] #18+1 goes in the second row
Comp3<-pca$loading[ (2*columns+1) : (3*columns) ]
Comp4<-pca$loading[ (3*columns+1) : (4*columns) ]
comp5=PCs[(4*columns+1):(5*columns)]

print("done with pca")

################################################### Projections #####################################

# Produces Standardized Data
stddata<-data
mean<-NULL
sd<-NULL
for (i in names(data)) { #data is in format data.frame
  #returns a subset of your data containing only the first column
  #data[[1]]: gives you the values of the first column directly, without any additional information like row numbers or column names.
  mean[[i]]<-mean(data[[i]],na.rm=TRUE) #set na.rm to TRUE if NA values should be ignored
  sd[[i]]<-sd(data[[i]],na.rm=TRUE) #set na.rm to TRUE if NA values should be ignored
  stddata[[i]]=(data[[i]]-mean[[i]])/sd[[i]] #[[1]] means first column
}
#identical(stddata2, stddata)

#stddata <- mutate_all(data, ~ (.-mean(., na.rm = TRUE)) / sd(., na.rm = TRUE))
#mutate_all: to apply a transformation to all columns of a data frame.
# ~ : to define an anonymous function or formula
# . : columns
# -mean(): subtracts the mean

#identical(stddata2, stddata)
#rm(stddata2)

# eigen vectors, of corr matrix, to be specific 
X<-as.matrix(stddata)
V1<-t(as.matrix(Comp1)) #create vectors
V2<-t(as.matrix(data.frame(Comp1,Comp2))) # as.matrix gets rid of the row names; compare data.frame(Comp1,Comp2)[1,1:2] with as.matrix(data.frame(Comp1,Comp2))[1,1:2].   
V3<-t(as.matrix(data.frame(Comp1, Comp2, Comp3)))
V4<-t(as.matrix(data.frame(Comp1, Comp2, Comp3,Comp4)))
V5<-t(as.matrix(data.frame(Comp1, Comp2, Comp3,Comp4,comp5)))

# Projects Data 
#I have wrongly done the projection with standardized_tracers %*% loadings_4dim
X1<-X %*% (t(V1) %*% (ginv(V1 %*% t(V1)) %*% V1))
X2<-X %*% (t(V2) %*% (ginv(V2 %*% t(V2)) %*% V2))
X3<-X %*% (t(V3) %*% (ginv(V3 %*% t(V3)) %*% V3))
X4<-X %*% (t(V4) %*% (ginv(V4 %*% t(V4)) %*% V4))
X5<-X %*% (t(V5) %*% (ginv(V5 %*% t(V5)) %*% V5))

X1<-data.frame(X1)
X2<-data.frame(X2)
X3<-data.frame(X3)
X4<-data.frame(X4)
X5<-data.frame(X5)

colnames(X1)<-names(data)
colnames(X2)<-names(data)
colnames(X3)<-names(data)
colnames(X4)<-names(data)
colnames(X5)<-names(data)

# Destandardizes Data
projection1<-data
projection2<-data
projection3<-data
projection4<-data
projection5<-data

#X1, is the projection of the original data on the first eigenvector of the corr matrix, so has 15 variables
#X2, is the projection of the original data on the first two eigenvectors of the corr matrix, again has 15 variables
for (i in names(data)) {
  projection1[[i]]<- (X1[[i]]*sd[[i]])+mean[[i]]
}
for (i in names(data)) {
  projection2[[i]]<- (X2[[i]]*sd[[i]])+mean[[i]]
}
for (i in names(data)) {
  projection3[[i]]<- (X3[[i]]*sd[[i]])+mean[[i]]
}
for (i in names(data)) {
  projection4[[i]]<- (X4[[i]]*sd[[i]])+mean[[i]]
}
for (i in names(data)) {
  projection5[[i]]<- (X5[[i]]*sd[[i]])+mean[[i]]
}

# Creates Residuals
Residual1<- projection1-data
Residual2<- projection2-data
Residual3<- projection3-data
Residual4<- projection4-data
Residual5<- projection5-data 


# Function to extract the overall ANOVA p-value out of a linear model object
lmp <- function (modelobject) {
  if (class(modelobject) != "lm") stop("Not an object of class 'lm' ")
  f <- summary(modelobject)$fstatistic
  p <- pf(f[1],f[2],f[3],lower.tail=F) #p for probability; cdf; cumulative distribution function (CDF) of the F-distribution
  attributes(p) <- NULL
  return(p)
}

pvalues<-data.frame(matrix(NA, nrow=columns, ncol=5)) #creates a data frame to hold the p-values
RRMSE<-data.frame(matrix(NA, nrow=columns, ncol=5)) #creates a data frame to hold the RRMSE
rsq <- data.frame(matrix(NA, nrow=columns, ncol=5))
slope<-data.frame(matrix(NA,nrow=columns,ncol=5))
#columns: # of constituents


#Computes the p-values and fills the data frame
n<-1
for (i in names(data)) {
  fit<-lm(Residual1[[i]]~data[[i]])
  slope[n,1]<-coef(fit)[ "data[[i]]" ]
  #permutation test p-values vs. the usual F-test p-values
  pvalues[n,1]<-lmp(fit) #Fitting and testing linear models with permutation tests.
  RRMSE[n,1] <- (sqrt(sum((fit[5]-data[i])^2))/(length(data[i])*mean[[i]]))
  #  RRMSE[n, 1] <- (sqrt(sum((fit[[5]] - data[[i]])^2)) / (length(data[[i]]) * mean(data[[i]])))
  #fit[[5]] gives you the fitted values 
  rsq[n,1] <- summary(fit)["r.squared"]
  n <- n+1
}


n<-1
for (i in names(data)) {
  fit<-lm(Residual2[[i]]~data[[i]])
  slope[n,2]<-coef(fit)[ "data[[i]]" ]
  pvalues[n,2]<-lmp(fit)
  RRMSE[n,2] <- (sqrt(sum((fit[5]-data[i])^2))/(length(data[i])*mean[[i]]))
  # RRMSE[n, 2] <- (sqrt(sum((fit[[5]] - data[[i]])^2)) / (length(data[[i]]) * mean(data[[i]])))
  rsq[n,2] <- summary(fit)["r.squared"]
  n <- n+1
}

n<-1
for (i in names(data)) {
  fit<-lm(Residual3[[i]]~data[[i]])
  slope[n,3]<-coef(fit)[ "data[[i]]" ]
  pvalues[n,3]<-lmp(fit)
  RRMSE[n,3] <- (sqrt(sum((fit[5]-data[i])^2))/(length(data[i])*mean[[i]]))
  #RRMSE[n, 3] <- (sqrt(sum((fit[[5]] - data[[i]])^2)) / (length(data[[i]]) * mean(data[[i]])))
  rsq[n,3] <- summary(fit)["r.squared"]
  n <- n+1
}

n <- 1
for (i in names(data)) {
  fit <- lm(Residual4[[i]] ~ data[[i]])
  slope[n,4]<-coef(fit)[ "data[[i]]" ]
  pvalues[n, 4] <- lmp(fit)
  RRMSE[n,4] <- (sqrt(sum((fit[5]-data[i])^2))/(length(data[i])*mean[[i]]))
  #RRMSE[n, 4] <- (sqrt(sum((fit[[5]] - data[[i]])^2)) / (length(data[[i]]) * mean(data[[i]])))
  rsq[n, 4] <- summary(fit)$r.squared
  
  n <- n + 1
}

n <- 1
for (i in names(data)) {
  fit <- lm(Residual5[[i]] ~ data[[i]])
  slope[n,5]<-coef(fit)[ "data[[i]]" ]
  pvalues[n, 5] <- lmp(fit)
  RRMSE[n,5] <- (sqrt(sum((fit[5]-data[i])^2))/(length(data[i])*mean[[i]]))
  #RRMSE[n, 5] <- (sqrt(sum((fit[[5]] - data[[i]])^2)) / (length(data[[i]]) * mean(data[[i]])))
  rsq[n, 5] <- summary(fit)$r.squared
  
  n <- n + 1
}

# Labels the Rows and Columns of the P-values
colnames(pvalues)=c("1D", "2D", "3D","4D","5D")
rownames(pvalues)=names(data)

colnames(RRMSE)=c("1D", "2D", "3D","4D","5D")
rownames(RRMSE)=names(data)

colnames(rsq)=c("1D", "2D", "3D","4D","5D")
rownames(rsq)=names(data)

colnames(slope)=c("1D", "2D", "3D","4D","5D")
rownames(slope)=names(data)

print("done with projections") # also residuals


print("done with identifying conservative tracers")

# so far, using streamflow data with a group of constituents, we formed PCs and then for the first two 
#or three PCs, we projected the streamflow with that group to these selected PCs, then looked at each 
#constituent's residuals to decide on conservative ones. From now on, we choose conservative tracers and
#form the PCs based on these conservative tracers. Then, all the streamflow and endmember samples
#will be projected on these new PCs.




######################################## ######################################## ######################################## 
######################################## now identifying EMs (distance & mixing diagram) #######################################
######################################## ######################################## ######################################## 



######################## Projection on the PCs formed only by conservative tracers and
########################  not the previously selected group of constituents
########### Note: #stream_data include grab+lagg samples ;  data<-stream_slct_rmNa
############ nrow(stream_data) : 1993;  nrow(grab): 1259 ;  nrow(lagg): 734

#stream data comes from lagg and grab samples, so we need to identify which samples come from which
# location and whether their chemistry are different
#also, porewater samples come from differnt piezometers and each woudl have their own location

#select conservative tracers in streamflow and endmembers
select_tracers_doc <- function(df) {
  selected_df <- df %>%
    dplyr::select("ca","mg","al","mn","si","sr","doc","date")
  return(selected_df)
}
select_tracers_for_upland <- function(df) {
  selected_df <- df %>%
    dplyr::select("ca","mg","al","mn","si","sr","doc","date","name")
  return(selected_df)
}
select_tracers_toc <- function(df) {
  selected_df <- df %>%
    dplyr::select("ca","mg","al","mn","si","sr","toc","date")
  return(selected_df)
}
select_tracers_toc_gw <- function(df) {
  selected_df <- df %>%
    dplyr::select("ca","mg","al","mn","si","sr","toc","date","name")
  return(selected_df)
}

select_tracers_withdate <- function(df) {
  selected_df <- df %>%
    dplyr::select("ca","mg","al","mn","si","sr","doc","date","name")
  return(selected_df)
}

select_tracers_withpiezometer <- function(df) {
  selected_df <- df %>%
    dplyr::select("ca","mg","al","mn","si","sr","toc","date","piezometer")
  return(selected_df)
}


surf_slct<-select_tracers_for_upland(surf_rf)
sub_slct<-select_tracers_for_upland(sub_rf)
bog_slct<-select_tracers_withpiezometer(bog_pore_week)
lagg_slct<-select_tracers_withpiezometer(lagg_pore_week)
precip_slct<-select_tracers_toc(event_precip)
stream_slct<-select_tracers_withdate(stream_data)
gw_slct<-select_tracers_toc_gw(gw_month)

colnames(lagg_slct)[colnames(lagg_slct) == "toc"] <- "doc"
colnames(bog_slct)[colnames(bog_slct) == "toc"] <- "doc"
colnames(`precip_slct`)[colnames(precip_slct) == "toc"] <- "doc"
colnames(gw_slct)[colnames(gw_slct) == "toc"] <- "doc"

## I will look at the EMs' distance after looking at the chemistry of endmembers and exploring why they show this chemical behavior

###################################### Exploring source waters chemistry #####################################

####################################### (1) Mixing diagrams with biplots ######################################
####################################### (2) Time Series of constituents' concentrations in endmembers ######################################
####################################### (3) c-q plots for subsurface-soil moisture ######################################


library("dplyr")
library("lubridate")

#data
#stream_slct<-dplyr::select(stream_data,date,name,ca,mg,mn,al,si,sr,doc)
stream_tracers<-na.omit(stream_slct)
data_mixing_space<-stream_tracers[,-c(8,9)]

#add season
stream_tracers<-stream_tracers%>%mutate(year=year(date))%>%mutate(season=
                                                                    case_when(month(date)%in%c(4:6)~"melt",
                                                                              month(date)%in%c(7:10)~"growing",
                                                                              month(date)%in%c(11,12,1,2,3)~"dormant"))
#From the file  #timeseries_lower right of mixing diagram
lagg<-lagg_slct%>%mutate(group="lagg")%>%na.omit()%>%mutate(season=
                                                                              case_when(month(date)%in%c(4:6)~"melt",
                                                                                        month(date)%in%c(7:10)~"growing",
                                                                                        month(date)%in%c(11,12,1,2,3)~"dormant"))

bog<-bog_slct%>%mutate(group="bog")%>%na.omit()%>%mutate(season=
                                                                           case_when(month(date)%in%c(4:6)~"melt",
                                                                                     month(date)%in%c(7:10)~"growing",
                                                                                     month(date)%in%c(11,12,1,2,3)~"dormant"))

surf<-surf_slct%>%mutate(group="surf")%>%na.omit()%>%mutate(season=
                                                                       case_when(month(date)%in%c(4:6)~"melt",
                                                                                 month(date)%in%c(7:10)~"growing",
                                                                                 month(date)%in%c(11,12,1,2,3)~"dormant"))

sub<-sub_slct%>%mutate(group="sub")%>%na.omit()%>%mutate(season=
                                                                    case_when(month(date)%in%c(4:6)~"melt",
                                                                              month(date)%in%c(7:10)~"growing",
                                                                              month(date)%in%c(11,12,1,2,3)~"dormant"))

precip<-precip_slct%>%mutate(group="precip")%>%na.omit()%>%mutate(season=
                                                                                case_when(month(date)%in%c(4:6)~"melt",
                                                                                          month(date)%in%c(7:10)~"growing",
                                                                                          month(date)%in%c(11,12,1,2,3)~"dormant"))

gw<-gw_slct%>%mutate(group="gw")%>%na.omit()%>%mutate(season=
                                                                    case_when(month(date)%in%c(4:6)~"melt",
                                                                              month(date)%in%c(7:10)~"growing",
                                                                              month(date)%in%c(11,12,1,2,3)~"dormant"))
#gw starts from 2007 but when applying na.omit it starts from 2013 and is not applicable for our year of desired (2009-2011)

colnames(bog_pore_month)[colnames(bog_pore_month) == "toc"] <- "doc"
bog_month_depth0<-bog_pore_month%>% filter(depth == 0)
bog_month_depth30<-bog_pore_month%>% filter(depth == 30)
bog_month_depth50<-bog_pore_month%>% filter(depth == 50)
bog_month_depth100<-bog_pore_month%>% filter(depth == 100)
bog_month_depth150<-bog_pore_month%>% filter(depth == 150)
bog_month_depth200<-bog_pore_month%>% filter(depth == 200)


selecting<-function(df){
  df<-dplyr::select(df,date,name,piezometer,ca,mg,mn,al,si,sr,doc)
  return(df)
}

bog_month_depth0_slct<-selecting(bog_month_depth0)%>%mutate(group="bog0")%>%na.omit()%>%mutate(season=
                                                                                                 case_when(month(date)%in%c(4:6)~"melt",
                                                                                                           month(date)%in%c(7:10)~"growing",
                                                                                                           month(date)%in%c(11,12,1,2,3)~"dormant"))

bog_month_depth30_slct<-selecting(bog_month_depth30)%>%mutate(group="bog30")%>%na.omit()%>%mutate(season=
                                                                                                    case_when(month(date)%in%c(4:6)~"melt",
                                                                                                              month(date)%in%c(7:10)~"growing",
                                                                                                              month(date)%in%c(11,12,1,2,3)~"dormant"))

bog_month_depth50_slct<-selecting(bog_month_depth50)%>%mutate(group="bog50")%>%na.omit()%>%mutate(season=
                                                                                                    case_when(month(date)%in%c(4:6)~"melt",
                                                                                                              month(date)%in%c(7:10)~"growing",
                                                                                                              month(date)%in%c(11,12,1,2,3)~"dormant"))

bog_month_depth100_slct<-selecting(bog_month_depth100)%>%mutate(group="bog100")%>%na.omit()%>%mutate(season=
                                                                                                       case_when(month(date)%in%c(4:6)~"melt",
                                                                                                                 month(date)%in%c(7:10)~"growing",
                                                                                                                 month(date)%in%c(11,12,1,2,3)~"dormant"))

bog_month_depth150_slct<-selecting(bog_month_depth150)%>%mutate(group="bog150")%>%na.omit()%>%mutate(season=
                                                                                                       case_when(month(date)%in%c(4:6)~"melt",
                                                                                                                 month(date)%in%c(7:10)~"growing",
                                                                                                                 month(date)%in%c(11,12,1,2,3)~"dormant"))

bog_month_depth200_slct<-selecting(bog_month_depth200)%>%mutate(group="bog200")%>%na.omit()%>%mutate(season=
                                                                                                       case_when(month(date)%in%c(4:6)~"melt",
                                                                                                                 month(date)%in%c(7:10)~"growing",
                                                                                                                 month(date)%in%c(11,12,1,2,3)~"dormant"))
############################## explore each dataset based on their selected tracers and group ##################
library(dplyr)
stream_tracers_summary<-stream_tracers[,-c(8,10,11)]%>%
  group_by(name) %>%
  summarise(across(everything(), list(mean = ~mean(.), sd = ~sd(.), median = ~median(.)), .names = "{.col}_{.fn}"))

print(stream_tracers_summary)
stream_tracers_summary<-as.data.frame(stream_tracers_summary)
write.csv((stream_tracers_summary), "stream_tracers_summary.csv", row.names = FALSE)
#################################### PROJECTION ####################################
####################################  for mixing diagram   ####################################


mixing_biplot<-function(yr)
{
  #yr<-2013
  stream_tracers_yr<-stream_tracers%>% filter(year(date) == yr) 
  lagg_yr<-lagg%>% filter(year(date) == yr) 
  bog_yr<-bog%>% filter(year(date) == yr) 
  surf_yr<-surf%>% filter(year(date) == yr) 
  sub_yr<-sub%>% filter(year(date) == yr) 
  precip_yr<-precip%>% filter(year(date) == yr) 
  gw_yr<-gw%>% filter(year(date) == yr) 
  #deeper bog starts from the year 2014 and hence not useful the years 2009-2011
  bog_month_depth0_yr<-bog_month_depth0_slct%>% filter(year(date) == yr) 
  bog_month_depth30_yr<-bog_month_depth30_slct%>% filter(year(date) == yr) 
  bog_month_depth50_yr<-bog_month_depth50_slct%>% filter(year(date) == yr) 
  bog_month_depth100_yr<-bog_month_depth100_slct%>% filter(year(date) == yr) 
  bog_month_depth150_yr<-bog_month_depth150_slct%>% filter(year(date) == yr) 
  bog_month_depth200_yr<-bog_month_depth200_slct%>% filter(year(date) == yr)
  
  data_mixing_space<-stream_tracers_yr[-c(8:11)]
  #pca
  pca_mixing <-princomp(data_mixing_space, cor=TRUE) #eigenvalue decomposition #using correlation matrix does mean that we are using the standardized version of data
  
  
  
  # Extracts Necessary Components
  columns<-ncol(data_mixing_space) #columns=14
  Comp1<-pca_mixing$loading[1:columns]
  Comp2<-pca_mixing$loading[ (columns+1) : (2*columns) ] #18+1 goes in the second row
  dim<-2 #2 dimensions
  comps<-pca_mixing$loading[1:(columns*dim)]
  V<-as.matrix(data.frame(split(comps, 1:columns)))
  V_named<-V
  colnames(V_named)<-c("Ca","Mg","Mn","Al","Si","Sr","DOC")
  
  #From the file  #timeseries_lower right of mixing diagram
  # Produces Standardized Data
  lagg_rm<-lagg_yr[,-c(8:11)]
  bog_rm<-bog_yr[,-c(8:11)]
  surf_rm<-surf_yr[,-c(8:11)]
  sub_rm<-sub_yr[,-c(8:11)]
  precip_rm<-precip_yr[,-c(8:10)]
  gw_rm<-gw_yr[,-c(8:11)]
  bog0_rm<-bog_month_depth0_yr[,-c(1:3,11,12)]
  bog30_rm<-bog_month_depth30_yr[,-c(1:3,11,12)]
  bog50_rm<-bog_month_depth50_yr[,-c(1:3,11,12)]
  bog100_rm<-bog_month_depth100_yr[,-c(1:3,11,12)]
  bog150_rm<-bog_month_depth150_yr[,-c(1:3,11,12)]
  bog200_rm<-bog_month_depth200_yr[,-c(1:3,11,12)]
  
  
  stddata<-data_mixing_space
  mean<-NULL
  sd<-NULL
  for (i in names(data_mixing_space)) {
    mean[[i]]<-mean(data[[i]]) #set na.rm to TRUE if NA values should be ignored
    sd[[i]]<-sd(data[[i]]) #set na.rm to TRUE if NA values should be ignored
    stddata[[i]]=(data_mixing_space[[i]]-mean[[i]])/sd[[i]]
  }
  
  stdlagg<-lagg_rm
  for (i in names(data_mixing_space)) {
    stdlagg[[i]]=(lagg_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog<-bog_rm
  for (i in names(data_mixing_space)) {
    stdbog[[i]]=(bog_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdsurf<-surf_rm
  for (i in names(data_mixing_space)) {
    stdsurf[[i]]=(surf_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdsub<-sub_rm
  for (i in names(data_mixing_space)) {
    stdsub[[i]]=(sub_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdprecip<-precip_rm
  for (i in names(data_mixing_space)) {
    stdprecip[[i]]=(precip_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdgw<-gw_rm
  for (i in names(data_mixing_space)) {
    stdgw[[i]]=(gw_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog_month0<-bog0_rm
  for (i in names(data_mixing_space)) {
    stdbog_month0[[i]]=(bog0_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog_month30<-bog30_rm
  for (i in names(data_mixing_space)) {
    stdbog_month30[[i]]=(bog30_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog_month50<-bog50_rm
  for (i in names(data_mixing_space)) {
    stdbog_month50[[i]]=(bog50_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog_month100<-bog100_rm
  for (i in names(data_mixing_space)) {
    stdbog_month100[[i]]=(bog100_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog_month150<-bog150_rm
  for (i in names(data_mixing_space)) {
    stdbog_month150[[i]]=(bog150_rm[[i]]-mean[[i]])/sd[[i]]
  }
  stdbog_month200<-bog200_rm
  for (i in names(data_mixing_space)) {
    stdbog_month200[[i]]=(bog200_rm[[i]]-mean[[i]])/sd[[i]]
  }
  
  
  stddata_mtx<-as.matrix(stddata)
  stdlagg_mtx<-as.matrix(stdlagg)
  stdbog_mtx<-as.matrix(stdbog)
  stdsurf_mtx<-as.matrix(stdsurf)
  stdsub_mtx<-as.matrix(stdsub)
  stdprecip_mtx<-as.matrix(stdprecip)
  stdgw_mtx<-as.matrix(stdgw)
  stdbog_month0_mtx<-as.matrix(stdbog_month0)
  stdbog_month30_mtx<-as.matrix(stdbog_month30)
  stdbog_month50_mtx<-as.matrix(stdbog_month50)
  stdbog_month100_mtx<-as.matrix(stdbog_month100)
  stdbog_month150_mtx<-as.matrix(stdbog_month150)
  stdbog_month200_mtx<-as.matrix(stdbog_month200)
  
  
  # Projects Data onto Components
  stream_projection<-data.frame(stddata_mtx %*% t(V))
  
  #projection for each endmember 
  lagg_projection<-data.frame(stdlagg_mtx %*% t(V)) #lagg
  bog_projection<-data.frame(stdbog_mtx %*% t(V))  #bog
  surf_projection<-data.frame(stdsurf_mtx %*% t(V)) #surf
  sub_projection<-data.frame(stdsub_mtx %*% t(V))   #sub
  precip_projection<-data.frame(stdprecip_mtx %*% t(V))   #precip
  gw_projection<-data.frame(stdgw_mtx %*% t(V))   #gw
  
  bog_month0_projection<-data.frame(stdbog_month0_mtx %*% t(V))  
  bog_month30_projection<-data.frame(stdbog_month30_mtx %*% t(V))  
  bog_month50_projection<-data.frame(stdbog_month50_mtx %*% t(V))  
  bog_month100_projection<-data.frame(stdbog_month100_mtx %*% t(V))  
  bog_month150_projection<-data.frame(stdbog_month150_mtx %*% t(V))  
  bog_month200_projection<-data.frame(stdbog_month200_mtx %*% t(V))  
  
  
  #sub_projection_big<-which(sub_projection$X1 > 20)
  #sub_projection_rmdbig<-sub_projection %>% filter(row_number() != sub_projection_big)
  
  
  #lagg_projection_big<-which(lagg_projection$X1 > 15)
  #lagg_projection_rmdbig<-lagg_projection %>% filter(row_number() != lagg_projection_big)
  
  #In the mixing space, use the V_named to draw the arrows,
  #each column will be one arrow with the first row (coordiante along pc1) being the x of the endpoint and the second row being the y of the endpoint
  stream_projection_season<-stream_projection%>%mutate(date=stream_tracers_yr$date)%>%mutate(season=stream_tracers_yr$season)%>%mutate(name=stream_tracers_yr$name)
  lagg_projection_season<-lagg_projection%>%mutate(date=lagg_yr$date)%>%mutate(season=lagg_yr$season)%>%mutate(piezometer=lagg_yr$piezometer)
  bog_projection_season<-bog_projection%>%mutate(date=bog_yr$date)%>%mutate(season=bog_yr$season)%>%mutate(piezometer=bog_yr$piezometer)
  surf_projection_season<-surf_projection%>%mutate(date=surf_yr$date)%>%mutate(season=surf_yr$season)%>%mutate(name=surf_yr$name)
  sub_projection_season<-sub_projection%>%mutate(date=sub_yr$date)%>%mutate(season=sub_yr$season)%>%mutate(name=sub_yr$name)
  precip_projection_season<-precip_projection%>%mutate(date=precip_yr$date)%>%mutate(season=precip_yr$season)

  precip_projection_season$location<-"precip"
  
  
  
  arrows_df <- data.frame(
    variable = rep(colnames(V_named), each = 1),
    PC1 = as.vector(V_named[1, ]),
    PC2 = as.vector(V_named[2, ])
  )
  
  
  lagg_projection_season<-lagg_projection_season %>%
    rename(location = piezometer)
  
  bog_projection_season<-bog_projection_season %>%
    rename(location = piezometer)
  
  surf_projection_season<-surf_projection_season %>%
    rename(location = name)
  sub_projection_season<-sub_projection_season %>%
    rename(location = name)
  
  stream_projection_season<-stream_projection_season %>%
    rename(location = name)
  ########################################## MIXING DIAGRAM WITH BIPLOT ######################################
  ##########################################                            ##########################################
 
  #pch_shape <- c("melt" = 18, "growing" = 17, "dormant" = 8)
  #grablagg_size<-c("grab"=12, "lagg"=2)
  shape_stream<-c("grab_SF"=8, "lagg_SF"=14)
  #season_colors <- c("melt" = alpha("blue",0.5), "growing" =alpha("#01bd5f",0.5), "dormant" = alpha("darkred",0.5))
  #rm(season_colors)
  #install.packages("ggrepel")
  library(ggrepel)
  
  library(ggplot2)
  x_limits <- c(-10, 10)
  y_limits <- c(-10, 10)
  
  p <- ggplot(data = stream_projection_season, aes(x = X1, y = X2)) +
    geom_point(aes(shape=location),#shape = season, #,size=factor(name). #color = season,shape=location)
               size = 6, alpha = 0.8,color="purple") +facet_wrap(~location)+
    ##scale_shape_manual(values = pch_shape) +
    scale_shape_manual(values = shape_stream) +
    #scale_color_manual(values = season_colors) + 
   ##scale_size_manual(values=grablagg_size)+
    labs(x = "PC 1 (75.3%)", y = "PC 2 (10.6%)")+
    scale_x_continuous(limits = x_limits,
      breaks = seq(-10, 10, by = 5) # Explicitly setting the x-axis ticks
    ) +
    scale_y_continuous(limits = y_limits,
      breaks =seq(-10, 10, by = 5)  # Explicitly setting the y-axis ticks
    ) +
    theme(text = element_text(family = "Times", size = 14), 
          axis.title = element_text(size = 14), 
          axis.text = element_text(size = 14),  
          legend.text = element_text(size = 14),
          legend.title = element_text(size = 14),#panel.background = element_blank(),
          panel.grid.major = element_line(color = "grey90"),
          panel.grid.minor = element_line(color = "grey90"),
          panel.background = element_rect(fill = "white", color = NA),
          panel.border = element_blank())+
    geom_hline(yintercept = 0, linetype = "dashed", color = "black") +
    geom_vline(xintercept = 0, linetype = "dashed", color = "black")
  
  lagg_projection_season$group <- "Lagg"
  bog_projection_season$group <- "Bog"
  #surf_projection_season$group <- "Surf_rf"
  #sub_projection_season$group <- "Sub_rf"
  precip_projection_season$group <- "Precip"
  #bog_month0_projection_season$group <- "bog0"
  #bog_month30_projection_season$group <- "bog30"
  #bog_month50_projection_season$group <- "bog50"
  #bog_month100_projection_season$group <- "bog100"
  #bog_month150_projection_season$group <- "bog150"
  #bog_month200_projection_season$group <- "bog200"
  
  all_projections <- rbind(
    transform(lagg_projection_season[,-c(3)], shape = "Lagg",color="Lagg"), #, color = season
    transform(bog_projection_season[,-c(3)], shape = "Bog",color="Bog"),
    #transform(surf_projection_season[,-c(3)], shape = "Surf_rf",color="Surf_rf"),#, color = season
    #transform(sub_projection_season[,-c(3)], shape = "Sub_rf",color="Sub_rf"),#, color = season
    transform(precip_projection_season[,-3], shape = "Precip",color="Precip")
    #transform(bog_month0_projection, shape = "bog0", color = "bog0"),
    #  transform(bog_month30_projection[,-3], shape = "bog30", color = "bog30"),
    #  transform(bog_month50_projection[,-3], shape = "bog50", color = "bog50"),
    # transform(bog_month100_projection, shape = "bog100", color = "bog100"),
    # transform(bog_month150_projection[,-3], shape = "bog150", color = "bog150")
    # transform(bog_month200_projection, shape = "bog200", color = "bog200")
    
  )
  
  # Add EM points
  p <- p +
    geom_point(data = all_projections, aes(x = X1, y = X2, shape = shape,color=group)#, color = season
               ,alpha=0.8, size = 5)#+facet_wrap(~season)
    guides(shape = guide_legend(override.aes = list(size = 14)))
  # Adding shapes and colors for the new points
  additional_shapes <- c("Lagg" = 16, "Bog" = 18, "Surf_rf" = 1, "Sub_rf" = 18, "Precip" = 20)  #,"bog0"=16,"bog30"=16,"bog50"=16,"bog100"=16,"bog150"=16,"bog200"=16)
  additional_colors <- c("Lagg" = alpha("#6b7701",0.9), "Bog" = alpha("#dfd901",0.8), "Surf_rf" = alpha("cornflowerblue",0.7) , "Sub_rf" = alpha("chocolate4",0.7) , "Precip" = "skyblue")#,"bog0"=alpha("#fee39b",0.8),"bog30"=alpha("lightsalmon3",0.7),"bog50"=alpha("brown",0.7),"bog100"="#e4a801","bog150"=alpha("darkgoldenrod4",0.8),"bog200"=alpha("salmon4",0.7))
  
  #"Surf_rf" = 1, "Sub_rf" = 18 "Lagg" = 15,
  #"#548401"
  p <- p + 
    scale_size_manual(values=grablagg_size)+
    scale_shape_manual(values = c(shape_stream, additional_shapes)) +
   scale_color_manual(values = c("purple",additional_colors)) +#season_colors, 
    #scale_color_manual(values = season_colors)+
    guides(shape = guide_legend("Legend"), color = guide_legend("Legend"),size=guide_legend("Legend"))+ggtitle(yr)
  
  
  p <- p +
    geom_segment(data = arrows_df, aes(x = 0, y = 0, xend = PC1 * 10, yend = PC2 * 10),
                 arrow = arrow(length = unit(0.2, "cm") , type="closed"),
                 color = "black")+
    geom_text_repel(data = arrows_df, aes(x = PC1 * 10, y = PC2 * 10, label = variable),
                    family = "Times", size = 14 / .pt, vjust = 0.5, hjust = -0.75, max.overlaps = Inf)   # Adjust font and size
  # geom_text (data = arrows_df, aes(x = PC1 * 6, y = PC2 * 6, label = variable),
  #              family = "Times", size = 10 / .pt, vjust = -0.5, hjust = -0.5)   # Adjust font and size
  
 #p
  # return(p)
  
  return(p)
}

#different years 

yr <- 2011
mixing_biplot(yr)




############################################# preparing teh data for the Time series ##########################################
####################################### snow depth data from 2008 ####################################### 

getwd()
setwd("/Users/safl/Reference_folder/EMMA/data/")

snowdepth_GR<-read_excel("snowdepth_grandRapid2008onward.xls")
snowdepth_GR<-as.data.frame(snowdepth_GR)
snowdepth_GR<-lowercase(snowdepth_GR)
snowdepth_GR$date<-as.Date(snowdepth_GR$date)

snowdepth_GR_nm<-snowdepth_GR%>%mutate_at(vars(`minimum temperature degrees (f)`, 
               `precipitation (inches)`, 
               `snow (inches)`, 
               `snow depth (inches)`), 
          as.numeric)
#I will only use this:snow depth (inches)`

snowdepth_GR_nm_20092011<-snowdepth_GR_nm%>%filter(year(date)>=2009&year(date)<=2011)
#info:
#precipitation is: rainfall plus the water equivalent found in snowfall
#1 inch of rain is equivalent to 10 inches of snowfall.
# S2S, a north-facing hillslope that is south of the S2 bog.
# S2N, a south-facing hillslope that is north of the S2 bog

################################### 10 minute soil temperature and moisture ############################
setwd("/Users/safl/Reference_folder/EMMA/data/aditional downloaded data/soil moisture 10 min/")

soilTemp_10min<-read.csv("MEF_S2_soil_temp_10min.csv")
soilMoist_10min<-read.csv("MEF_S2_soil_moisture_10min.csv")
#str(soilTemp_10min)
#str(soilMoist_10min)

soilTemp_10min<-lowercase(soilTemp_10min)
soilMoist_10min<-lowercase(soilMoist_10min)

soilTemp_10min <- soilTemp_10min %>% rename(date = timestamp)
soilMoist_10min <- soilMoist_10min %>% rename(date = timestamp)


date_column_chr_posix<-function (df){
  df$date <- as.POSIXct(df$date, format = "%Y-%m-%d %H:%M:%S")
  df$date <- format(df$date, "%Y-%d-%m")
  df$date <- as.Date(df$date)
  return(df)
}

soilTemp_10min<-date_column_chr_posix(soilTemp_10min)
soilMoist_10min<-date_column_chr_posix(soilMoist_10min)

library("lubridate")
soilMoist_10min_20092011<-soilMoist_10min%>%filter(year(date)>=2009&year(date)<=2011)
soilTemp_10min_20092011<-soilTemp_10min%>%filter(year(date)>=2009&year(date)<=2011)


soilMoist_daily <- soilMoist_10min_20092011 %>%
  group_by(date) %>%
  summarize(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))

soilTemp_daily <- soilTemp_10min_20092011 %>%
  group_by(date) %>%
  summarize(across(where(is.numeric), ~ mean(.x, na.rm = TRUE)))

soilTemp_daily<-as.data.frame(soilTemp_daily)
soilMoist_daily<-as.data.frame(soilMoist_daily)

#combining upland soil data
soil_data <- merge(soilMoist_daily,soilTemp_daily, by = "date")

# soil data and snow data
soil_snow_data <- merge(soil_data, snowdepth_GR_nm_20092011, by = "date")

#sm_snow_data <- merge(soilMoist_daily, snowdepth_GR_nm_20092011, by = "date")
soil_snow_data_2009<-soil_snow_data%>%filter((year(date))==2009)
soil_snow_data_2010<-soil_snow_data%>%filter((year(date))==2010)
soil_snow_data_2011<-soil_snow_data%>%filter((year(date))==2011)

library(scales)
scale<-function(df){
  numeric_columns <- df %>%
  select_if(is.numeric)%>%
select_if(~ !all(is.na(.)))
  return(numeric_columns)}

soil_snow_data_2009_scaled<-as.data.frame(lapply(scale(soil_snow_data_2009), rescale, to = c(0, 1)))%>%mutate(date=soil_snow_data_2009$date)
soil_snow_data_2010_scaled<-as.data.frame(lapply(scale(soil_snow_data_2010), rescale, to = c(0, 1)))%>%mutate(date=soil_snow_data_2010$date)
soil_snow_data_2011_scaled<-as.data.frame(lapply(scale(soil_snow_data_2011), rescale, to = c(0, 1)))%>%mutate(date=soil_snow_data_2011$date)



yr<-2009
stream_tracers_yr<-stream_tracers%>% filter(year(date) == yr) 
lagg_yr<-lagg%>% filter(year(date) == yr) 
bog_yr<-bog%>% filter(year(date) == yr) 
surf_yr<-surf%>% filter(year(date) == yr) 
sub_yr<-sub%>% filter(year(date) == yr) 
precip_yr<-precip%>% filter(year(date) == yr) 
gw_yr<-gw%>% filter(year(date) == yr) 
#deeper bog starts from the year 2014 and hence not useful the years 2009-2011
bog_month_depth0_yr<-bog_month_depth0_slct%>% filter(year(date) == yr) 
bog_month_depth30_yr<-bog_month_depth30_slct%>% filter(year(date) == yr) 
bog_month_depth50_yr<-bog_month_depth50_slct%>% filter(year(date) == yr) 
bog_month_depth100_yr<-bog_month_depth100_slct%>% filter(year(date) == yr) 
bog_month_depth150_yr<-bog_month_depth150_slct%>% filter(year(date) == yr) 
bog_month_depth200_yr<-bog_month_depth200_slct%>% filter(year(date) == yr)


sub_yr_scaled<-as.data.frame(lapply(scale(sub_yr), rescale, to = c(0, 1)))%>%mutate(date=sub_yr$date)

############################################# 


############################################## Time sereis #################################################
library(tidyverse)

Ratio <- max(c(soil_snow_data_2009$s2s_lo_dp.x, soil_snow_data_2009$s2s_lo_dp.y),na.rm = TRUE) / max(soil_snow_data_2009$s2s_lo_dp.x,na.rm = TRUE)
SMMax <- max(soil_snow_data_2009$s2s_lo_dp.x,na.rm = TRUE)
BottomOffset <- 0.05

#si, ca, sr, mg,mn,al,doc
p <- ggplot(soil_snow_data_2009, aes(x = date)) +
  geom_line(aes(y = s2s_lo_sh.y, color = "SoilTemp")) +
  geom_bar(aes(y = `snow depth (inches)`, fill = "Snowdepth"),color =alpha("skyblue",0.4), stat = "identity", position = "identity") +
  geom_rect(aes(xmin = as.Date(date) - 0.1,
                xmax = as.Date(date) + 0.1,
                ymin = (BottomOffset + SMMax - s2s_lo_sh.x) * Ratio,
                ymax = (BottomOffset + SMMax) * Ratio,
                fill = "SVWC"),color=alpha("blue", 0.5)) + 
  geom_hline(yintercept = (BottomOffset + SMMax) * Ratio, color = "blue") +
  geom_hline(yintercept = 0, color = "black") +
  geom_point(data = sub_yr , aes(y =si, color="Si"),  size = 2) + #aes(y = element, color="element"),  size = 2) +  # Adding geom_point for si
  
  labs(title = "Si in subsurface (2009); S2S-lower position- depth", x = "Date", y = "", color = "Variable") +
  scale_y_continuous(name = expression(" "), sec.axis = sec_axis(~ BottomOffset + SMMax  - . / Ratio, name = "SVWC (-)"), expand = c(0, 0)) +
  scale_color_manual(name = " ", values = c("SoilTemp" = "red", "Si" ="black")) +
  scale_fill_manual(name = " ", values = c(" ","Snowdepth" = alpha("skyblue", 0.4),"SVWC" = alpha("blue", 0.5))) +
  theme_classic() +
  theme(axis.line.y.right = element_line(color = "blue"), 
        axis.ticks.y.right = element_line(color = "blue"),
        axis.text.y.right = element_text(color = "blue"),
        axis.title.y.right = element_text(color = "blue"),
        axis.line.y.left = element_line(color = "black"), 
        axis.ticks.y.left = element_line(color = "black"),
        axis.text.y.left = element_text(color = "black"),
        axis.title.y.left = element_text(color = "black"),
        legend.position = "bottom")

print(p)






































################################### distance ###############################################

surf_slct_mean <- apply(surf_slct, 2, mean, na.rm = TRUE)
sub_slct_mean <- apply(sub_slct, 2, mean, na.rm = TRUE)
bog_slct_mean <- apply(bog_slct, 2, mean, na.rm = TRUE) #2 means applying the function to each column of the matrix
lagg_slct_mean <- apply(lagg_slct, 2, mean, na.rm = TRUE)
precip_slct_mean <- apply(precip_slct, 2, mean, na.rm = TRUE)

# Compute the standard deviation for each column of the ENDMEMBERS
surf_slct_std <- apply(surf_slct, 2, sd, na.rm = TRUE)
sub_slct_std <- apply(sub_slct, 2, sd, na.rm = TRUE)
bog_slct_std <- apply(bog_slct, 2, sd, na.rm = TRUE)
lagg_slct_std <- apply(lagg_slct, 2, sd, na.rm = TRUE)
precip_slct_std <- apply(precip_slct, 2, sd, na.rm = TRUE)

surf_slct_mean_df <- as.data.frame(t(surf_slct_mean))
sub_slct_mean_df <- as.data.frame(t(sub_slct_mean))
bog_slct_mean_df<-as.data.frame(t(bog_slct_mean))
lagg_slct_mean_df<-as.data.frame(t(lagg_slct_mean))
precip_slct_mean_df<-as.data.frame(t(precip_slct_mean))

surf_slct_std_df <- as.data.frame(t(surf_slct_std))
sub_slct_std_df <- as.data.frame(t(sub_slct_std))
bog_slct_std_df<-as.data.frame(t(bog_slct_std))
lagg_slct_std_df<-as.data.frame(t(lagg_slct_std))
precip_slct_std_df<-as.data.frame(t(precip_slct_std))

combined_df <- rbind(surf_slct_mean_df, sub_slct_mean_df,bog_slct_mean_df,lagg_slct_mean_df,precip_slct_mean_df)

end_std_combined<-rbind(surf_slct_std_df, sub_slct_std_df,bog_slct_std_df,lagg_slct_std_df,precip_slct_std_df)

# Set column names

colnames(combined_df) <- c("ca","mg","al","mn","si","sr","doc")
colnames(end_std_combined) <- c("ca","mg","al","mn","si","sr","doc")

#  colnames(combined_df) <- c("ca","mg","al","mn","si","sr","tp","srp")
# colnames(end_std_combined) <- c("ca","mg","al","mn","si","sr","tp","srp")

# Add row names
rownames(combined_df) <- c("surf_rf", "sub_rf","bog_porewatre","lagg_porewater", "precip")
rownames(end_std_combined) <- c("surf_rf", "sub_rf","bog_porewatre","lagg_porewater","precip")

# Print the combined data frame
#print(combined_df)

ends<-combined_df
ends_std<-end_std_combined
data_with_date<-na.omit(stream_slct)
#  data<-data_with_date[,-9]
data<-data_with_date[,-8]
data_with_season<-add_month_season(data_with_date)


dim<-2

# Runs PCA
#if(nrow(data)>2){
  PCA<-princomp(data, cor=TRUE)
  
  # Extracts Necessary Components
  columns<-ncol(data)
  comps<-PCA$loading[1:(columns*dim)]
  V<-as.matrix(data.frame(split(comps, 1:columns)))
  
  
  # Produces Standardized Data
  stddata<-data
  mean<-NULL
  sd<-NULL
  for (i in names(data)) {
    mean[[i]]<-mean(data[[i]]) #set na.rm to TRUE if NA values should be ignored
    sd[[i]]<-sd(data[[i]]) #set na.rm to TRUE if NA values should be ignored
    stddata[[i]]=(data[[i]]-mean[[i]])/sd[[i]]
  }
  
  stdends<-ends
  for (i in names(data)) {
    stdends[[i]]=(ends[[i]]-mean[[i]])/sd[[i]]
  }
  
  stdends_std<-ends_std
  for (i in names(data)) {
    stdends_std[[i]]=(ends_std[[i]]-mean[[i]])/sd[[i]]
  }
  
  # Projects Data
  b<-as.matrix(stdends)
  bproj<-data.frame(b %*% (t(V) %*% (ginv(V %*% t(V)) %*% V)))
  
  b_std<-as.matrix(stdends_std)
  bproj_std<-data.frame(b_std %*% (t(V) %*% (ginv(V %*% t(V)) %*% V)))
  
  # Destandardizes Data
  endproj<-ends
  for (i in 1:columns) {
    endproj[[i]]<- (bproj[[i]]*sd[[i]])+mean[[i]]
  }
  
  endproj_std<-ends_std
  for (i in 1:columns) {
    endproj_std[[i]]<- (bproj_std[[i]]*sd[[i]])+mean[[i]] #standard deviation of ems is projected : endproj_std
  }
  
  # Calculates Distance
  d<-abs(ends-endproj)
  distance<-d
  
  # Formats distances into percents
  for (i in 1:columns) {
    distance[[i]]<-sprintf("%1.2f%%",d[[i]]/ends[[i]]*100) #f%%: a floating number with percentage sign
  }
  
  #setwd("/Users/safl/Reference_folder/EMMA/results") 
  
  # Writes Distance to a CSV file
  #write.csv(distance, file = "Percent_Distances.csv")
  
  #####
  
  ############################################### PCA interpretation #############################################
  
  #pca
  pca_mixing <-princomp(data_mixing_space, cor=TRUE) #eigenvalue decomposition #using correlation matrix does mean that we are using the standardized version of data
  
  PCs<-pca_mixing$loading #relation between constituents and PCs
  PCs
  
  #variances
  summary(pca_mixing)
  print(summary(pca_mixing))
  #scree plot
  #install.packages("factoextra")
  library("factoextra")
  fviz_eig(pca_mixing, addlabels = TRUE, hjust = -0.3, lim = c(0, 100), barfill="white",barcolor ="darkblue"
           ,linecolor ="red")+theme_classic()+labs(title = "Scree plot",
                                                   x = "Principal Components", y = "% of variances")
  #variables
  var<-get_pca_var(pca_mixing)
  head(var$coord)#coordinates
  head(var$cos2)#quality
  head(var$contrib)#contributions
  head(var$cor)#this is the same as coordinates
  #correlations
  fviz_pca_var(pca_mixing, col.var = "black")
  fviz_pca_var(pca_mixing, col.var = "cos2",
               gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
               repel = TRUE # Avoid text overlapping
  ) #colored by quality of representation
  
  fviz_pca_var(pca_mixing, col.var = "contrib",
               gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07")
  )#colored by contributions
  
  #contributions
  corrplot(var$contrib, is.corr=FALSE)
  fviz_contrib(pca_mixing, choice = "var", axes = 1, top = 10)
  fviz_contrib(pca_mixing, choice = "var", axes = 2, top = 10)
  fviz_contrib(pca_mixing, choice = "var", axes = 1:2, top = 10)
  
  #quality
  library("corrplot")
  corrplot(var$cos2, is.corr=FALSE)
  fviz_cos2(pca_mixing, choice = "var", axes = 1:2)
  
  #dimension description
  library("FactoMineR")
  pca_mixing2<- PCA(data_mixing_space, graph = FALSE)
  
  pc_desc <- dimdesc(pca_mixing2, axes = c(1,2), proba = 0.05)
  pc_desc
  pc_desc$Dim.1
  pc_desc$Dim.2
  
  
  
  #groupings in the plot of PCs
  #add year to the streamflow
  stream_tracers<-stream_tracers%>%mutate(year=year(date))%>%mutate(season=
                                                                      case_when(month(date)%in%c(4:6)~"melt",
                                                                                month(date)%in%c(7:10)~"growing",
                                                                                month(date)%in%c(11,12,1,2,3)~"dormant"))
  
  
  
  stream_tracers_2008<-stream_tracers%>%filter(year==2008)%>%na.omit()
  pca_2008<-princomp(stream_tracers_2008[,-c(1,8,9)], cor=TRUE) 
  
  #variables
  var_2008<-get_pca_var(pca_2008)
  corrplot(var_2008$contrib, is.corr=FALSE)
  
  fviz_pca_ind(pca_2008,col.ind=stream_tracers_2008$season,palette = c("#00AFBB", "#E7B800","#FC4E07"),addEllipses = TRUE)
  #,addEllipses = TRUE)
  #palette = c("#00AFBB", "#E7B800","#FC4E07")
  
  library(dplyr)
  library(ggplot2)
  library(factoextra)
  
  
  
  yr_mixing<-function(df,yr){
    stream_tracers_yr<- df %>% filter(year == yr) %>% na.omit()
    
    # Perform PCA on the filtered data
    pca_yr <- princomp(stream_tracers_yr[,-c(1,8,9)], cor = TRUE)
    
    # Plot the PCA results
    #fviz_pca_ind(pca_yr, axes=c(1,2),
    #             col.ind = stream_tracers_yr$season, 
    #             palette = c("#00AFBB", "#E7B800", "#FC4E07"),addEllipses = TRUE) +#,ellipse.type = "confidence" or"convex"
    #  ggtitle(paste("PCA ", yr))
    
    ## Plot the biplot 
    fviz_pca_biplot(pca_yr, 
                    col.ind = stream_tracers_yr$season,palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                    label = "var",addEllipses = TRUE, #label = "all", ,ellipse.type = "confidence" 
                    col.var = "black", repel = TRUE,
                    legend.title = "seasons")+ #xlab = "PC1", ylab = "PC2",
      ggtitle(yr)
    
  }
  
  yr <- 2020
  yr_mixing(stream_tracers,yr)
  
  
  
  #the whole years
  fviz_pca_biplot(pca_mixing, 
                  col.ind = stream_tracers_season$season,palette = c("#00AFBB", "#E7B800", "#FC4E07"), 
                  label = "var",addEllipses = TRUE, #label = "all", ,ellipse.type = "confidence" 
                  col.var = "black", repel = TRUE,
                  legend.title = "seasons")
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  # Defie your desired time period
  
  
  #EMMA analysis will have three parts; 1) Conservative tracers, using residual plots 2) mixing diagrams 3) distance of endmembers
  # 4) contributions 5) correction of contributions 6)simulating streamwater chemistry 7) 
  
  
  
  

