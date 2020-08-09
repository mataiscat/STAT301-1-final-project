# Load libraries
library(tidyverse)
library(lubridate)
library(dataMaid)

# Parse data column into appropriate types 
# Source: https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/overview
train <- read_csv(
  "data/unprocessed/train_users_2.csv")

test <- read_csv(
  "data/unprocessed/test_users.csv")

# Create `country_destination` column for test file filled with "-unknown-"
test$country_destination <- "-unknown-"
test$country_destination <- as.factor(test$country_destination)

# Combine test and train data
users <- rbind(train, test)

# Deselect `id` column
dataset <- users %>% 
  select(-id, -first_affiliate_tracked)

# Processing booking status
# Initialize a new variable `book`, a decision variable that stores whether the user books 
#  (and has their first booking) on Airbnb (1) or does not on Airbnb (0) or "-unknown-" if from test data
dataset$book <- 1
dataset$book[dataset$country_destination == "NDF"] <- 0
dataset$book[dataset$country_destination == "-unknown-"] <- "-unknown-"
dataset$book <- as.factor(dataset$book)

# Double check that there are no observation that does not have a date of first booking and value 1 in book
dataset %>% 
  filter(is.na(date_first_booking) & book == 1)

# Processing age
# Detect abnormal and missing values in column `age`
# There are ages as small as 1 to a maximum of 2014
summary(dataset$age)

# View distribution of normal age values
dataset %>% 
  filter(!(is.na(age) | age >= 100 | age <= 10)) %>% 
  ggplot(aes(x = age)) +
  geom_histogram()

# Extract average age from normal data
median_age <- median(dataset$age[dataset$age < 100 & dataset$age > 10], na.rm = TRUE)
# Replace abnormal age values to average age
dataset$age[dataset$age >= 100 | dataset$age <= 10] <- median_age

# Compute the new summary statistics with replaced values
summary(dataset$age)

# View first 5 observations
head(dataset, 5)

# Update dataset to `combine_data.csv` (already made)
#write_csv(dataset, "data/processed/combine_data.csv")

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
