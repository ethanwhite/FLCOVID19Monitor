#' @export
get_html <- function(){
  url <- "http://www.floridahealth.gov/diseases-and-conditions/COVID-19/"
  webpage <- xml2::read_html(url)
}

#' @importFrom magrittr "%>%"
#' @export
scrape_update_date_time <- function(webpage) {
  headers <- webpage %>%
    rvest::html_nodes('.wysiwyg_content.clearfix') %>%
    rvest::html_nodes('block') %>%
    rvest::html_node('sup') %>%
    rvest::html_text()    
}

#' @importFrom magrittr "%>%"
#' @export
scrape_data <- function(webpage) {
  data <- webpage %>%
    rvest::html_nodes('.wysiwyg_content.clearfix') %>%
    rvest::html_nodes('block') %>%
    rvest::html_nodes('div') %>%
    rvest::html_text()
}