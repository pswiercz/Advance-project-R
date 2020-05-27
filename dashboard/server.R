library(tidyverse)
library(shiny)

#Here is place for data inputing
data <- iris
#I use iris as mock data


shinyServer(function(input, output) {
    output$plt <- renderPlot({
        if (input$rb == '2012') {
            ggplot(data) + aes_(iris$Sepal.Length, iris$Sepal.Width) + geom_point()
        }
        else if(input$rb == '2013'){
            ggplot(data) + aes_(iris$Petal.Length) + geom_bar()
        }
        else if(input$rb == '2014'){
            ggplot(data) + aes_(iris$Petal.Width) + geom_histogram()
        }
        else{
            NULL
        }
    })
    
    output$plt2 <- renderPlot({
        if(input$checkBx == 'Name1'){
            ggplot(data) + aes_(iris$Sepal.Length) + geom_bar()
        }
        #...
        else{
            NULL
        }
    })


})
