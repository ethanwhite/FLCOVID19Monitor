#' @export
load_current_data <- function() {
    data <- readr::read_csv("R/data/fl_covid_data.csv")
}

#' @export
process_date <- function(update_date) {
  regex <- "([0-9]+:[0-9]+) ([ap]\\.[m]\\.) ET ([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})"
  date_split <- stringr::str_match_all(string = update_date, pattern = regex)
  if (date_split[[1]][3] == "a.m.") {
      date_time <- lubridate::mdy_hm(stringr::str_c(date_split[[1]][4], date_split[[1]][2], "PM", sep = " "), tz = "America/New_York")
  } else if (date_split[[1]][3] == "p.m.") {
      date_time <- lubridate::mdy_hm(stringr::str_c(date_split[[1]][4], date_split[[1]][2], "AM", sep = " "), tz = "America/New_York")
  }
  date_time <- lubridate::with_tz(date_time, tzone = "UTC")
}

#' @export
process_data <- function(web_data, new_date_time) {
  data_split <- stringr::str_split(web_data, ' – ')
  data_values <- sapply(data_split, function(l) l[[1]])
  data_values <- as.numeric(data_values)
  data_current <- load_current_data()
  data_new <- tail(data_current, 1)
  data_new$date_time = new_date_time
  data_new[,2:9] = data_values
  data_updated <- rbind(data_current, data_new)
}

#' @export
write_data <- function(updated_data) {
    write.csv(updated_data, "R/data/fl_covid_data.csv", row.names = FALSE)
}