library(dplyr)
library(tidyr)
print(getwd())
getwd()

# current_path <- rstudioapi::getSourceEditorContext()$path
# setwd(strsplit(current_path, "/")[[1]][1:(length(strsplit(current_path, "/")[[1]])-1)] %>% paste(collapse="/"))

time <- glimpse(read.delim('../data/Time.txt', header = TRUE, dec = "."))
store <- glimpse(read.delim('../data/Store.txt', header = TRUE, dec = "."))
sales <- glimpse(read.delim('../data/Sales.txt', header = TRUE, dec = "."))
item <- glimpse(read.delim('../data/Item.txt', header = TRUE, dec = "."))
district <- glimpse(read.delim('../data/District.txt', header = TRUE, dec = "."))



list_of_years_available_sales <- c(2013, 2014)
list_of_years_available_store_opening <- sort(unique(store$Open.Year))
list_of_chains <- unique(store$Chain)


graph_5_categories_sales <- function(year=2014, categories=c("040-Juniors", "010-Womens")){
  item_sales_time <- inner_join(sales, item, by='ItemID') %>% 
                  inner_join(time, by='ReportingPeriodID') %>% 
                  select(Year = FiscalYear, Month = Period, Category, Sum_Regular_Sales_Dollars)
  
  filter(item_sales_time, Year == year, Category == categories) %>% 
                                      group_by(Category, Month) %>%
            summarize(Revenue = sum(Sum_Regular_Sales_Dollars)) %>%
                            spread(Category, Revenue, fill = 0) -> result
return (result)}

graph_top_bottom_shops_sales <- function(top=TRUE, count=5){
  store_sales_time <- inner_join(sales, store, by='LocationID') %>% inner_join(time, by='ReportingPeriodID') %>% 
                select(Year = FiscalYear, Month = Period, Sum_Regular_Sales_Dollars, DM, Name)
  
  if (isTRUE(top)){  
    selected_stores <-store_sales_time %>% group_by(Name) %>% summarize(Revenue = sum(Sum_Regular_Sales_Dollars)) %>% arrange(desc(Revenue)) %>% head(count)
  } else {  
    selected_stores <-store_sales_time %>% group_by(Name) %>% summarize(Revenue = sum(Sum_Regular_Sales_Dollars)) %>% arrange(Revenue) %>% head(count)
  }

  return(selected_stores)}

graph_opened_shops_count <- function(year){
  temp <- summarize(group_by(filter(store, Open.Year == year), Month = Open.Month.No, Chain), no= n())
  return (spread(temp, Chain, no, fill = 0))}

graph_opened_shops_count(2012)

table_margin_sales <- function(year = 2014){
  item_sales_time <- inner_join(sales, item, by='ItemID') %>% 
                 inner_join(time, by='ReportingPeriodID') %>% 
    select(Year = FiscalYear, Month = Period, Sum_Regular_Sales_Dollars, Sum_Regular_Sales_Units, Sum_GrossMarginAmount)

  filter(item_sales_time, Year == year) %>% 
    group_by(Month) %>%
    summarize(Revenue = sum(Sum_Regular_Sales_Dollars), qt = sum(Sum_Regular_Sales_Units), avr=sum(Sum_Regular_Sales_Dollars)/sum(Sum_Regular_Sales_Units)) -> result
  return(result)}

# Alicja dla ciebie do callingu - selling_area_average_sale(input)
selling_area_average_sale <- function(slider_data){
  store_sales_time <- inner_join(sales, store, by='LocationID') %>% inner_join(time, by='ReportingPeriodID') %>% 
    select(Year = FiscalYear, Month = Period, Sum_Regular_Sales_Dollars, SellingAreaSize, StoreNumber )
  
    filter(store_sales_time, between(SellingAreaSize, slider_data$slider[1], slider_data$slider[2])) %>% 
    group_by(Month, StoreNumber) %>% 
    summarize('x' = n()) -> temp
    temp$store_temp <- 1
      group_by(temp, Month) %>% 
    summarize('x' = sum(store_temp)) -> number_of_stores
  
    filter(store_sales_time, between(SellingAreaSize, slider_data$slider[1], slider_data$slider[2])) %>% 
                        group_by(Month) %>% 
    summarize('average revenue per stores' = sum(Sum_Regular_Sales_Dollars)) -> monthly_revenue
    
    monthly_revenue$'no stores' <- number_of_stores$x
    monthly_revenue$'average revenue per stores' <- monthly_revenue$'average revenue per stores' / monthly_revenue$'no stores'
    result <- monthly_revenue
      
  return(result)}



top_sales <- as.data.frame(graph_top_bottom_shops_sales())
bottom_sales<- as.data.frame(graph_top_bottom_shops_sales(FALSE, 5))

list_of_categories <- as.data.frame(unique(item$Category))

home <-as.data.frame(graph_5_categories_sales(2014, "090-Home"))
accessories <- as.data.frame(graph_5_categories_sales(2014, "080-Accessories"))
Mens <- as.data.frame(graph_5_categories_sales(2014, "020-Mens"))
Womens <- as.data.frame(graph_5_categories_sales(2014, "010-Womens"))
Juniors <- as.data.frame(graph_5_categories_sales(2014, "040-Juniors"))
Kids <- as.data.frame(graph_5_categories_sales(2014, "030-Kids"))

open_shops <- graph_opened_shops_count(2014)

# marigin_2014 <-
# marigin_2013
