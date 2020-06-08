library(shiny)



shinyUI(fluidPage(
    
    titlePanel("Dashboard App"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                inputId = "sales_by_year",
                label = "Choose year",
                choiceNames = list('2013', '2014'),
                choiceValues = list('2013', '2014')
            )
        ),
        mainPanel(plotOutput('plt1'))
    ),
    
    navlistPanel(
        tabPanel("Top five stores",
                 plotOutput('top_sales')),
        
        tabPanel("Bottom five stores",
                 plotOutput('bottom_sales'))
    ),

    
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = "list_managers",
                label = "Managers:",
                choices = list_of_managers,
                selected = ""
            )
        ),
        mainPanel(textOutput("stores"))
    ),
    
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider", label = "Interval - np lata, miesiace itd", min = 1,
                        max = 10, value = c(2,4), step = 0.5)
        ),
        mainPanel(
           
        )
    )
))

