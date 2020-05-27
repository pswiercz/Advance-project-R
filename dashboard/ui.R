library(shiny)

shinyUI(fluidPage(

    titlePanel("Dashboard App"),
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
    )
)
)

