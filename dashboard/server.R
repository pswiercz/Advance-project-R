library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)

source("data_manipulation.r")
options(scipen = 999)


months <- c("January", "February", "March", "April", "May", "June", "July", "August")
# current_path <- rstudioapi::getSourceEditorContext()$path
# setwd(strsplit(current_path, "/")[[1]][1:(length(strsplit(current_path, "/")[[1]])-2)] %>% paste(collapse="/"))
# print(getwd())


shinyServer(function(input, output) {
    
    output$plt1 <- renderPlot(
        {
            if(input$sales_by_year == '2013'){
                ggplot
                
            }
            else if(input$sales_by_year == '2014'){
                
            }
            else{
                NULL
            }
        })
    
    output$top_sales <- renderPlot(
        ggplot(top_sales) + aes_(x = top_sales$Name, y = top_sales$Revenue)
        + geom_bar(stat="identity", fill = 'darkgreen') + ggtitle("Five stores with the highest revenue")
        + xlab("Name of the store") + ylab("Revenue") + theme(plot.title = element_text(size = 20, hjust = 0.5)))
   
    output$bottom_sales <- renderPlot(
        ggplot(bottom_sales) + aes_(x = bottom_sales$Name, y = bottom_sales$Revenue)
        + geom_bar(stat="identity", fill = '#990000')  + labs(title="Five stores with the lowest revenue",
             x = "Name of the store", y = "Revenue") + theme(plot.title = element_text(size = 20, hjust = 0.5)))
    
    
    output$cat_sales <- renderPlot(
     
        if(input$categories == "090-Home"){
            ggplot(home) + aes(x = home$Month, y = home$'090-Home' ) + geom_line()
            
        }
        else if(input$categories == "080-Accessories"){
            ggplot(accessories) + aes(x = accessories$Month, y = accessories$"080-Accessories" ) + geom_line()
            
        }
        else if(input$categories == "020-Mens"){
            ggplot(Mens) + aes(x = Mens$Month, y = Mens$"020-Mens") + geom_line()
            
        }
        else if(input$categories == "010-Womens"){
            ggplot(Womens) + aes(x = Womens$Month, y = Womens$'010-Womens' ) + geom_line()
           
        }
        else if(input$categories == "040-Juniors"){
            ggplot(Juniors) + aes(x = Juniors$Month, y = Juniors$'040-Juniors' ) + geom_line()
           
        }
        else if(input$categories == "030-Kids"){
            ggplot(Kids) + aes(x = Kids$Month, y =Kids$"030-Kids" ) + geom_line()
            
        }
    )
                                                            


    data_filtered <- reactive({open_shops %>%
            filter(
                between(Month, input$slider[1], input$slider[2])
            )
    })
    
    output$opened_shops <- renderPlot({
            ggplot(open_shops) +    aes(x = data_filtered(), y = open_shops$Lindseys) +
            geom_bar(stat="identity", fill = 'yellow')
    })
    
    
})



