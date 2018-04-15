library(shiny)
library(rdrop2)

fields <- c("email","country", "degree", "entrepreneur","background","job_readiness","en_level","loc_lan_level","digital_level","rating")
source("match_algo_v5.R")


shinyServer(
  function(input, output) {
  
   
   observeEvent(input$action, {output$value <- renderPrint({process_inputs(input$country,input$degree,input$entrepreneur,input$background,input$job_readiness, input$en_level,input$loc_lan_level,input$digital_level)},quoted = FALSE)
  })
    
    formData <- reactive({
      data <- sapply(fields, function(x) input[[x]])
      data
    })
    

    observeEvent(input$submit, {
      saveData(formData())
    })
    
    outputDir <- "responses"
    
    saveData <- function(data) {
      data <- t(data)
      # Create a unique file name
      fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
      # Write the data to a temporary file locally
      filePath <- file.path(tempdir(), fileName)
      write.csv(data, filePath, row.names = FALSE, quote = TRUE)
      # Upload the file to Dropbox
      drop_upload(filePath, path = outputDir)
    }
    
   
    
  
    
    
    }
)
  








