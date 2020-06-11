library(shiny)



shinyUI(fluidPage(
    
    titlePanel("Dashboard App"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                inputId = "Opened_shops",
                label = "Choose year",
                choiceNames = list('2012', '2013', '2014'),
                choiceValues = list('2012', '2013', '2014')
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
                inputId = "categories",
                label = "Choose catgory to display sales for 2014:",
                choices = list_of_categories[c(1,4,13,14,15,16), ],
                selected = ""
            )
        ),
        mainPanel(plotOutput("cat_sales"))
    ),
    
    
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider", label = "Slide between area income", min = 1,
                        max = 7, value = c(2,4), step = 1)
        ),
        mainPanel(plotOutput("opened_shops"))
    )
))

