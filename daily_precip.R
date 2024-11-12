# Package ID: edi.563.6 Cataloging System:https://pasta.edirepository.org.
# Data set title: Marcell Experimental Forest daily precipitation, 1961 - ongoing.
# Data set creator:  Stephen Sebestyen - USDA Forest Service, Northern Research Station 
# Data set creator:  Andrew Hill - USDA Forest Service, Northern Research Station 
# Data set creator:  Richard Kyllander - USDA Forest Service, Northern Research Station 
# Data set creator:  Nina Lany - USDA Forest Service, Northern Research Station 
# Data set creator:  Daniel Roman - USDA Forest Service, Northern Research Station 
# Data set creator:  Arthur Elling - USDA Forest Service, Northern Research Station 
# Data set creator:  Elon Verry - USDA Forest Service, Northern Research Station 
# Data set creator:  Randall Kolka - USDA Forest Service, Northern Research Station 
# Contact:    -  Data Manager, Marcell Experimental Forest  - nina.lany@usda.gov
# Stylesheet v2.11 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu 

inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/563/6/f3a58ff544a4ddd3475d265da61bf40e" 
infile1 <- tempfile()
try(download.file(inUrl1,infile1,method="curl"))
if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")


dt1 <-read.csv(infile1,header=F 
               ,skip=1
               ,sep=","  
               , col.names=c(
                 "DATE",     
                 "NADP_PCP",     
                 "South_PCP",     
                 "North_PCP",     
                 "NADP_Flag",     
                 "South_Flag",     
                 "North_Flag"    ), check.names=TRUE)

unlink(infile1)

# Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings

# attempting to convert dt1$DATE dateTime string to R date structure (date or POSIXct)                                
tmpDateFormat<-"%Y-%m-%d"
tmp1DATE<-as.Date(dt1$DATE,format=tmpDateFormat)
# Keep the new dates only if they all converted correctly
if(nrow(dt1[dt1$DATE != "",]) == length(tmp1DATE[!is.na(tmp1DATE)])){dt1$DATE <- tmp1DATE } else {print("Date conversion failed for dt1$DATE. Please inspect the data and do the date conversion yourself.")}                                                                    

if (class(dt1$NADP_PCP)=="factor") dt1$NADP_PCP <-as.numeric(levels(dt1$NADP_PCP))[as.integer(dt1$NADP_PCP) ]               
if (class(dt1$NADP_PCP)=="character") dt1$NADP_PCP <-as.numeric(dt1$NADP_PCP)
if (class(dt1$South_PCP)=="factor") dt1$South_PCP <-as.numeric(levels(dt1$South_PCP))[as.integer(dt1$South_PCP) ]               
if (class(dt1$South_PCP)=="character") dt1$South_PCP <-as.numeric(dt1$South_PCP)
if (class(dt1$North_PCP)=="factor") dt1$North_PCP <-as.numeric(levels(dt1$North_PCP))[as.integer(dt1$North_PCP) ]               
if (class(dt1$North_PCP)=="character") dt1$North_PCP <-as.numeric(dt1$North_PCP)
if (class(dt1$NADP_Flag)=="factor") dt1$NADP_Flag <-as.numeric(levels(dt1$NADP_Flag))[as.integer(dt1$NADP_Flag) ]               
if (class(dt1$NADP_Flag)=="character") dt1$NADP_Flag <-as.numeric(dt1$NADP_Flag)
if (class(dt1$South_Flag)=="factor") dt1$South_Flag <-as.numeric(levels(dt1$South_Flag))[as.integer(dt1$South_Flag) ]               
if (class(dt1$South_Flag)=="character") dt1$South_Flag <-as.numeric(dt1$South_Flag)
if (class(dt1$North_Flag)=="factor") dt1$North_Flag <-as.numeric(levels(dt1$North_Flag))[as.integer(dt1$North_Flag) ]               
if (class(dt1$North_Flag)=="character") dt1$North_Flag <-as.numeric(dt1$North_Flag)

# Convert Missing Values to NA for non-dates

dt1$NADP_PCP <- ifelse((trimws(as.character(dt1$NADP_PCP))==trimws("NA")),NA,dt1$NADP_PCP)               
suppressWarnings(dt1$NADP_PCP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(dt1$NADP_PCP))==as.character(as.numeric("NA"))),NA,dt1$NADP_PCP))
dt1$South_PCP <- ifelse((trimws(as.character(dt1$South_PCP))==trimws("NA")),NA,dt1$South_PCP)               
suppressWarnings(dt1$South_PCP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(dt1$South_PCP))==as.character(as.numeric("NA"))),NA,dt1$South_PCP))
dt1$North_PCP <- ifelse((trimws(as.character(dt1$North_PCP))==trimws("NA")),NA,dt1$North_PCP)               
suppressWarnings(dt1$North_PCP <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(dt1$North_PCP))==as.character(as.numeric("NA"))),NA,dt1$North_PCP))
dt1$NADP_Flag <- ifelse((trimws(as.character(dt1$NADP_Flag))==trimws("NA")),NA,dt1$NADP_Flag)               
suppressWarnings(dt1$NADP_Flag <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(dt1$NADP_Flag))==as.character(as.numeric("NA"))),NA,dt1$NADP_Flag))
dt1$South_Flag <- ifelse((trimws(as.character(dt1$South_Flag))==trimws("NA")),NA,dt1$South_Flag)               
suppressWarnings(dt1$South_Flag <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(dt1$South_Flag))==as.character(as.numeric("NA"))),NA,dt1$South_Flag))
dt1$North_Flag <- ifelse((trimws(as.character(dt1$North_Flag))==trimws("NA")),NA,dt1$North_Flag)               
suppressWarnings(dt1$North_Flag <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(dt1$North_Flag))==as.character(as.numeric("NA"))),NA,dt1$North_Flag))


# Here is the structure of the input data frame:
str(dt1)                            
attach(dt1)                            
# The analyses below are basic descriptions of the variables. After testing, they should be replaced.                 

summary(DATE)
summary(NADP_PCP)
summary(South_PCP)
summary(North_PCP)
summary(NADP_Flag)
summary(South_Flag)
summary(North_Flag) 
# Get more details on character variables

detach(dt1)           

################################## ###################################
################################### ###################################

precip_daily <- data.frame(
  precip_cm = dt1$South_PCP,
  date = dt1$DATE
)

rm(dt1)
