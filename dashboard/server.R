library(ggplot2)
#Here is place for data inputing
data <- iris
pie <- as.data.frame(iris$Species, iris$Sepal.Length)


current_path <- rstudioapi::getSourceEditorContext()$path
setwd(strsplit(current_path, "/")[[1]][1:(length(strsplit(current_path, "/")[[1]])-2)] %>% paste(collapse="/"))

time <- glimpse(read.delim('./data/Time.txt', header = TRUE, dec = "."))
store <- glimpse(read.delim('./data/Store.txt', header = TRUE, dec = "."))
sales <- glimpse(read.delim('./data/Sales.txt', header = TRUE, dec = "."))
item <- glimpse(read.delim('./data/Item.txt', header = TRUE, dec = "."))
district <- glimpse(read.delim('./data/District.txt', header = TRUE, dec = "."))
print(getwd())

shinyServer(function(input, output) {
    
    output$plt <- renderPlot(
        {
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
    mycols <- c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF")
    
    output$plt2 <- renderPlot({
        
        ggplot(pie) +  aes(x = "", y = iris$Species) +
            geom_bar( stat = "identity", color = "white") +
            coord_polar("y", start = 0)
            
    })
    
    data_filtered <- reactive({data %>%
            filter(
                between(Sepal.Width, input$slider[1], input$slider[2])
            )
        
    })
    output$sldplot <- renderPlot({
        data_filtered() %>%
            ggplot(aes(Sepal.Length)) +
            geom_histogram() +
            xlab(expression("Sepal Length")) +
            ylab("Amount  [-]")
    })

})
