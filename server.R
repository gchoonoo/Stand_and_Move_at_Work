library(shiny)
library(ggplot2)

# setwd("/Users/Gabby/Desktop/research methods/project_app")

## Load Data -- loads all_weight_cs dataframe
# load('gale_lund_scores_7-Feb-2017_final.rda')
# load('gale_lund_weight_7-Feb-2017_final.rda')
# load("phenotype_list_2_15_17.RData")
# options(warn=-1)

load("shiny_data_v2.rda")

all_subjects = unique(shiny_data[,"ID"])

# Define server logic required to draw a heatmap
shinyServer(function(input, output, session) {
	# Plot will be drawn only when action button is pressed
	# this avoids many re-draws when selecting multiple variables
	
	output$distPlot1 = renderPlot({
	  
	  if(input$type == 1){
	    par(mfcol=c(3,2), xpd=T)
	    
	    #Phase 1 plots
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Sedentary Phase 1", ylim=c(0,100))
	    
	    legend("topleft", legend=all_subjects, inset=c(0,-.1), col=cols_v2, horiz=T,cex=.6, lty=2, lwd=2, pch=19)
	    
	    for(i in input$subjects){
	      lines(shiny_data[which(shiny_data[,"ID"] == i),"percent_0"], type="b",col=cols_v2[i], pch=19)
	      
	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Standing Phase 1", ylim=c(0,100))
	    for(i in input$subjects){
	      lines(shiny_data[which(shiny_data[,"ID"] %in% i),"percent_1"], type="b",col=cols_v2[i],pch=19)    
	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Percent", main="Percent Stepping Phase 1", ylim=c(0,100))
	    for(i in input$subjects){
	      lines(shiny_data[which(shiny_data[,"ID"] %in% i),"percent_2"], type="b",col=cols_v2[i],pch=19)      
	    }
	    
	    # Phase 2
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Percent", main="Percent Sedentary Phase 2", ylim=c(0,100))
	    
	    legend("topleft", legend=all_subjects, inset=c(0,-.1), col=cols_v2, horiz=T,cex=.6, lty=2, lwd=2, pch=19)
	    
	    
	    #legend("topleft", input$subjects, fill=cols_v2)
	    
	    for(i in input$subjects){
	      lines(shiny_data_v2[which(shiny_data_v2[,"ID"] == i),"percent_0"], type="b",col=cols_v2[i], pch=19)
	      
	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Percent", main="Percent Standing Phase 2", ylim=c(0,100))
	    for(i in input$subjects){
	      lines(shiny_data_v2[which(shiny_data_v2[,"ID"] %in% i),"percent_1"], type="b",col=cols_v2[i],pch=19)    
	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Percent", main="Percent Stepping Phase 2", ylim=c(0,100))
	    for(i in input$subjects){
	      lines(shiny_data_v2[which(shiny_data_v2[,"ID"] %in% i),"percent_2"], type="b",col=cols_v2[i],pch=19)      
	    }
	  }else{
	    # hours
	    par(mfcol=c(3,2), xpd=T)
	    
	    if(input$max){
	      max1=max(shiny_data[,"hours_0"])
	    }else{
	      max1=25
	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Number of Hours", main="Number of Hours Sedentary Phase 1", ylim=c(0,max1))
	    
	    legend("topleft", inset=c(0,-.1), legend=all_subjects, col=cols_v2, horiz=T,cex=.6, lty=2, lwd=2, pch=19)
	    
	    
	    #legend("topleft", input$subjects, fill=cols_v2)
	    
	    for(i in input$subjects){
	      lines(shiny_data[which(shiny_data[,"ID"] == i),"hours_0"], type="b",col=cols_v2[i], pch=19)
	      
	    }
	    
	    if(input$max){
	      max2=max(shiny_data[,"hours_1"])
	    }else{
	      max2=25

	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Number of Hours", main="Number of Hours Standing Phase 1", ylim=c(0,max2))
	    for(i in input$subjects){
	      lines(shiny_data[which(shiny_data[,"ID"] %in% i),"hours_1"], type="b",col=cols_v2[i],pch=19)    
	    }
	    
	    if(input$max){
	      max3=max(shiny_data[,"hours_2"])
	    }else{
	      max3=25

	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,23), ylab="Number of Hours", main="Number of Hours Stepping Phase 1", ylim=c(0,max3))
	    for(i in input$subjects){
	      lines(shiny_data[which(shiny_data[,"ID"] %in% i),"hours_2"], type="b",col=cols_v2[i],pch=19)      
	    }
	    
	    #Phase 2
	    
	    if(input$max){
	      max4=max(shiny_data_v2[,"hours_0"])
	    }else{
	      max4=25

	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Number of Hours", main="Number of Hours Sedentary Phase 2", ylim=c(0,max4))
	    
	    legend("topleft", inset=c(0,-.1), legend=all_subjects, col=cols_v2, horiz=T,cex=.6, lty=2, lwd=2, pch=19)
	    
	    
	    #legend("topleft", input$subjects, fill=cols_v2)
	    
	    for(i in input$subjects){
	      lines(shiny_data_v2[which(shiny_data_v2[,"ID"] == i),"hours_0"], type="b",col=cols_v2[i], pch=19)
	      
	    }
	    
	    if(input$max){
	      max5=max(shiny_data_v2[,"hours_1"])
	    }else{
	      max5=25

	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Number of Hours", main="Number of Hours Standing Phase 2", ylim=c(0,max5))
	    for(i in input$subjects){
	      lines(shiny_data_v2[which(shiny_data_v2[,"ID"] %in% i),"hours_1"], type="b",col=cols_v2[i],pch=19)    
	    }
	    
	    if(input$max){
	      max6=max(shiny_data_v2[,"hours_2"])
	    }else{
	      max6=25

	    }
	    
	    plot(NA, type="b", col="red",xlab="Day",xlim=c(1,31), ylab="Number of Hours", main="Number of Hours Stepping Phase 2", ylim=c(0,max6))
	    for(i in input$subjects){
	      lines(shiny_data_v2[which(shiny_data_v2[,"ID"] %in% i),"hours_2"], type="b",col=cols_v2[i],pch=19)      
	    }
	    
	  }
	  
	 
	  
	})
	
	output$prompt_plot <- renderPlot({
	  p <- ggplot(data_v8, aes(Prompt, Percentage, fill = data_v8$fill),legend = NULL)
	  p + geom_bar(stat="identity") + coord_flip() + labs(title = "Percentage of subjects that responded to each prompt (N=16)", x=NULL,y="Percent") + theme(legend.position="none",text = element_text(size=18))
	})
	
	output$prompt_plot2 <- renderPlot({
	  p <- ggplot(full_events_data, aes(x=reorder(effective_prompt_vec,-time_interval_vec,FUN=median),y=time_interval_vec,fill = full_events_data[,5]),legend = NULL)
	  p + geom_boxplot() + coord_flip() + labs(title = "Distribution of Time to Action for Each Prompt", x=NULL,y="Time Interval (s)") + theme(legend.position="none",text = element_text(size=18))
	  
	})
	
	output$norm_plot <- renderPlot({
	  
	  normalize_data_function(var=input$prompt, type=input$type2)
	  
	  # if(input$type2 == 1){
	  #   normalize_data_log(input$prompt)
	  # }else if (input$type2 == 2){
	  #   normalize_data_scale(input$prompt)
	  # }
	  
	})
	
	output$statm = renderText({
	  "Testing the significant difference in Time to Action within each Prompt - using log transformed data"
	})
	
		output$stat = renderPrint({
		  
		  stat_test = kruskal.test(time_interval_vec_log ~ effective_prompt_vec, data=full_events_data)
		  stat_test
		  
		})
		
		output$statm2 = renderText({
		  "Testing the significant difference in proportion of subjects that responded positively to each prompt"
		})
		
		output$stat2 = renderPrint({
		  
		  stat_test2 = chisq.test(summary(data_v2[,1]), correct=F, simulate.p.value=T)
		  stat_test2
		  
		})
	
# 	
# 	output$message = renderText({
# 		if (length(input$uw_lines) < 1) {
# 			return("You must select at least one line.")
# 		}
# 		if (is.null(uw_line_list())) {
# 			return("No data available.")
# 		}
# 	})
})
