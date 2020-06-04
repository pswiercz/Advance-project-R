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

list_of_managers <- as.data.frame(unique(store$DM))
list_of_item_category <- unique(item$Category)
# jeżeli chcesz to mogę dodać 2 kolumnę z nazwami bez brzydkich prefixów

list_of_years_available_sales <- c(2013, 2014)
list_of_years_available_store_opening <- sort(unique(store$Open.Year))
list_of_chains <- unique(store$Chain)


graph_5_categories_sales <- function(year=2014, categories=c("040-Juniors", "090-Home")){
  item_sales_time <- inner_join(sales, item, by='ItemID') %>% 
                  inner_join(time, by='ReportingPeriodID') %>% 
                  select(Year = FiscalYear, Month = Period, Category, Sum_Regular_Sales_Dollars)
  # temp <- summarize(group_by(filter(item_sales_time, Year == year, Category == categories), Category, Month), Revenue = sum(Sum_Regular_Sales_Dollars))
  
  filter(item_sales_time, Year == year, Category == categories) %>% 
                                      group_by(Category, Month) %>%
            summarize(Revenue = sum(Sum_Regular_Sales_Dollars)) %>%
                            spread(Category, Revenue, fill = 0) -> result
return (result)}

# graph_5_categories_sales(2014, c("040-Juniors", "090-Home"))

graph_top_bottom_shops_sales <- function(top=TRUE, count=5){
  store_sales_time <- inner_join(sales, store, by='LocationID') %>% inner_join(time, by='ReportingPeriodID') %>% 
                select(Year = FiscalYear, Month = Period, Sum_Regular_Sales_Dollars, DM, Name)
  
  if (isTRUE(top)){  
    selected_stores <-store_sales_time %>% group_by(Name, DM) %>% summarize(Revenue = sum(Sum_Regular_Sales_Dollars)) %>% arrange(desc(Revenue)) %>% head(count)
  } else {  
    selected_stores <-store_sales_time %>% group_by(Name, DM) %>% summarize(Revenue = sum(Sum_Regular_Sales_Dollars)) %>% arrange(Revenue) %>% head(count)
  }

  return(selected_stores)}

# graph_top_bottom_shops_sales(top=FALSE, count=10)

graph_opened_shops_count <- function(year){
  temp <- summarize(group_by(filter(store, Open.Year == year), Month = Open.Month.No, Chain), no= n())
  return (spread(temp, Chain, no, fill = 0))}

table_margin_sales <- function(){
  item_sales_time <- inner_join(sales, item, by='ItemID') %>% 
    inner_join(time, by='ReportingPeriodID') %>% 
    select(Year = FiscalYear, Month = Period, Sum_Regular_Sales_Dollars, Sum_Regular_Sales_Units, Sum_GrossMarginAmount)

  filter(item_sales_time, Year == 2014) %>% 
    group_by(Month) %>%
    summarize(Revenue = sum(Sum_Regular_Sales_Dollars), qt = sum(Sum_Regular_Sales_Units), avr=sum(Sum_Regular_Sales_Dollars)/sum(Sum_Regular_Sales_Units)) -> result
  return(result)
 }