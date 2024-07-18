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



                                                                                                                 