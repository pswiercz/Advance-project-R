library(ggplot2)
library(dplyr)
library(tidyr)
library(tidyverse)

source("data_manipulation.r")
options(scipen = 999)

top_sales <- as.data.frame(graph_top_bottom_shops_sales())

bottom_sales <- as.data.frame(graph_top_bottom_shops_sales(FALSE, 5))

# current_path <- rstudioapi::getSourceEditorContext()$path
# setwd(strsplit(current_path, "/")[[1]][1:(length(strsplit(current_path, "/")[[1]])-2)] %>% paste(collapse="/"))
# print(getwd())


shinyServer(function(input, output) {
    
    output$plt1 <- renderPlot(
        {
            if(input$sales_by_year == '2013'){
                
            }
            else if(input$sales_by_year == '2014'){
                
            }
            else{
                NULL
            }
        })
    
    output$top_sales <- renderPlot(
        ggplot(top_sales) + aes_(x = top_sales$Name, y = top_sales$Revenue)
        + geom_bar(stat="identity", fill = '#a5f29e') + ggtitle("Five stores with the highest revenue")
        + xlab("Name of the store") + ylab("Revenue") + theme(plot.title = element_text(size = 20, hjust = 0.5)))
   
    output$bottom_sales <- renderPlot(
        ggplot(bottom_sales) + aes_(x = bottom_sales$Name, y = bottom_sales$Revenue)
        + geom_bar(stat="identity", fill = '#990000')  + labs(title="Five stores with the lowest revenue",
             x = "Name of the store", y = "Revenue") + theme(plot.title = element_text(size = 20, hjust = 0.5)))
                                                            


    data_filtered <- reactive({data %>%
            filter(
                between(Sepal.Width, input$slider[1], input$slider[2])
            )
        
    })
    output$sldplot <- renderPlot({
        iris %>%
            ggplot(aes(Sepal.Length)) +
            geom_histogram()
    })

})
