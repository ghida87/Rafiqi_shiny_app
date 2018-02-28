library(shiny)

source("match_algo_v5.R")


shinyServer(
  function(input, output) {
  
    
   observeEvent(input$action, {output$value <- renderPrint({process_inputs(input$country,input$degree,input$entrepreneur,input$background,input$job_readiness, input$en_level,input$loc_lan_level,input$digital_level)},quoted = FALSE)
    
  })
  
  }
)
  








