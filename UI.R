library(shiny)


shinyUI(
  
  fluidPage(
    
    sidebarPanel(
        
        selectInput("country", label = h5("Current country of Residence"), 
                    choices = list("Germany" = 1, "France" = 2, "Netherlands" = 3, "Jordan" = 4, "Switzerland" = 5, "UK" = 6, "Sweden" = 7, "Spain" = 8, "Denmark" = 9), 
                    selected = 1),
        
        # Copy the line below to make a set of radio buttons
        radioButtons("degree", label = h5("Highest degree obtained"),
                     choices = list("Bachelor" = 1, "Associate degree/certificate" = 2, "Masters or higher" = 3,"I do not have any degrees" = 4), 
                     selected = 1),
        
        radioButtons("entrepreneur", label = h5("Are you an existing or aspiring entrepreneur"),
                     choices = list("YES" = 1, "NO" = 2), 
                     selected = 1),
        
        
        selectInput("background", label = h5("Which of the followings describe the best your education and/or work background?"),
                     choices = list("IT support & Networking" = 1, "Web/Mobile/Software development" = 2, "Data Analytics" = 3,"Artificial Intelligence" = 4,
                                    "Healthcare Professional (doctor, nurse...)"=5, "Non IT Engineer" = 6, "Skilled trades (cook, housekeeper, plumber, electrician, agricultor)"= 7, 
                                    "Teaching" = 8, "Digital Marketing" = 9, "Sales & Customer Service"= 10, "Artistic & Creative vocations (painter, poet, producer, actor...)"=11,
                                    "Content Manager (Writer, translator, content creator)" = 12, "Legal" = 13, "Political & social sciences" = 14, "social worker" = 15, "Accounting & finance" = 16,
                                    "Business & Management" = 17, "Scientific Research" = 18, "Research(other)"  = 19, "Other" = 20), 
                     selected = 1),
        
        radioButtons("job_readiness", label = h5("Assess your job readiness"),
                     choices = list("I lost all my domain knowledge" = 1, "I need to refresh my knowledge" = 2, "my skills are intact & I am fully ready for work" = 3), 
                     selected = 1),
        
        sliderInput("en_level", label = h5("English Level (10 is fluent, 1 is no knowledge)"), min = 1, 
                    max = 10, value = 5),
        
        sliderInput("loc_lan_level", label = h5("Local language Level (e.g. French if you live in France)"), min = 1, 
                    max = 10, value = 5),
        
        sliderInput("digital_level", label = h5("How comfortable are you with using digital tools? (email, e-learning websites, social media)"), min = 1, 
                    max = 10, value = 5),
        
        actionButton("action", label = "Explore!")
        
    ),
        mainPanel(
          verbatimTextOutput("value")
          
        )
      ) 
      
)     
      

