library(dplyr)
library(tidyr)
print(getwd())
# getwd()

# current_path <- rstudioapi::getSourceEditorContext()$path
# setwd(strsplit(current_path, "/")[[1]][1:(length(strsplit(current_path, "/")[[1]])-1)] %>% paste(collapse="/"))

time <- glimpse(read.delim('../data/Time.txt', header = TRUE, dec = "."))
store <- glimpse(read.delim('../data/Store.txt', header = TRUE, dec = "."))
sales <- glimpse(read.delim('../data/Sales.txt', header = TRUE, dec = "."))
item <- glimpse(read.delim('../data/Item.txt', header = TRUE, dec = "."))
district <- glimpse(read.delim('../data/District.txt', header = TRUE, dec = "."))

list_of_managers <- unique(summarize(group_by(store, DM), DM))
list_of_item_category <- unique(summarize(group_by(item, Category), Category))
# jeżeli chcesz to mogę dodać 2 kolumnę z nazwami bez brzydkich prefixów

list_of_years_available_sales <- c(2013, 2014)
list_of_years_available_store_opening <- unique(summarize(group_by(store, Open.Year), Open.Year))
list_of_chains <- unique(summarize(group_by(store, Chain), Chain))


graph_5_categories_sales <- function(year=2014, categories=c("040-Juniors", "090-Home")){
  item_sales <- inner_join(sales, item, by='ItemID')
  item_sales_time <- inner_join(sales, item, by='ItemID') %>% inner_join(time, by='ReportingPeriodID')
  # colnames(item_sales_time)
  item_sales_time <- select(item_sales_time, Year = FiscalYear, Month = Period, Category, Sum_Regular_Sales_Dollars)
  temp <- summarize(group_by(filter(item_sales_time, Year == year, Category == categories), Category, Month), Revenue = sum(Sum_Regular_Sales_Dollars))
  return (spread(temp, Category, Revenue, fill = 0))
  
}
# graph_5_categories_sales(2014, c("040-Juniors", "090-Home"))

graph_top_bottom_5_manager_sales <- function(){}

graph_present_last_years_sales <- function(){}

graph_opened_shops_count <- function(year){
  temp <- summarize(group_by(filter(store, Open.Year == year), Month = Open.Month.No, Chain), no= n())
  return (spread(temp, Chain, no, fill = 0))
}