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