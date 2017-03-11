#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("World Population : 1960-2015"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      uiOutput('year_ui'),
      uiOutput('filter_range_ui')
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(

        tabPanel("Leaflet",
                 leafletOutput("mymap"),
                 dataTableOutput("pop_data_datatable")),
        tabPanel("Read Me",
                 includeMarkdown("DDP-About.md"))
      )
    )
  )
))
