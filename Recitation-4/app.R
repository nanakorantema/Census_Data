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
                             c("Option A" = "a", "Option B" = "b")
                         )),
                     mainPanel(plotOutput("map")))
             )),
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
  racevars <- c(White = "B02001_002", 
                Black = "B02001_003", 
                Asian = "B02001_005",
                Hispanic = "B03003_003")
  Orange <- get_acs(geography = "tract",
                    variables = racevars, 
                    year = 2018,
                    state = "CA",
                    county = "Orange County",
                    geometry = TRUE,
                    summary_var = "B02001_001") 
  output$map <- renderPlot({Orange %>%
      mutate(Percent = 100 * (estimate / summary_est)) %>%
      ggplot(aes(fill = Percent, color = Percent)) +
      facet_wrap(~ variable) +
      geom_sf() +
      scale_fill_viridis_c(direction = -1) +
      scale_color_viridis_c(direction = -1) +
      labs(title = "Racial geography of Orange County, California",
           caption = "Source: American Community Survey 2014-2018") +
      theme_void()
  })
}



# Run the application 
shinyApp(ui = ui, server = server)
