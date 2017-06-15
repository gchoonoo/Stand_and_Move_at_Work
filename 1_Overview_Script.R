##########################################################

# Stand and Move at Work - Overview Pipeline

##########################################################

# Libraries
library(activpalProcessing)

##########################################################

# Alert! Please set directories:

# Phase 1 
week1_dir = "AP_data/Phase 1/Week1/"
week2_dir = "AP_data/Phase 1/Week2/"
week3_dir = "AP_data/Phase 1/Week3/"
week4_dir = "AP_data/Phase 1/Week4/"

# Phase 2
week1_p2_dir = "AP_data/Phase 2/Week1/"
week2_p2_dir = "AP_data/Phase 2/Week2/"
week3_p2_dir = "AP_data/Phase 2/Week3/"
week4_p2_dir = "AP_data/Phase 2/Week4/"

##########################################################

# Phase 1

##########################################################

# Week 1

##########################################################

dir(week1_dir) -> dir_1_1

dir_1_1[grep("Events.csv",dir_1_1)] -> dir_1_1_events

phase1_week1 = vector("list",length(dir_1_1_events))

phase1_week1_time = vector("list",length(dir_1_1_events))

for(i in 1:length(dir_1_1_events)){
  print(i)
  read.csv(paste0(week1_dir,dir_1_1_events[i]), header=T) -> phase1_week1[[i]]
  
  activpal.file.reader(paste0(week1_dir,dir_1_1_events[i])) -> phase1_week1_time[[i]]
  
  phase1_week1_time[[i]]$File_name = dir_1_1_events[i]
  
  phase1_week1[[i]]$File_name = dir_1_1_events[i]
  
  if(sum(phase1_week1[[i]][,2] == phase1_week1_time[[i]][,2]) == nrow(phase1_week1_time[[i]])){
    cbind(phase1_week1[[i]], Time=phase1_week1_time[[i]][,"time"]) -> phase1_week1[[i]]
  }else{
    print(dir_1_1_events[i])
    print("Error: Time out of order")
  }
  
  phase1_week1[[i]]$Week = 1
  
  do.call(rbind,phase1_week1) -> phase1_week1_full
}

##########################################################

# Week 2

##########################################################

dir(week2_dir) -> dir_1_2

dir_1_2[grep("Events.csv",dir_1_2)] -> dir_1_2_events

phase1_Week2 = vector("list",length(dir_1_2_events))

phase1_Week2_time = vector("list",length(dir_1_2_events))

for(i in 1:length(dir_1_2_events)){
  print(i)
  read.csv(paste0(week2_dir,dir_1_2_events[i]), header=T) -> phase1_Week2[[i]]
  
  activpal.file.reader(paste0(week2_dir,dir_1_2_events[i])) -> phase1_Week2_time[[i]]
  
  phase1_Week2_time[[i]]$File_name = dir_1_2_events[i]
  
  phase1_Week2[[i]]$File_name = dir_1_2_events[i]
  
  if(sum(phase1_Week2[[i]][,2] == phase1_Week2_time[[i]][,2]) == nrow(phase1_Week2_time[[i]])){
    cbind(phase1_Week2[[i]], Time=phase1_Week2_time[[i]][,"time"]) -> phase1_Week2[[i]]
  }else{
    print(dir_1_2_events[i])
    print("Error: Time out of order")
  }
  
  phase1_Week2[[i]]$Week = 2
  
  do.call(rbind,phase1_Week2) -> phase1_Week2_full
}

##########################################################

# Week 3

##########################################################

dir(week3_dir) -> dir_1_3

dir_1_3[grep("Events.csv",dir_1_3)] -> dir_1_3_events

phase1_Week3 = vector("list",length(dir_1_3_events))

phase1_Week3_time = vector("list",length(dir_1_3_events))

