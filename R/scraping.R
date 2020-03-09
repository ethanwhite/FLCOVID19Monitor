get_html <- function(){
  url <- "http://www.floridahealth.gov/diseases-and-conditions/COVID-19/"
  webpage <- read_html(url)
}

scrape_update_date_time <- function(webpage) {
  headers <- webpage %>%
    html_nodes('.wysiwyg_content.clearfix') %>%
    html_nodes('block') %>%
    html_node('sup') %>%
    html_text()    
}

scrape_headers <- function(webpage) {
  headers <- webpage %>%
    html_nodes('.wysiwyg_content.clearfix') %>%
    html_nodes('block') %>%
    html_nodes('strong') %>%
    html_text()
  headers <- headers[headers != " "]
}

scrape_data <- function(webpage) {
  data <- webpage %>%
    html_nodes('.wysiwyg_content.clearfix') %>%
    html_nodes('block') %>%
    html_nodes('div') %>%
    html_text()
}