############################## extable of statistics for each source water and their selected tracers ##################
library(dplyr)
stream_tracers_summary<-stream_tracers[,-c(8,10,11)]%>%
  group_by(name) %>%
  summarise(across(everything(), list(mean = ~mean(.), sd = ~sd(.), median = ~median(.)), .names = "{.col}_{.fn}"))

print(stream_tracers_summary)
stream_tracers_summary<-as.data.frame(stream_tracers_summary)
write.csv((stream_tracers_summary), "stream_tracers_summary.csv", row.names = FALSE)