for(i in 1:length(dir_1_3_events)){
  print(i)
  read.csv(paste0(week3_dir,dir_1_3_events[i]), header=T) -> phase1_Week3[[i]]
  
  activpal.file.reader(paste0(week3_dir,dir_1_3_events[i])) -> phase1_Week3_time[[i]]
  
  phase1_Week3_time[[i]]$File_name = dir_1_3_events[i]
  
  phase1_Week3[[i]]$File_name = dir_1_3_events[i]
  
  if(sum(phase1_Week3[[i]][,2] == phase1_Week3_time[[i]][,2]) == nrow(phase1_Week3_time[[i]])){
    cbind(phase1_Week3[[i]], Time=phase1_Week3_time[[i]][,"time"]) -> phase1_Week3[[i]]
  }else{
    print(dir_1_3_events[i])
    print("Error: Time out of order")
  }
  
  phase1_Week3[[i]]$Week = 3
  
  do.call(rbind,phase1_Week3) -> phase1_Week3_full
}

##########################################################

# Week 4

##########################################################

dir(week4_dir) -> dir_1_4

dir_1_4[grep("Events.csv",dir_1_4)] -> dir_1_4_events

phase1_Week4 = vector("list",length(dir_1_4_events))

phase1_Week4_time = vector("list",length(dir_1_4_events))

for(i in 1:length(dir_1_4_events)){
  print(i)
  read.csv(paste0(week4_dir,dir_1_4_events[i]), header=T) -> phase1_Week4[[i]]
  
  activpal.file.reader(paste0(week4_dir,dir_1_4_events[i])) -> phase1_Week4_time[[i]]
  
  phase1_Week4_time[[i]]$File_name = dir_1_4_events[i]
  
  phase1_Week4[[i]]$File_name = dir_1_4_events[i]
  
  if(sum(phase1_Week4[[i]][,2] == phase1_Week4_time[[i]][,2]) == nrow(phase1_Week4_time[[i]])){
    cbind(phase1_Week4[[i]], Time=phase1_Week4_time[[i]][,"time"]) -> phase1_Week4[[i]]
  }else{
    print(dir_1_4_events[i])
    print("Error: Time out of order")
  }
  
  phase1_Week4[[i]]$Week = 4
  
  do.call(rbind,phase1_Week4) -> phase1_Week4_full
}

##########################################################

# Combine all phase 1 events data

##########################################################

rbind(phase1_week1_full, phase1_Week2_full, phase1_Week3_full, phase1_Week4_full) -> phase1_full_data_events

# annotate cols from file name
phase1_full_data_events$ID = sapply(strsplit(phase1_full_data_events[,"File_name"], "-"),"[",1)

phase1_full_data_events$Batch_collected = sapply(strsplit(phase1_full_data_events[,"File_name"], " "),"[",2)

phase1_full_data_events$Batch_time_collected = sapply(strsplit(phase1_full_data_events[,"File_name"], " "),"[",3)

phase1_full_data_events$Batch_duration = paste(sapply(strsplit(phase1_full_data_events[,"File_name"], " "),"[",5), sapply(strsplit(phase1_full_data_events[,"File_name"], " "),"[",6), sapply(strsplit(phase1_full_data_events[,"File_name"], " "),"[",7))

length(unique(phase1_full_data_events[,"ID"])) # 18 subjects total, not all went through all weeks

names(phase1_full_data_events)[9] <- "Time_v2"
phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101"),]

# annotate date without time
phase1_full_data_events$Date = sapply(strsplit(as.character(phase1_full_data_events[,"Time_v2"]), " "),"[",1)

# annotate day for each subject (not counting missed days)

unique(phase1_full_data_events[,"ID"]) -> subject_ids


for(i in 1:length(subject_ids)){
  print(i)
  unique(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == subject_ids[i]),"Date"]) -> date
  
  date[order(date)] -> date
  
  phase1_full_data_events[which(phase1_full_data_events[,"ID"] == subject_ids[i]),"Day"] <- factor(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == subject_ids[i]),"Date"], levels = date, labels = 1:length(date)) 
  
}

unique(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101"),c("Date", "Day")])

unique(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "102"),c("Date", "Day")])

unique(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "103"),c("Date", "Day")])

phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101" & phase1_full_data_events[,"Day"] == 1),"ActivityCode..0.sedentary..1..standing..2.stepping."]

phase1_full_data_events$percent_0 = NA

phase1_full_data_events$percent_1 = NA

phase1_full_data_events$percent_2 = NA

phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101" & phase1_full_data_events[,"Day"] == 1 & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0),"Interval..s."]

