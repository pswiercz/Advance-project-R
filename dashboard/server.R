library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)

source("data_manipulation.r")
options(scipen = 999)


# current_path <- rstudioapi::getSourceEditorContext()$path
# setwd(strsplit(current_path, "/")[[1]][1:(length(strsplit(current_path, "/")[[1]])-2)] %>% paste(collapse="/"))
# print(getwd())


shinyServer(function(input, output) {
    
    output$plt1 <- renderPlot({
            if(input$Opened_shops == '2012'){
                ggplot(open_shops_2012) + aes(x = open_shops_2012$Month, y = open_shops_2012$Lindseys) +
                    geom_bar(stat="identity", fill = 'deepskyblue3') + 
                    labs(title="Lindseys stores opened in 2012",
                         x = "Month", y = "Number iof shops") + 
                    theme(plot.title = element_text(size = 26, hjust = 0.5))
            }
        
            else if(input$Opened_shops == '2013'){
                ggplot(open_shops_2013) +  aes(x = open_shops_2013$Month, y = open_shops_2013$Lindseys) + 
                    geom_bar(stat="identity", fill = 'deepskyblue3') + 
                    labs(title="Lindseys stores opened in 2013",
                         x = "Month", y = "Number iof shops") + 
                    theme(plot.title = element_text(size = 26, hjust = 0.5))
            }
        
            else if(input$Opened_shops == '2014'){
                ggplot(open_shops_2014) + aes(x = open_shops_2014$Month, y = open_shops_2014$Lindseys)+
                    geom_bar(stat="identity", fill = 'deepskyblue3') + 
                    labs(title="Lindseys stores opened in 2014",
                         x = "Month", y = "Number iof shops") +
                    theme(plot.title = element_text(size = 26, hjust = 0.5))
            }
            else{
                NULL
            }
        })
    
    output$top_sales <- renderPlot(
        ggplot(top_sales) + aes_(x = top_sales$Name, y = top_sales$Revenue)
        + geom_bar(stat="identity", fill = 'green4') + ggtitle("Five stores with the highest revenue")
        + xlab("Name of the store") + ylab("Revenue") + theme(plot.title = element_text(size = 23, hjust = 0.5)))
   
    output$bottom_sales <- renderPlot(
        ggplot(bottom_sales) + aes_(x = bottom_sales$Name, y = bottom_sales$Revenue)
        + geom_bar(stat="identity", fill = '#990000')  + labs(title="Five stores with the lowest revenue",
             x = "Name of the store", y = "Revenue") + theme(plot.title = element_text(size = 23, hjust = 0.5)))
    
    
    output$cat_sales <- renderPlot(
     
        if(input$categories == "090-Home"){
            ggplot(home) + aes(x = home$Month, y = home$'090-Home' ) + geom_line(color = "orangered2") +
                labs(title="Sales of Home category in 2014",
                     x = "Month", y = "Revenue") +
                theme(plot.title = element_text(size = 23, hjust = 0.5))
            
        }
        else if(input$categories == "080-Accessories"){
            ggplot(accessories) + aes(x = accessories$Month, y = accessories$"080-Accessories" ) + geom_line(color = "orangered3") +
                labs(title="Sales of Accessories category in 2014",
                     x = "Month", y = "Revenue") +
                theme(plot.title = element_text(size = 23, hjust = 0.5))
            
        }
        else if(input$categories == "020-Mens"){
            ggplot(Mens) + aes(x = Mens$Month, y = Mens$"020-Mens") + geom_line(color = "orangered3") + 
                labs(title="Sales of Mens category in 2014",
                     x = "Month", y = "Revenue") + 
                theme(plot.title = element_text(size = 23, hjust = 0.5))
            
        }
        else if(input$categories == "010-Womens"){
            ggplot(Womens) + aes(x = Womens$Month, y = Womens$'010-Womens' ) + geom_line(color = "orangered3") +
                labs(title="Sales of Womens category in 2014",
                     x = "Month", y = "Revenue") + 
                theme(plot.title = element_text(size = 23, hjust = 0.5))
           
        }
        else if(input$categories == "040-Juniors"){
            ggplot(Juniors) + aes(x = Juniors$Month, y = Juniors$'040-Juniors' ) + geom_line(color = "orangered3") +
                labs(title="Sales of Juniors category in 2014",
                     x = "Month", y = "Revenue") + 
                theme(plot.title = element_text(size = 23, hjust = 0.5))
           
        }
        else if(input$categories == "030-Kids"){
            ggplot(Kids) + aes(x = Kids$Month, y =Kids$"030-Kids" ) + geom_line(color = "orangered3") +
                labs(title="Sales of home Kids in 2014",
                     x = "Month", y = "Revenue") + 
                theme(plot.title = element_text(size = 23, hjust = 0.5))
            
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



