#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  df <- as_tibble(read.csv("popdata_cleaned.csv"))
  
  pop_data <- reactive({
    
    df <- df
    col_num <- input$yearvalue
  
    
    
    df <- cbind(df[,1:2],df[,col_num],df[,((ncol(df)-1):ncol(df))])
    
    
    
    
    return(df) #Return cleaned data with actual countries only with the corresponding geocodes added
    
  })
  
  
  
  
  output$pop_data_datatable <- renderDataTable({
    
    df <- pop_data() %>%
      select(-(lon:lat))
    
    if(!is.null(input$range)){
      check_index <- (df[,3] >= input$range[1] &
                        df[,3] <= input$range[2])
      
      df <- df[check_index,]
    }
    
  })
  
  
  
  output$year_ui <- renderUI({
    selectInput("yearvalue",
                label = "Select the year to display its population info:",
                choices = colnames(df[,(3:(ncol(df)-2))]))
  })
  
  
  
  output$filter_range_ui <- renderUI({
    df <- pop_data()
    
      range <- range(df[,3], na.rm = TRUE)
      sliderInput("range", "Population Range of Interest:",
                  min = range[1], max = range[2],
                  value = c(range[1],range[2]), step = round((range[2]-range[1])/100),4)
    })
  
  output$mymap <- renderLeaflet({
    df <- pop_data()
    
    if(!is.null(input$range)){
      check_index <- (df[,3] >= input$range[1] &
                        df[,3] <= input$range[2])
      
      df <- df[check_index,]
    }
    
    df %>%
    leaflet() %>%
      addTiles() %>%
      addCircles(weight = 1, radius = sqrt(df[,3])*30, 
                 popup = paste0(df[,1]," = ",df[,3]))
  })
  
  
  
  
  
  
})
