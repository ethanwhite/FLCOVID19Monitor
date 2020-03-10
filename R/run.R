#' @export
update <- function() {
    current_data <- load_current_data()
    current_date_time <- tail(current_data, 1)$date_time
    webpage <- get_html()
    scraped_date_time <- scrape_update_date_time(webpage)
    new_date_time <- process_date(scraped_date_time)
    if (new_date_time != current_date_time){
      scraped_data <- scrape_data(webpage)
      updated_data <- process_data(scraped_data, new_date_time)
      write_data(updated_data)
    }
}
