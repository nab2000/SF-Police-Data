library(shiny)
library(leaflet)

categories <- read.csv("categories.csv")
names(categories) <- NULL
categories <- categories[,1]
years <- as.factor(2003:2015)
shinyUI(
    navbarPage("SF Crime", id = "SF Crime",
               tabPanel("Map",
    leafletOutput("map", height = "550px"),
    
    
    absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                  draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                  width = 280, height = "auto",
                  conditionalPanel(
                      condition="$('html').hasClass('shiny-busy')",
                      tags$h3("Shiny seems busy...")
                  ),
                  column(10, offset = 0,
                         h4("Select Crimes and Years to Evaluate"),
                         p(),
                         ##textOutput("pds"),
                         radioButtons("pd", "Evaluate Data by PD District?",
                                      c("Yes", "No"), selected = "Yes",inline = T),
                         conditionalPanel(condition= 'input.pd == "Yes"',
                             radioButtons("color", "Color by Crime?",c("Yes", "No"), 
                                          selected = "No",inline = T)),
                         conditionalPanel(condition= 'input.pd == "Yes" & 
                                              input.color == "Yes"', 
                             selectInput("color.cat", "Crime", categories, categories[1],
                                         width = 300, multiple = F)
                         ),
                         conditionalPanel(condition= 'input.pd == "Yes" & 
                                              input.color == "No" | input.pd == "No"',
                                          selectInput("cat", "Crimes", categories, 
                                                      categories[1],
                                                      width = 300, multiple = T)
                         ),
                         selectInput("year", "Years", years, years[1],
                                     width = 300, multiple = T),
                         actionButton("map", "Map Crime",
                                      icon = icon("globe", lib = "glyphicon")),
                         p()
                  )
                  
                  )
               ),
    tabPanel("Table",
             DT::dataTableOutput("table"))
    )
)