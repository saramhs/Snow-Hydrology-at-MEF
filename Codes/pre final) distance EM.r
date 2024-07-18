
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
  