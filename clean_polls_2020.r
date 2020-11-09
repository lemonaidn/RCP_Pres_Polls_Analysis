library(tidyverse)
library(readr)
library(lubridate)
library(stringr)
polls <- read_csv("polls.csv")

#index polls so we only have 2020 polls

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

#clean and convert string dates to datetime

unclean_dates = polls_2020$date

unclean_dates

split_dates = strsplit(unclean_dates, ' ')

cleaned_dates = c()

#toss out the poll's end date

for (i in 1:length(split_dates)) {
  cleaned_dates[i] = split_dates[[i]][1]
}

cleaned_dates

#add year so datetime conversion is possible

for (i in 1:length(cleaned_dates)) {
  cleaned_dates[i] = paste0(cleaned_dates[i], '/20')
}

cleaned_dates

#convert to dates

dates_as_dates = parse_date(cleaned_dates, '%m/%d/%y')

dates_as_dates = as_datetime(dates_as_dates)

polls_2020$date = dates_as_dates

#get rid of asterisks in some poll names so all polls from same pollster
#can be grouped /plotted together later

polls_2020$poll = gsub("\\*", "", polls_2020$poll)

#split the sample column into separate sample size and sample type cols

polls_2020 = polls_2020 %>%
  cbind(str_split_fixed(polls_2020$sample, ' ', 2))

polls_2020 = polls_2020 %>%
  select(-'sample')

polls_2020 = polls_2020 %>%
  rename(
    sample_size = 7,
    sample_type = 8
  )

polls_2020

#add a column that contains a numerical score based on fivethirtyeight's
#grade-letter rating for each pollster
#A+, A, A-, A/B, B+, B, B-, B/C, C+, C, C-, C/D, D-
#13, 12, 11, etc etc etc


polls_2020

write.csv(polls_2020, 'C:/Users/Aidan/Documents/polls/polls_2020.csv', row.names = F)
