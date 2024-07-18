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
