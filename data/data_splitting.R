# Load libraries

## Data Wrangling
library(tidyverse)
library(lubridate)
library(dataMaid)
library(janitor)
library(rsample)

# Parse data column into appropriate types 
# Source: https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/overview

dataset <- read_csv(
  "data/unprocessed/train_users_2.csv",
  col_types = cols(
    date_account_created = col_date(format = "%Y-%m-%d"),
    timestamp_first_active = col_datetime(format = "%Y%m%d%H%M%S"),
    date_first_booking = col_date(format = "%Y-%m-%d"),
    gender = col_factor(),
    age = col_double(),
    signup_method = col_factor(),
    signup_flow = col_double(),
    language = col_factor(),
    affiliate_channel = col_factor(),
    affiliate_provider = col_factor(),
    signup_app = col_factor(),
    first_device_type = col_factor(),
    first_browser = col_factor(),
    country_destination = col_factor())
  ) %>% 
  clean_names() %>% 
  mutate(book = as.factor(ifelse(is.na(date_first_booking), "No", "Yes")),
         book = fct_relevel(book, "Yes")) %>% 
  select(-id)

# Set seed
RNGversion("3.5")
set.seed(27182)

# set fraction for training, testing, and eda
fractionTrain <- 0.60
fractionTest <- 0.20
fractionEDA <- 0.20

# compute sample size for each
sampleSizeTrain <- floor(fractionTrain * nrow(dataset))
sampleSizeTest <- floor(fractionTest * nrow(dataset))
sampleSizeEDA <- floor(fractionEDA * nrow(dataset))

# create the randomly-sampled indices for each dataframes
# use setdiff() to avoid overlapping subsets of indices
indicesTrain <- sort(sample(seq_len(nrow(dataset)), size=sampleSizeTrain))
indicesNotTrain <- setdiff(seq_len(nrow(dataset)), indicesTrain)
indicesEDA <- sort(sample(indicesNotTrain, size=sampleSizeEDA))
indicesTest <- setdiff(indicesNotTrain, indicesEDA)

# assign indices for train, test, and eda
train <- dataset[indicesTrain, ]
test <- dataset[indicesTest, ]
EDA <- dataset[indicesEDA, ]

# Update dataset to csv
#write_csv(train, "data/processed/train.csv")
#write_csv(test, "data/processed/test.csv")
#write_csv(EDA, "data/processed/EDA.csv")

# Update variable description
attr(dataset$date_account_created, "shortDescription") <- "the date of account creation"
attr(dataset$timestamp_first_active, "shortDescription") <- "timestamp of the first activity"
attr(dataset$date_first_booking, "shortDescription") <- "date of first booking"
attr(dataset$gender, "shortDescription") <- "the gender of the user"
attr(dataset$age, "shortDescription") <- "the age of the user"
attr(dataset$signup_method, "shortDescription") <- "the sign up method of the user"
attr(dataset$signup_flow, "shortDescription") <- "the page a user came to signup up from"
attr(dataset$language, "shortDescription") <- "international language preference"
attr(dataset$affiliate_channel, "shortDescription") <- "what kind of paid marketing"
attr(dataset$affiliate_provider, "shortDescription") <- "where the marketing is e.g. google, craigslist, other"
attr(dataset$signup_app, "shortDescription") <- "the signup app of the user"
attr(dataset$first_device_type, "shortDescription") <- "the device type used in user's first activity"
attr(dataset$first_browser, "shortDescription") <- "the browser used in user's first activity"
attr(dataset$country_destination, "shortDescription") <- "the destination country where user booked the place to stay"
attr(dataset$book, "shortDescription") <- "the booking status of user"

# Make a codebook containing these variable description (already made)
#makeCodebook(dataset, replace = TRUE)
