#' Opened Shops
#'
#' A function which, for a given year, gathers information on all shops opened within each month that year.
#'
#' @author Lukasz Marchel
#' @export



graph_opened_shops_count <- function(year){
  temp <- summarize(group_by(filter(store, Open.Year == year), Month = Open.Month.No, Chain), no= n())
  return (spread(temp, Chain, no, fill = 0))}
