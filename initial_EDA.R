library(tidyverse)
library(lubridate)
library(forcats)
library(dataMaid)

# Read processed combined dataset
dataset <- read_csv(
  "data/processed/combine_data.csv",
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
    country_destination = col_factor(),
    book = col_factor()
  ))

# View percentage of missing values for each column
dataset %>% 
  summarise_all(funs(
    sum(is.na(.)) / length(.)
  ))

# View distribution of age after replacing outliers with median age value.
dataset %>% 
  ggplot(aes(x = age)) +
  geom_histogram(bins = 30) +
  labs(title = "Distribution of age", y = "Count", x = "Age")

# Mutate a new categorical variable `young` that divide age group at 45 to assign either "Young" and "Old" users.
young_old <- dataset %>% 
  mutate(young = ifelse(age < 45, "Young", "Old"))
young_old$young <- as.factor(young_old$young)

# From summary statistics of `young`, there are disproportionally more young users under age of 45 than older users.
summary(young_old$young)

# View the effect of age group in booking status. Out of all users known of booking status, over half of both old and young users have booked a reservation here on Airbnb with a slightly higher percentage of booking for younger users (old: 0.53, young: 0.56).
young_old %>% 
  filter(country_destination != "-unknown-") %>% 
  group_by(young, book) %>% 
  summarise(count = n()) %>% 
  mutate(prop = count/sum(count)) %>% 
  ggplot(aes(x = reorder(book, -prop), y = prop, fill = young)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Effect of age on booking", y = "Proportion", x = "Booking Status")

# Of all users that are known to have make a booking through Airbnb, there are a significantly higher percentage of travel destination in the US than other countries. Fewer proportion of older users traveled in the US than younger users but older users tent to travel outside of US more than younger users.
young_old %>%
  filter(book != "-unknown-") %>% 
  filter(!is.na(date_first_booking)) %>% 
  group_by(young, country_destination) %>% 
  summarise(count = n()) %>% 
  mutate(prop = count/sum(count)) %>% 
  ggplot(aes(x = reorder(country_destination, -prop), y = prop, fill = young)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  labs(title = "Effect of age on destination country", y = "Booking proportion", x = "Country of destination")

# View distribution of gender
dataset %>% 
  ggplot(aes(x = gender)) +
  geom_bar() +
  labs(title = "Distribution of gender", y = "Count", x = "Gender")

dataset %>% 
  group_by(gender) %>% 
  summarise(count = n(),
            prop = count/nrow(dataset))

# There does not seem a relationship between booking status and gender.
dataset %>% 
  filter(country_destination != "-unknown-") %>% 
  group_by(gender, book) %>% 
  summarise(count = n()) %>% 
  mutate(prop = count/sum(count)) %>% 
  ggplot(aes(x = book, y = prop, fill = gender)) +
  geom_bar(stat = "identity", position=position_dodge()) +
  labs(title = "Effect of gender in booking", y = "Proportion", x = "Booking Status")

# View effect of gender in destination country
dataset %>% 
  filter(book != "-unknown-") %>% 
  filter(!is.na(date_first_booking)) %>% 
  group_by(gender, country_destination) %>% 
  summarise(count = n()) %>% 
  mutate(prop = count/sum(count)) %>% 
  ggplot(aes(x = reorder(country_destination, -prop), y = prop, fill = gender)) +
  geom_bar(stat = "identity", position=position_dodge()) +
  labs(title = "Effect of gender in destination country", y = "Booking proportion", x = "Country of destination")

# Users with different language perferences
dataset %>% 
  ggplot(aes(x = language)) +
  geom_bar() +
  labs(title = "Distribution of users with different language perferences", y = "Bookings", x = "Language")

dataset %>% 
  group_by(language) %>% 
  summarise(count = n(),
            prop = count/nrow(dataset)) %>% 
  arrange(desc(prop))

# Bookings from users with English perference
dataset %>%
  filter(language == "en") %>% 
  filter(!is.na(date_first_booking)) %>% 
  group_by(year(date_first_booking), language) %>%
  summarise(count = n()) %>% 
  rename("language" = "language", "year" = "year(date_first_booking)", "count" = "count") %>% 
  ggplot(aes(x = year, y = count, color = language)) + 
  geom_line() +
  labs(title = "Amount of bookings from users with English perference", y = "Bookings", x = "Year")

# Booking growth across years
dataset %>%
  group_by(year(date_first_booking)) %>%
  summarise(count = n()) 

# Booking growth across languages
dataset %>%
  filter(language != "en") %>% 
  filter(!is.na(date_first_booking)) %>% 
  filter(year(date_first_booking) != "2015") %>% 
  group_by(year(date_first_booking), language) %>%
  summarise(count = n()) %>% 
  rename("language" = "language", "year" = "year(date_first_booking)", "count" = "count") %>% 
  ggplot(aes(x = year, y = count, color = language)) + 
  geom_line() +
  labs(title = "Amount of bookings from users with language perference other than English", y = "Bookings", x = "Year")

# Avaliable languages as in 2010
dataset %>%
  filter(language != "en") %>% 
  filter(!is.na(date_first_booking)) %>% 
  filter(year(date_first_booking) != "2015") %>% 
  group_by(year(date_first_booking), language) %>%
  summarise(count = n()) %>%
  filter(language == "fr" | language == "de" | language == "es" | language == "zh" | language == "ko") %>% 
  rename("language" = "language", "year" = "year(date_first_booking)", "count" = "count") %>% 
  ggplot(aes(x = year, y = count, color = language)) + 
  geom_line() +
  labs(title = "Amount of bookings from users with language perferences avaliable since 2010", y = "Bookings", x = "Year")

# More languages
dataset %>%
  filter(language != "en") %>% 
  filter(!is.na(date_first_booking)) %>% 
  filter(year(date_first_booking) != "2015") %>% 
  group_by(year(date_first_booking), language) %>%
  summarise(count = n()) %>%
  filter(language != "fr", language != "de", language != "es", language != "zh", language != "ko") %>% 
  rename("language" = "language", "year" = "year(date_first_booking)", "count" = "count") %>% 
  ggplot(aes(x = year, y = count, color = language)) + 
  geom_line() +
  labs(title = "Amount of bookings from users with other languages avaliable later", y = "Bookings", x = "Year")

# Time between creating an account to booking
urgency <- function(x) {
  cut(x, 
      breaks = c(-Inf, -1, 0, 3, 7, 30, 365, Inf),
      labels = c("before", "on the same day", "within three days", "within a week", "within a month", "within one year", "more than one year") 
  )
}

create_acc_to_book <- dataset %>% 
  filter(!is.na(date_first_booking)) %>% 
  mutate(days_to_book = as.double(date_first_booking - date_account_created),
         urgency = urgency(days_to_book)) 

create_acc_to_book %>% 
  group_by(urgency) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = urgency, y = count)) +
  geom_bar(stat = "identity")  +
  labs(title = "Time difference between creating an account and booking a place to stay", y = "Bookings", x = "Urgency")