# percentage sedentary per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"percent_0"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0,"Interval..s."])/sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"Interval..s."])*100
      
    }
  }
}

# percentage standing per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"percent_1"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1,"Interval..s."])/sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"Interval..s."])*100
      
    }
  }
}

# percentage stepping per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"percent_2"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2,"Interval..s."])/sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"Interval..s."])*100
      
    }
  }
}


phase1_full_data_events$percent_0_full = NA

phase1_full_data_events$percent_1_full = NA

phase1_full_data_events$percent_2_full = NA

# percentage sedentary across all phase1 per ID

for(j in unique(phase1_full_data_events[,"ID"])){
  print(j)

  phase1_full_data_events[phase1_full_data_events[,"ID"] == j,"percent_0_full"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0,"Interval..s."])/sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j,"Interval..s."])*100
  
}

# percentage standing per day per ID
for(j in unique(phase1_full_data_events[,"ID"])){
  print(j)
  
  phase1_full_data_events[phase1_full_data_events[,"ID"] == j,"percent_1_full"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1,"Interval..s."])/sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j,"Interval..s."])*100
  
}

# percentage stepping per day per ID
for(j in unique(phase1_full_data_events[,"ID"])){
  print(j)
  
  phase1_full_data_events[phase1_full_data_events[,"ID"] == j,"percent_2_full"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2,"Interval..s."])/sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j,"Interval..s."])*100
  
}

phase1_full_data_events$check_sum = rowSums(round(phase1_full_data_events[,c("percent_0","percent_1","percent_2")],0))

# close enough
unique(phase1_full_data_events[phase1_full_data_events$check_sum != 100,"check_sum"])

phase1_full_data_events$check_sum2 = rowSums(round(phase1_full_data_events[,c("percent_0_full","percent_1_full","percent_2_full")],0))

# close enough
unique(phase1_full_data_events[phase1_full_data_events$check_sum2 != 100,"check_sum"])

# number of minutes in each category
phase1_full_data_events$minutes_0 = NA

phase1_full_data_events$minutes_1 = NA

phase1_full_data_events$minutes_2 = NA

phase1_full_data_events$minutes = phase1_full_data_events[,"Interval..s."]/60

phase1_full_data_events$hours = phase1_full_data_events$minutes/60

sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101" & phase1_full_data_events[,"Day"] == 1 & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0),"minutes"])

sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101" & phase1_full_data_events[,"Day"] == 1 & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1),"minutes"])

sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101" & phase1_full_data_events[,"Day"] == 1 & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2),"minutes"])

sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == "101" & phase1_full_data_events[,"Day"] == 1),"minutes"])


# minutes sedentary per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"minutes_0"] <- sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0),"minutes"])
      
    }
  }
}

# minutes standing per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"minutes_1"] <- sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1),"minutes"])
      
    }
  }
}

# minutes stepping per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"minutes_2"] <- sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2),"minutes"])
      
    }
  }
}

# number of hours in each category
phase1_full_data_events$hours_0 = NA

phase1_full_data_events$hours_1 = NA

phase1_full_data_events$hours_2 = NA

# hours sedentary per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"hours_0"] <- sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0),"hours"])
      
    }
  }
}

# hours standing per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"hours_1"] <- sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1),"hours"])
      
    }
  }
}

# hours stepping per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"hours_2"] <- sum(phase1_full_data_events[which(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i & phase1_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2),"hours"])
      
    }
  }
}

unique(phase1_full_data_events[,c("ID", "Day", "percent_0","percent_1","percent_2","percent_0_full","percent_1_full","percent_2_full", "hours_0", "hours_1", "hours_2")]) -> shiny_data

shiny_data[order(shiny_data[,"ID"], shiny_data[,"Day"]),] -> shiny_data

