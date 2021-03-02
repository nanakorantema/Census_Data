#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidycensus)
library(tidyverse)
library(shinythemes)

# Define UI for application 
ui <- navbarPage(
    "Final Project Title",
    tabPanel("Model",
             fluidPage(theme = shinytheme("cyborg"),
                 titlePanel("Model Title"),
                 sidebarLayout(
                     sidebarPanel(
                         selectInput(
                             "plot_type",
                             "Plot Type",
                             c("Orange County" = "a", "New York County" = "b")
                         )),
                     mainPanel(imageOutput("map"))))),
    tabPanel("Discussion",
             titlePanel("Discussion Title"),
             p("Tour of the modeling choices you made and 
              an explanation of why you made them")),
    tabPanel("About", 
             titlePanel("About"),
             h3("Project Background and Motivations"),
             p("Hello, this is a practice shiny app that I have created for my data course"),
             h3("About Me"),
             p("My name is Nana-Korantema Koranteng and I study the Middle East. 
             You can reach me at nanakorantema_koranteng@g.harvard.edu.")))

# Define server logic required to draw a histogram


server <- function(input, output) {
  
  output$map <- renderImage({
    if(input$plot_type == "a"){            
      list(
        src = "map.png",
        width = 500,
        height = 500,
        alt = "Orange County Map")
    }                                        
    else if(input$plot_type == "b"){
      list(
        src = "map_2.png",
        width = 500,
        height = 500,
        alt = "New York County Map")
    }
  })
}


 



# Run the application 
shinyApp(ui = ui, server = server)
