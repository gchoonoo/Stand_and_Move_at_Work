##################################################

# Stand and Move at Work - Prompt Data Pipeline

##################################################

# Libraries
library(activpalProcessing) #for reading in activPal events files
library(tidyverse)
library(haven) #from tidyverse - for reading in sas7bdat file

##################################################

# Alert! Please set directories:

# Phase 2 prompt directory
phase2_prompt_dir = "/ASU Project/Data_OHSU/Datasets/phase_2_prompt_data.sas7bdat"
events_dir = "/Users/boardmam/Documents/BMI_552B_group_project/events_files"

##################################################

#Prompt data sas file
prompt_data <- read_sas(phase2_prompt_dir)

#events files by subject (each subject will be one dataset)
read_events <- function(wd,subject){
  setwd(wd)
  file_list <- list.files(pattern = subject)
  for(file in file_list){
    if (!exists("dataset")){
      dataset <- activpal.file.reader(file)
    }
    if (exists("dataset")){
      temp_dataset <-activpal.file.reader(file)
      dataset<-rbind(dataset, temp_dataset)
      rm(temp_dataset)
    }
  }
  return(dataset)
}


make_date.time_vec <- function(dataset){
  start_time <- dataset$time[1]
  length <- length(dataset$time)
  end_time <- dataset$time[length]
  x <- as.POSIXct(start_time)
  y <- as.POSIXct(end_time)
  time_fill <- seq.POSIXt(x, y, by="sec") #this is the vector filled with all the times
  time_fill <- as.data.frame(time_fill) #converted to a data frame for merging
  return(time_fill) 
}

clean_prompt <- function(ID){
  events <- read_events(events_dir,paste0("^",ID))
  
  # steps for cleanning
  events <- events[order(events$time),]
  
  events_filtered <- subset(events[events$interval<21600,])
  
  time_fill <- make_date.time_vec(events_filtered)
  
  #Merge to expand events_filtered to include all date/times by second (in order to merge  convert POSIX class to character)
  
  time_fill$time_fill <- as.character(time_fill$time_fill)
  events_filtered$time <- as.character(events_filtered$time)
  events_time_fill <- merge(events_filtered,time_fill,by.x="time",by.y="time_fill",all= TRUE)
  
  #Subset prompt file to include only rows in which prompt was sent and opened (open_status = 1)
  
  prompt <- subset(prompt_data[prompt_data$ID == ID,]) 
  
  prompt <- subset(prompt[prompt$open_status == 1,])
  
  #Merge prompt date column and time column and convert to POSIX format then convert to character in order to create a column to align to the events time column
  
  prompt$date_time <- paste(prompt$Date," ",prompt$time) 
  #convert column to POSIX format
  prompt$date_time <- as.POSIXct(prompt$date_time)
  prompt$date_time <- as.character(prompt$date_time)
  #rename time column so not an issue with merging (events also has a time column)
  colnames(prompt)[12] <- "time_opened"
  
  #THE BIG MERGE
  prompt_events <- merge(events_time_fill,prompt, by.x = "time",by.y = "date_time",all = TRUE)
  
  #Finally remove all rows with no events or prompt data (this are just blank rows left over from the time fill)
  prompt_events <- prompt_events[(!is.na(prompt_events$cumulativesteps)) | (!is.na(prompt_events$Message)),]
  
  ###########################################################
  
  #Determine prompt response intervals
  
  ###########################################################
  
  #Determine what the prompt was, what the activity score was immediately before and immediately after the prompt, and what the date/time was at the prompt and at the first activity after the prompt.
  prompts <- prompt_events$Message #Message vector
  length(prompts)
  prompt_vec <- c() #vector of prompts that were opened
  pre_activity_vec <- c() #vector of activity score immediately before each prompt
  post_activity_vec <- c() #vector of activity score immediately after each prompt
  prompt_time_vec <- c() #vector of date/time occurence of each prompt
  post_time_vec <- c() #vector of date/time occurence of activity immediately after each prompt
  for(i in 2:length(prompts)){
    
    if(!is.na(prompts[i])){
      prompt_vec <- c(prompt_vec,prompt_events$Message[i]) #Produces a list of messages
      
      pre_activity_vec <- c(pre_activity_vec,prompt_events$activity[(i-1)]) #Activities just prior to mesg
      post_activity_vec <- c(post_activity_vec,prompt_events$activity[i+1]) #Activities just after mesgs
      prompt_time_vec <- c(prompt_time_vec,prompt_events$time[i])
      post_time_vec <- c(post_time_vec,prompt_events$time[i+1])
    }
  }
  length(prompt_vec) #28
  length(pre_activity_vec) #28
  length(post_activity_vec) #28
  length(prompt_time_vec) #28
  length(post_time_vec) #28
  
  data.frame(prompt_vec, pre_activity_vec, post_activity_vec, prompt_time_vec, post_time_vec) -> data_vec
  
  na.omit(data_vec) -> data_vec_v2

  effective_prompt_vec <- vector("list",nrow(data_vec_v2))
  time_interval_vec <- vector("list", nrow(data_vec_v2))
  for(i in 1:nrow(data_vec_v2)){
    if(data_vec_v2$pre_activity_vec[i] < data_vec_v2$post_activity_vec[i]){
      effective_prompt_vec[[i]] <- as.character(data_vec_v2$prompt_vec[i])
      time_interval_vec[[i]] <- as.vector(as.POSIXct(data_vec_v2$post_time_vec[i]) - as.POSIXct(data_vec_v2$prompt_time_vec[i]))
    }
  }
  

  #now I have a vector of effective prompts and a vector of their positive action time intervals
  data.frame(effective_prompt_vec=unlist(effective_prompt_vec), time_interval_vec=unlist(time_interval_vec)) -> data
  
  data$ID = ID
  
  return(data)
}

IDs <- c(102:118)
IDs2 <- IDs[IDs!=105]
full_data <- vector("list",length(IDs2))

for(i in 1:length(full_data)){
  print(i)
  data1 <- clean_prompt(IDs2[i])
  full_data[[i]] <- data1
}

full_events_data <- do.call(rbind, full_data)

write.table("prompt_data.txt", x=full_events_data, sep="\t", quote=F, row.names=F)