par(mfrow=c(3,1))
plot(shiny_data[which(shiny_data[,"ID"] %in% c("101")),"percent_0"], type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Sedentary", ylim=c(0,100))
lines(shiny_data[which(shiny_data[,"ID"] %in% c("102")),"percent_0"], type="b",col="blue")

points(1,unique(shiny_data[which(shiny_data[,"ID"] %in% c("101")),"percent_0_full"]),pch="*")

points(1,unique(shiny_data[which(shiny_data[,"ID"] %in% c("102")),"percent_0_full"]),pch="*")
          
plot(shiny_data[which(shiny_data[,"ID"] %in% c("101")),"percent_1"], type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Standing", ylim=c(0,100))
lines(shiny_data[which(shiny_data[,"ID"] %in% c("102")),"percent_1"], type="b",col="blue")    

plot(shiny_data[which(shiny_data[,"ID"] %in% c("101")),"percent_2"], type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Stepping", ylim=c(0,100))
lines(shiny_data[which(shiny_data[,"ID"] %in% c("102")),"percent_2"], type="b",col="blue")      

phase1_full_data_events$Flag_Hours_Greater_24_by_ID_Day = NA

# flag days > 24 hours per day per ID
for(i in unique(phase1_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase1_full_data_events[,"ID"])){
    print(j)
    if(sum(phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i) > 0){
      phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"total_hours_by_ID_Day"] <- sum(phase1_full_data_events[phase1_full_data_events[,"ID"] == j & phase1_full_data_events[,"Day"] == i,"hours"])
      
    }
  }
}

# almost 50% of data has days > 24 hours
phase1_full_data_events[which(phase1_full_data_events[,"total_hours_by_ID_Day"] > 24),"Flag_Hours_Greater_24_by_ID_Day"] <- TRUE

phase1_full_data_events[-which(phase1_full_data_events[,"total_hours_by_ID_Day"] > 24),"Flag_Hours_Greater_24_by_ID_Day"] <- FALSE


write.table("phase1_full_data_events.txt", x=phase1_full_data_events, sep="\t", quote=F, row.names=F)

# all_subjects = unique(shiny_data[,"ID"])
# 
# cols = sample(rainbow(50), 18)
# 
# cols_v2 = cols
# 
# names(cols_v2) <- all_subjects

#save(shiny_data, cols_v2, file="./")

write.table("shiny_data.txt", x=shiny_data, sep="\t", quote=F, row.names=F)

##########################################################

# Phase 2

##########################################################

# Week 1

##########################################################

dir(week1_p2_dir) -> dir_1_1

dir_1_1[grep("Events.csv",dir_1_1)] -> dir_1_1_events

phase2_week1 = vector("list",length(dir_1_1_events))

phase2_week1_time = vector("list",length(dir_1_1_events))

for(i in 1:length(dir_1_1_events)){
  print(i)
  read.csv(paste0(week1_p2_dir,dir_1_1_events[i]), header=T) -> phase2_week1[[i]]
  
  activpal.file.reader(paste0(week1_p2_dir,dir_1_1_events[i])) -> phase2_week1_time[[i]]
  
  phase2_week1_time[[i]]$File_name = dir_1_1_events[i]
  
  phase2_week1[[i]]$File_name = dir_1_1_events[i]
  
  if(sum(phase2_week1[[i]][,2] == phase2_week1_time[[i]][,2]) == nrow(phase2_week1_time[[i]])){
    cbind(phase2_week1[[i]], Time=phase2_week1_time[[i]][,"time"]) -> phase2_week1[[i]]
  }else{
    print(dir_1_1_events[i])
    print("Error: Time out of order")
  }
  
  phase2_week1[[i]]$Week = 1
  
  do.call(rbind,phase2_week1) -> phase2_week1_full
}

##########################################################

# Week 2

##########################################################

dir(week2_p2_dir) -> dir_1_2

dir_1_2[grep("Events.csv",dir_1_2)] -> dir_1_2_events

phase2_Week2 = vector("list",length(dir_1_2_events))

phase2_Week2_time = vector("list",length(dir_1_2_events))

for(i in 1:length(dir_1_2_events)){
  print(i)
  read.csv(paste0(week2_p2_dir,dir_1_2_events[i]), header=T) -> phase2_Week2[[i]]
  
  activpal.file.reader(paste0(week2_p2_dir,dir_1_2_events[i])) -> phase2_Week2_time[[i]]
  
  phase2_Week2_time[[i]]$File_name = dir_1_2_events[i]
  
  phase2_Week2[[i]]$File_name = dir_1_2_events[i]
  
  if(sum(phase2_Week2[[i]][,2] == phase2_Week2_time[[i]][,2]) == nrow(phase2_Week2_time[[i]])){
    cbind(phase2_Week2[[i]], Time=phase2_Week2_time[[i]][,"time"]) -> phase2_Week2[[i]]
  }else{
    print(dir_1_2_events[i])
    print("Error: Time out of order")
  }
  
  phase2_Week2[[i]]$Week = 2
  
  do.call(rbind,phase2_Week2) -> phase2_Week2_full
}

##########################################################

# Week 3

##########################################################

dir(week3_p2_dir) -> dir_1_3

dir_1_3[grep("Events.csv",dir_1_3)] -> dir_1_3_events

phase2_Week3 = vector("list",length(dir_1_3_events))

phase2_Week3_time = vector("list",length(dir_1_3_events))

for(i in 1:length(dir_1_3_events)){
  print(i)
  read.csv(paste0(week3_p2_dir,dir_1_3_events[i]), header=T) -> phase2_Week3[[i]]
  
  activpal.file.reader(paste0(week3_p2_dir,dir_1_3_events[i])) -> phase2_Week3_time[[i]]
  
  phase2_Week3_time[[i]]$File_name = dir_1_3_events[i]
  
  phase2_Week3[[i]]$File_name = dir_1_3_events[i]
  
  if(sum(phase2_Week3[[i]][,2] == phase2_Week3_time[[i]][,2]) == nrow(phase2_Week3_time[[i]])){
    cbind(phase2_Week3[[i]], Time=phase2_Week3_time[[i]][,"time"]) -> phase2_Week3[[i]]
  }else{
    print(dir_1_3_events[i])
    print("Error: Time out of order")
  }
  
  phase2_Week3[[i]]$Week = 3
  
  do.call(rbind,phase2_Week3) -> phase2_Week3_full
}

##########################################################

# Week 4

##########################################################

dir(week4_p2_dir) -> dir_1_4

dir_1_4[grep("Events.csv",dir_1_4)] -> dir_1_4_events

phase2_Week4 = vector("list",length(dir_1_4_events))

phase2_Week4_time = vector("list",length(dir_1_4_events))

for(i in 1:length(dir_1_4_events)){
  print(i)
  read.csv(paste0(week4_p2_dir,dir_1_4_events[i]), header=T) -> phase2_Week4[[i]]
  
  activpal.file.reader(paste0(week4_p2_dir,dir_1_4_events[i])) -> phase2_Week4_time[[i]]
  
  phase2_Week4_time[[i]]$File_name = dir_1_4_events[i]
  
  phase2_Week4[[i]]$File_name = dir_1_4_events[i]
  
  if(sum(phase2_Week4[[i]][,2] == phase2_Week4_time[[i]][,2]) == nrow(phase2_Week4_time[[i]])){
    cbind(phase2_Week4[[i]], Time=phase2_Week4_time[[i]][,"time"]) -> phase2_Week4[[i]]
  }else{
    print(dir_1_4_events[i])
    print("Error: Time out of order")
  }
  
  phase2_Week4[[i]]$Week = 4
  
  do.call(rbind,phase2_Week4) -> phase2_Week4_full
}

##########################################################

# combine all Phase 2 events data

##########################################################

rbind(phase2_week1_full, phase2_Week2_full, phase2_Week3_full, phase2_Week4_full) -> phase2_full_data_events

# annotate cols from file name
phase2_full_data_events$ID = sapply(strsplit(phase2_full_data_events[,"File_name"], "-"),"[",1)

phase2_full_data_events$Batch_collected = sapply(strsplit(phase2_full_data_events[,"File_name"], " "),"[",2)

phase2_full_data_events$Batch_time_collected = sapply(strsplit(phase2_full_data_events[,"File_name"], " "),"[",3)

phase2_full_data_events$Batch_duration = paste(sapply(strsplit(phase2_full_data_events[,"File_name"], " "),"[",5), sapply(strsplit(phase2_full_data_events[,"File_name"], " "),"[",6), sapply(strsplit(phase2_full_data_events[,"File_name"], " "),"[",7))

length(unique(phase2_full_data_events[,"ID"])) # 16 subjects total, not all went through all weeks

names(phase2_full_data_events)[9] <- "Time_v2"
phase2_full_data_events[which(phase2_full_data_events[,"ID"] == "101"),]

unique(phase2_full_data_events[,"Time_v2"])

# annotate date without time
phase2_full_data_events$Date = sapply(strsplit(as.character(phase2_full_data_events[,"Time_v2"]), " "),"[",1)

# annotate day for each subject (not counting missed days)

unique(phase2_full_data_events[,"ID"]) -> subject_ids

phase2_full_data_events$Day = NA

for(i in 1:length(subject_ids)){
  print(i)
  unique(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == subject_ids[i]),"Date"]) -> date
  
  date[order(date)] -> date
  
  #print(sum(is.na(date)))
  
  phase2_full_data_events[which(phase2_full_data_events[,"ID"] == subject_ids[i]),"Day"] <- factor(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == subject_ids[i]),"Date"], levels = date, labels = 1:length(date)) 
  
}

