library(tidyverse)
library(readr)
library(lubridate)
polls <- read_csv("polls.csv")

polls

polls_2020 = polls[2:220,] %>%
  select(date,
         poll,
         biden,
         trump,
         spread,
         sample,
         moe)
polls_2020

unclean_dates = polls_2020$date

unclean_dates

split_dates = strsplit(unclean_dates, ' ')

cleaned_dates = c()

for (i in 1:length(split_dates)) {
  cleaned_dates[i] = split_dates[[i]][1]
}

cleaned_dates

for (i in 1:length(cleaned_dates)) {
  cleaned_dates[i] = paste0(cleaned_dates[i], '/20')
}

cleaned_dates


dates_as_dates = parse_date(cleaned_dates, '%m/%d/%y')

dates_as_dates = as_datetime(dates_as_dates)

polls_2020$date = dates_as_dates

polls_2020$poll = gsub("\\*", "", polls_2020$poll)

polls_2020

write.csv(polls_2020, 'C:/Users/Aidan/Documents/polls/polls_2020.csv', row.names = F)
