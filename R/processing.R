load_current_data <- function() {
    data <- read.csv("R/data/fl_covid_data.csv", stringsAsFactors = FALSE)
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

process_data <- function(web_data, date_time) {
  data_split <- str_split(web_data, ' – ')
  data_values <- sapply(data_split, function(l) l[[1]])
  data_new <- as.numeric(data_values)
  data_current <- load_current_data()
  data_updated <- rbind(data_current, c(date_time, data_new))
}

write_data <- function(updated_date) {
    write.csv(updated_data, "R/data/fl_covid_data.csv")
}