unique(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == "103"),c("Date", "Day")])

phase2_full_data_events[which(phase2_full_data_events[,"ID"] == "103" & phase2_full_data_events[,"Day"] == 1),"ActivityCode..0.sedentary..1..standing..2.stepping."]

phase2_full_data_events$percent_0 = NA

phase2_full_data_events$percent_1 = NA

phase2_full_data_events$percent_2 = NA

# percentage sedentary per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"percent_0"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0,"Interval..s."])/sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"Interval..s."])*100
      
    }
  }
}

# percentage standing per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"percent_1"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1,"Interval..s."])/sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"Interval..s."])*100
      
    }
  }
}

# percentage stepping per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"percent_2"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2,"Interval..s."])/sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"Interval..s."])*100
      
    }
  }
}


phase2_full_data_events$percent_0_full = NA

phase2_full_data_events$percent_1_full = NA

phase2_full_data_events$percent_2_full = NA

# percentage sedentary across all phase2 per ID

for(j in unique(phase2_full_data_events[,"ID"])){
  print(j)
  
  phase2_full_data_events[phase2_full_data_events[,"ID"] == j,"percent_0_full"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0,"Interval..s."])/sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j,"Interval..s."])*100
  
}

# percentage standing per day per ID
for(j in unique(phase2_full_data_events[,"ID"])){
  print(j)
  
  phase2_full_data_events[phase2_full_data_events[,"ID"] == j,"percent_1_full"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1,"Interval..s."])/sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j,"Interval..s."])*100
  
}

