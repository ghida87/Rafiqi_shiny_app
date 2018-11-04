library('shiny')
library('rdrop2')

fields_1 <- c("email","age","country", "degree", "entrepreneur","background","job_readiness","en_level","loc_lan_level","digital_level")
fields_2 <- c("email","age","country", "degree", "entrepreneur","background","job_readiness","en_level","loc_lan_level","digital_level","consent","rating","feedback")
source("match_algo_v5.R")


shinyServer(
  function(input, output) {
  
   observeEvent(input$action, {output$value <- renderPrint({process_inputs(input$country,input$degree,input$entrepreneur,input$background,input$job_readiness, input$en_level,input$loc_lan_level,input$digital_level)},quoted = FALSE)
  })
    
    observeEvent(input$action, {
      saveData_1(formData_1())
    })
    
    formData_1 <- reactive({
      data <- sapply(fields_1, function(x) input[[x]])
      data
    })
    
    formData_2 <- reactive({
      data <- sapply(fields_2, function(x) input[[x]])
      data
    })
    

    observeEvent(input$submit, {
      saveData_2(formData_2())
    })
    
    outputDir_1 <- "responses_1"
    outputDir_2 <- "responses_2"
    
    saveData_1 <- function(data) {
      data <- t(data)
      # Create a unique file name
      fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
      # Write the data to a temporary file locally
      filePath <- file.path(tempdir(), fileName)
      write.csv(data, filePath, row.names = FALSE, quote = TRUE)
      # Upload the file to Dropbox
      drop_upload(filePath, path = outputDir_1)
    }
    
    saveData_2 <- function(data) {
      data <- t(data)
      # Create a unique file name
      fileName <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
      # Write the data to a temporary file locally
      filePath <- file.path(tempdir(), fileName)
      write.csv(data, filePath, row.names = FALSE, quote = TRUE)
      # Upload the file to Dropbox
      drop_upload(filePath, path = outputDir_2)
    }
    
   
    
  
    
    
    }
)

  








