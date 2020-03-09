load_current_data <- function() {
    data <- read.csv("R/data/fl_covid_data.csv")
}

process_date <- function(update_date) {
  regex <- "([0-9]+:[0-9]+) ([ap]\\.[m]\\.) ET ([0-9]{1,2}/[0-9]{1,2}/[0-9]{4})"
  date_split <- str_match_all(string = update_date, pattern = regex)
  if (date_split[[1]][3] == "a.m.") {
    date_time <- mdy_hm(str_c(date_split[[1]][4], date_split[[1]][2], "PM", sep = " "), tz = "America/New_York")
  } else if (date_split[[1]][3] == "p.m.") {
      date_time <- mdy_hm(str_c(date_split[[1]][4], date_split[[1]][2], "AM", sep = " "), tz = "America/New_York")
  }
}

process_data <- function(web_data, update_date) {
  data_split <- str_split(web_data, ' – ')
  data_values <- sapply(data_split, function(l) l[[1]])
  data_numeric <- as.numeric(data_values)
  date_time <- process_date(update_date)
  df <- data.frame(date_time = numeric(1),
                   fl_res_positive = numeric(1),
                   repatriated_positive = numeric(1),
                   nonfl_res_positive = numeric(1),
                   fl_res_deaths = numeric(1),
                   negative_tests = numeric(1),
                   pending_tests = numeric(1),
                   monitoring_curren = numeric(1),
                   monitoring_total = numeric(1)
                   )
  df[1,] <- c(date_time, data_numeric)
  return(df)
}