# Time between being active on site to booking
active_to_book <- dataset %>% 
  filter(!is.na(date_first_booking)) %>% 
  mutate(days_to_book = as.double(date_first_booking - date(timestamp_first_active)),
         urgency = urgency(days_to_book))

active_to_book %>% 
  group_by(urgency) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = urgency, y = count)) +
  geom_bar(stat = "identity")  +
  labs(title = "Time difference between being active on website and booking a place to stay", y = "Bookings", x = "Urgency")

# Time between being active on site to create an account
active_to_create_acc <- dataset %>% 
  filter(!is.na(date_first_booking)) %>% 
  mutate(days_to_create_acc = as.double(date_account_created - date(timestamp_first_active)),
         urgency = urgency(days_to_create_acc))

active_to_create_acc %>% 
  group_by(urgency) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = urgency, y = count)) +
  geom_bar(stat = "identity")  +
  labs(title = "Time between active on website and creating account for users who booked", y = "Bookings", x = "Urgency")

active_to_create_acc2 <- dataset %>% 
  mutate(days_to_create_acc = as.double(date_account_created - date(timestamp_first_active)),
         urgency = urgency(days_to_create_acc))

active_to_create_acc2 %>% 
  group_by(urgency) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = urgency, y = count)) +
  geom_bar(stat = "identity")  +
  labs(title = "Time between being active on website and creating account for all users", y = "Count", x = "Urgency")

# Daily bookings
# Make a new variable `daily` to store the dataset mutated with corresponding `wday` weekdays of `date_first_booking`
daily <- dataset %>% 
  filter(!is.na(date_first_booking), year(date_first_booking) != 2015) %>% 
  group_by(date_first_booking) %>% 
  summarise(count = n())

daily %>% 
  ggplot(aes(x = date_first_booking, y = count)) + 
  geom_line() +
  labs(title = "Daily bookings", y = "Bookings", x = "Day")

# Weekly bookings
# Make a new function `monday_first()` to arrange the order to start from Monday to Sunday
monday_first <- function(x) {
  fct_relevel(x, levels(x)[-1])
}

# Make a new variable `weekly` to store the dataset mutated with corresponding `wday` weekdays of `date_first_booking`
weekly <- dataset %>% 
  filter(!is.na(date_first_booking), year(date_first_booking) != 2015) %>% 
  mutate(wday = wday(date_first_booking, label = TRUE))

weekly %>% 
  group_by(wday) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = monday_first(wday), y = count)) + 
  geom_bar(stat = "identity") +
  labs(title = "Weekly bookings", y = "Bookings", x = "Day of the week")

weekly <- weekly %>% 
  group_by(date_first_booking ,wday) %>% 
  summarise(count = n()) 

weekly %>% 
  ggplot(aes(x = monday_first(wday), y = count)) + 
  geom_boxplot() +
  labs(title = "Average Weekly bookings", y = "Bookings per day", x = "Day of the week")

# Monthly bookings
# Make a new variable `monthly` to store the dataset mutated with corresponding `month` of `date_first_booking`
monthly <- dataset %>% 
  filter(!is.na(date_first_booking), year(date_first_booking) != 2015) %>% 
  mutate(month = month(date_first_booking, label = TRUE)) 

monthly %>% 
  group_by(month) %>% 
  summarise(count = n()) %>% 
  ggplot(aes(x = month, y = count)) + 
  geom_bar(stat = "identity") +
  labs(title = "Monthly bookings", y = "Bookings", x = "Month")

monthly <- monthly %>% 
  group_by(date_first_booking ,month) %>% 
  summarise(count = n()) 

monthly %>% 
  ggplot(aes(x = month, y = count)) + 
  geom_boxplot() +
  labs(title = "Average monthly bookings", y = "Bookings per day", x = "Month")
