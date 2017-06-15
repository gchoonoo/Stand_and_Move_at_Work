##########################################################

# Stand and Move at Work - Prompt Data

##########################################################

# Libraries
library(ggplot2)

##########################################################

load("shiny_data.rda")

read.table("prompt_data.txt",header=T) -> full_events_data

##########################################################

# number of subjects that responded to each prompt
unique(full_events_data[,c(2,4)]) -> data_v2

# barplot
summary(data_v2[,1])/length(unique(data_v2[,2])) -> data_v3

data.frame(Prompt=names(data_v3), Percentage=data_v3) -> data_v4

data_v4[order(data_v4[,"Percentage"]),] -> data_v5

tapply(full_events_data$time_interval_vec, full_events_data$effective_prompt_vec, median) -> medians

data.frame(Prompt=names(medians[order(medians)]),median=medians[order(medians)]) -> medians_v2

merge(data_v5, medians_v2, by="Prompt", all.x=T) -> data_v6

data_v6[order(data_v6[,"median"]),] -> data_v7

colors = data.frame(Prompt=row.names(data_v5),fill=c("#F8766D", "#CD9600", "#7CAE00", "#00BE67","#00BFC4", "#00A9FF", "#C77CFF", "#FF61CC"))

merge(data_v7, colors, by="Prompt",all.x=T) -> data_v8

data_v8$Prompt <- factor(data_v8$Prompt, levels=data_v8$Prompt[order(data_v8$median, decreasing=T)])

p <- ggplot(data_v8, aes(Prompt, Percentage, fill = data_v8$fill),legend = NULL)
p + geom_bar(stat="identity") + coord_flip() + labs(title = "Percentage of subjects that responded to each prompt (N=16)", x=NULL,y="Percent") + theme(legend.position="none",text = element_text(size=18))

##########################################################

names(colors)[1] <- "effective_prompt_vec"
merge(full_events_data, colors, by="effective_prompt_vec", all.x=T) -> full_events_data

# plot of overall time to movement for each prompt
p <- ggplot(full_events_data, aes(x=reorder(effective_prompt_vec,-time_interval_vec,FUN=median),y=time_interval_vec,fill = full_events_data[,5]),legend = NULL)
p + geom_boxplot() + coord_flip() + labs(title = "Distribution of Time to Action for Each Prompt", x=NULL,y="Time Interval (s)") + theme(legend.position="none",text = element_text(size=18))

# Normalization of Data
normalize_data_log <- function(var){
  
  par(mfrow=c(2,2))
  
  hist(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var], main=paste(var, "raw"), xlab="")
  
  hist(log(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]), main=paste(var,"log"), xlab="")
  
  qqnorm(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var], main="QQ raw",xlab="")
  qqline(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var])
  
  if(sum(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var] == 0) > 0){
    log(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]) -> x
    x[which(x=="-Inf")] <- NA
    qqnorm(x, main="QQ Log", xlab="")
    qqline(log(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]))
  }else{
    qqnorm(log(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]), main="QQ Log", xlab="")
    qqline(log(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]))
  }
  
  
  
  
}

normalize_data_scale <- function(var){
  
  par(mfrow=c(2,2))
  
  hist(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var], main=paste(var, "raw"), xlab="")
  
  hist(scale(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]), main=paste(var,"scale"), xlab="")
  
  qqnorm(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var], main="QQ raw",xlab="")
  qqline(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var])
  
  qqnorm(scale(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]), main="QQ scale", xlab="")
  qqline(scale(full_events_data$time_interval_vec[full_events_data$effective_prompt_vec == var]))
  
}

full_events_data$time_interval_vec_log = log(full_events_data[,"time_interval_vec"])

# Non significant results, using non-parametric since uniformly distributed rather than normal
#stat_test = kruskal.test(time_interval_vec_log~effective_prompt_vec, data=full_events_data)

save.image("shiny_data_v2.rda")