# percentage stepping per day per ID
for(j in unique(phase2_full_data_events[,"ID"])){
  print(j)
  
  phase2_full_data_events[phase2_full_data_events[,"ID"] == j,"percent_2_full"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2,"Interval..s."])/sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j,"Interval..s."])*100
  
}

phase2_full_data_events$check_sum = rowSums(round(phase2_full_data_events[,c("percent_0","percent_1","percent_2")],0))

# close enough
unique(phase2_full_data_events[phase2_full_data_events$check_sum != 100,"check_sum"])

phase2_full_data_events$check_sum2 = rowSums(round(phase2_full_data_events[,c("percent_0_full","percent_1_full","percent_2_full")],0))

# close enough
unique(phase2_full_data_events[phase2_full_data_events$check_sum2 != 100,"check_sum"])

# number of minutes in each category
phase2_full_data_events$minutes_0 = NA

phase2_full_data_events$minutes_1 = NA

phase2_full_data_events$minutes_2 = NA

phase2_full_data_events$minutes = phase2_full_data_events[,"Interval..s."]/60

phase2_full_data_events$hours = phase2_full_data_events$minutes/60

# minutes sedentary per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"minutes_0"] <- sum(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0),"minutes"])
      
    }
  }
}

# minutes standing per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"minutes_1"] <- sum(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1),"minutes"])
      
    }
  }
}

# minutes stepping per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"minutes_2"] <- sum(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2),"minutes"])
      
    }
  }
}

# number of hours in each category
phase2_full_data_events$hours_0 = NA

phase2_full_data_events$hours_1 = NA

phase2_full_data_events$hours_2 = NA

# hours sedentary per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"hours_0"] <- sum(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 0),"hours"])
      
    }
  }
}

