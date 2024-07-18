
#############################################  Time series of snowdepth, soil temperature, and other environmental factors  ##########################################
####################################### snow depth data from 2008 ####################################### 


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





