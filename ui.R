library(shiny)
library(ggplot2)

# Define UI for application
## Load Data -- loads all_weight_cs dataframe
# load('gale_lund_scores_7-Feb-2017_final.rda')
# load('gale_lund_weight_7-Feb-2017_final.rda')
# load("phenotype_list_2_15_17.RData")

load("shiny_data_v2.rda")

all_subjects = unique(shiny_data[,"ID"])

# no_disease = pheno_list$`no disease`
# early_susceptibility = pheno_list$`early susceptibility`
# normal_disease = pheno_list$`normal disease`
# extended_disease = pheno_list$`extended disease`

shinyUI(fluidPage(
	tags$head(tags$style(".rightAlign{float:right;}")),
	tags$head(tags$style(".bigMargin{margin-bottom:20px;}")),
	# Application title
	titlePanel("activPAL Data Visualization"),
	
	# Sidebar
	sidebarLayout(
		sidebarPanel(
			#actionButton('update', "Create Plot", class='bigMargin'),
			#radioButtons('pheno_cat', "Phenotype Categories (as of 2/15/2017)", choices=c("No Disease"=1, "Normal Disease"=2, "Extended Disease"=3, "Early Susceptibility"=4, "Custom List"=5), selected=5),
		  conditionalPanel(
		    condition = "input.tabs == 'overall_act'",
			  selectizeInput('subjects', "Subjects", choices=all_subjects, selected=all_subjects[1:10], multiple=TRUE),
			  radioButtons('type', "Data Type", choices=c("Percentage"=1, "Hours"=2),selected=1)),
		  conditionalPanel(
		    condition="input.type == '2'",checkboxInput('max', "Modify Y-axis", value=FALSE)),
		  conditionalPanel(
		    condition = "input.tabs == 'norm'",
		    selectizeInput("prompt","Prompt", choices=unique(full_events_data[,1]), selected=1),
		  radioButtons("type2", "Normalization Type", choices=c("Log"="log", "Scale"="scale", "Square Root" = "sqrt", "Cubic" = "cubed"), selected="log"))
		),

		# Main panel with error message and plot
		mainPanel(
		  tabsetPanel(
		    id = 'tabs',
			  tabPanel(value="overall_act","Overall Activity",plotOutput("distPlot1", width='100%', height="675px")),
			  tabPanel("Prompt Data",plotOutput("prompt_plot2"),plotOutput("prompt_plot")),
			  tabPanel(value="norm","Normalization", plotOutput("norm_plot")),
			  tabPanel("Statistical Analysis", verbatimTextOutput("statm"),textOutput("stat"),verbatimTextOutput("statm2"),textOutput("stat2"))
		)
	)
)))