# hours standing per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"hours_1"] <- sum(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 1),"hours"])
      
    }
  }
}

# hours stepping per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"hours_2"] <- sum(phase2_full_data_events[which(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i & phase2_full_data_events[,"ActivityCode..0.sedentary..1..standing..2.stepping."] == 2),"hours"])
      
    }
  }
}

unique(phase2_full_data_events[,c("ID", "Day", "percent_0","percent_1","percent_2","percent_0_full","percent_1_full","percent_2_full", "hours_0", "hours_1", "hours_2")]) -> shiny_data_v2


shiny_data_v2[order(shiny_data_v2[,"ID"], shiny_data_v2[,"Day"]),] -> shiny_data_v2


phase2_full_data_events$Flag_Hours_Greater_24_by_ID_Day = NA

# flag days > 24 hours per day per ID
for(i in unique(phase2_full_data_events[,"Day"])){
  print(i)
  for(j in unique(phase2_full_data_events[,"ID"])){
    print(j)
    if(sum(phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i) > 0){
      phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"total_hours_by_ID_Day"] <- sum(phase2_full_data_events[phase2_full_data_events[,"ID"] == j & phase2_full_data_events[,"Day"] == i,"hours"])
      
    }
  }
}

# phase2_full_data_events[which(phase2_full_data_events[,"total_hours_by_ID_Day"] > 24),"Flag_Hours_Greater_24_by_ID_Day"] <- TRUE
# 
# phase2_full_data_events[-which(phase2_full_data_events[,"total_hours_by_ID_Day"] > 24),"Flag_Hours_Greater_24_by_ID_Day"] <- FALSE

write.table("phase2_full_data_events.txt", x=phase2_full_data_events, sep="\t", quote=F, row.names=F)

# set colors
all_subjects = unique(shiny_data_v2[,"ID"])

cols = sample(rainbow(50), 18)

cols_v2 = cols

names(cols_v2) <- all_subjects

save(shiny_data, shiny_data_v2, cols_v2, file="./shiny_data.rda")

write.table("shiny_data_v2.txt", x=shiny_data_v2, sep="\t", quote=F, row.names=F)

##########################################################

# Example Plot

##########################################################

all_subjects = unique(shiny_data_v2[,"ID"])

par(mfcol=c(3,2), xpd=T)

# Phase 1
# sedentary
plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Sedentary Phase 1", ylim=c(0,100))
legend("topleft", legend=all_subjects, inset=c(0,-.1), col=cols_v2, horiz=T,cex=.6, lty=2, lwd=2, pch=19)
for(i in all_subjects){
  lines(shiny_data[which(shiny_data[,"ID"] == i),"percent_0"], type="b",col=cols_v2[i], pch=19)
}
# standing
plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Standing Phase 1", ylim=c(0,100))
for(i in all_subjects){
  lines(shiny_data[which(shiny_data[,"ID"] %in% i),"percent_1"], type="b",col=cols_v2[i],pch=19)    
}
# stepping
plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Stepping Phase 1", ylim=c(0,100))
for(i in all_subjects){
  lines(shiny_data[which(shiny_data[,"ID"] %in% i),"percent_2"], type="b",col=cols_v2[i],pch=19)      
}

# Phase 2
# sedentary
plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Percent", main="Percent Sedentary Phase 2", ylim=c(0,100))
legend("topleft", legend=all_subjects, inset=c(0,-.1), col=cols_v2, horiz=T,cex=.6, lty=2, lwd=2, pch=19)
for(i in all_subjects){
  lines(shiny_data_v2[which(shiny_data_v2[,"ID"] == i),"percent_0"], type="b",col=cols_v2[i], pch=19)
}
# standing
plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Percent", main="Percent Standing Phase 2", ylim=c(0,100))
for(i in all_subjects){
  lines(shiny_data_v2[which(shiny_data_v2[,"ID"] %in% i),"percent_1"], type="b",col=cols_v2[i],pch=19)    
}
# stepping
plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Percent", main="Percent Stepping Phase 2", ylim=c(0,100))
for(i in all_subjects){
  lines(shiny_data_v2[which(shiny_data_v2[,"ID"] %in% i),"percent_2"], type="b",col=cols_v2[i],pch=19)
}