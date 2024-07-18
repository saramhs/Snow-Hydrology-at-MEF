

####################################   mixing diagram with biplot  ####################################


mixing_biplot<-function(yr)
{
  
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
    
  ##########################################   plot the diagram   ######################################

 
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

