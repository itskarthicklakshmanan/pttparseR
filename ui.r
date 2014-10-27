########################################################################
# Script written and maintained by:
# Karthick L
# PhD student
# Bioinformatics Division
# National Facility of Marine Cyanobacteria (NFMC)
# Bhanrathidasan University
# Trichy
# email: karthick.lakshman@gmail.com
########################################################################
library(shiny)
shinyUI(navbarPage("Visualize PTT files",
  tabPanel("File",tags$style(type='text/css', ".span4 { max-width: 400px; }"),
    sidebarLayout(
      sidebarPanel(tags$head(tags$style(type="text/css", "
             div.busy {
  position:absolute;
  top: 40%;
  left: 50%;
  margin-top: -100px;
  margin-left: -50px;
  display:none;
  background: rgba(230, 230, 230, .8);
  text-align: center;
  padding-top: 20px;
  padding-left: 30px;
  padding-bottom: 40px;
  padding-right: 30px;
  border-radius: 5px;
}

          "),includeScript("www/binder.js")),tags$style(type='text/css', "#url_ptt { min-width: 350px; }"),radioButtons("link_choice", "Link type:",choices = c("Url Link", "Local File")),
        conditionalPanel(
    condition = "input.link_choice=='Url Link'",textInput("url_ptt", "Add Link","Acaryochloris_marina_MBIC11017_uid58167/NC_009930.ptt")),conditionalPanel(
    condition = "input.link_choice=='Local File'",
	fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
								 'text/comma-separated-values,text/plain', 
								 '.csv'))),
	
	actionButton("url_ptt1", "Run")
      ),
      mainPanel(div(class = "busy", p("Calculation in progress.."), img(src="https://cloud.githubusercontent.com/assets/1396943/4787758/46c8a214-5db0-11e4-854a-1e6a66738aec.gif")),
        dataTableOutput("table")
      )
    )
  ),
  tabPanel("Plot",tags$style(type='text/css', "#plot { min-height: 550px; }"),tags$style(type='text/css', "#track { min-height: 250px; }"),
  div(class = "busy", p("Calculation in progress.."), img(src="https://cloud.githubusercontent.com/assets/1396943/4787758/46c8a214-5db0-11e4-854a-1e6a66738aec.gif")),
      plotOutput("plot"),fluidRow(column(2,textInput("pc","Plus strand color","red")),column(2,textInput("mc","minus strand color","blue"))),
	  fluidRow(column(2,numericInput("gstart","Genome start",1000)),column(2,numericInput("gend","Genome end",8000))),
    
 checkboxInput("tset","Select Track",FALSE),conditionalPanel(
    condition = "input.tset",fluidRow(column(2,selectInput("cluster", "",choices=c("manual entry","upload tracks")))), 
	  wellPanel(fluidRow(column(2,checkboxInput("track1", "Track1",FALSE)),column(2,numericInput("astart","Genome start",1000)),column(2,numericInput("aend","Genome end",4000)),column(2,textInput("anno","annotation","annotation 1")),column(2,fileInput('file2', 'Track1 file', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))))),
	  wellPanel(fluidRow(column(2,checkboxInput("track2", "Track2",FALSE)),column(2,numericInput("astart1","Genome start",4000)),column(2,numericInput("aend1","Genome end",5000)),column(2,textInput("anno1","annotation","annotation 2")),column(2,fileInput('file3', 'Track2 file', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv'))))),
	  wellPanel(fluidRow(column(2,checkboxInput("track3", "Track3",FALSE)),column(2,numericInput("astart2","Genome start",6000)),column(2,numericInput("aend2","Genome end",8000)),column(2,textInput("anno2","annotation","annotation 3")),column(2,fileInput('file4', 'Track3 file', accept=c('text/csv', 'text/comma-separated-values,text/plain', '.csv')))))
	  
	  ),
	  actionButton("execute", "Run",icon = icon("fa fa-refresh")),
	  actionButton("refr", "Refresh",icon = icon("fa fa-refresh"))
    
  )
))
