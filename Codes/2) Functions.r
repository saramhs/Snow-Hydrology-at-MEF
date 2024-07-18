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
