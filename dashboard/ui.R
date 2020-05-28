library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Dashboard App"),
    
    navlistPanel(
        tabPanel("Wykres 1",
                 h3("Tu mozna dac jakis wykres")),
        tabPanel("Wykres 2",
                 h3("Tu mozna dac jakis wykres"))
        ),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                inputId = "rb",
                label = "Choose year",
                choiceNames = list('2012', '2013', '2014'),
                choiceValues = list('2012', '2013', '2014')
            )
        ),
        mainPanel(plotOutput("plt"))
        ),
        sidebarLayout(
            sidebarPanel(
                checkboxGroupInput(
                    inputId ='checkBx',
                    label = "District Manager",
                    choiceNames = (list("Name1", "Name2", 'Name3')),
                    choiceValues = (list("Name1", "Name2", 'Name3'))
                )
            ),
            mainPanel(plotOutput("plt2"))
        ),
    sidebarLayout(
        sidebarPanel(
            sliderInput("slider", label = "Interval - np lata, miesiace itd", min = 1,
                        max = 10, value = c(2,4), step = 0.5)
        ),
        mainPanel(
            plotOutput("sldplot")
        )
    )
))

