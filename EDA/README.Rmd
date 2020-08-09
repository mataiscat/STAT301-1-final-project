---
title: "EDA Executive Summary"
author: "Junhua Tan"
date: "12/08/2019"
output: 
  html_document:
    toc: true
    toc_float: true
    highlight: "tango"
    code_folding: hide
    df_print: paged

---

```{r warning=FALSE, message=FALSE}
source("initial_EDA.R")
```

## Finding 1: Age and Gender Perference on Travel Destination

Of all users that are known to have make a booking on Airbnb, there are a significantly higher percentage of travel destination being in the US than other countries for all age and gender groups. There is a slightly more percentage of young (below 45 years old) and female users who booked a place to stay in the US than old users. However, there are also a slightly higher percentage of old (above 45 years old) and male users who book a place to stay in outside of US.

```{r Effect of age on destination country, warning=FALSE}
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
```
```{r View effect of gender in destination country, warning=FALSE}
dataset %>% 
  filter(book != "-unknown-") %>% 
  filter(!is.na(date_first_booking)) %>% 
  group_by(gender, country_destination) %>% 
  summarise(count = n()) %>% 
  mutate(prop = count/sum(count)) %>% 
  ggplot(aes(x = reorder(country_destination, -prop), y = prop, fill = gender)) +
  geom_bar(stat = "identity", position=position_dodge()) +
  labs(title = "Effect of gender in destination country", y = "Booking proportion", x = "Country of destination")
```

## Finding 2: Accessibility improvement on languages

Overall, users with English perference are the main target group of Airbnb. Over the course of 2010-2014, users with English perference has grew significantly along with the total user population. Indeed, Airbnb's effort in making itself more accessible to people of other cultures and regions can be seen through their accommodation of more languages. In 2010, few more languages are made available to users among which are French, German, Spanish, Chinese, and Korean. These also turn out to be the top five user language perferences beside English and made up ~99% of the user population. Of these, users that perfer Chinese and Korean gradually grow over 2010-2014. And users that perfer French, German, and Spanish all shows a growth until a drop in 2012-2013 when more European languages are made available.
```{r Booking growth across languages}
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
```

## Finding 3: Time between creating an account to booking

Here, to examine the time users take from creating an account to make a booking, we create an `urgency()` function that divides the time difference into 7 categories: "before" when users book before creating an account, "on the same day" when users book on the same day as creating an account, "within three days", "within a week", "within a month", "within one year", and "more than one year" after creating an account. From the result below, we can see from users who booked on Airbnb, most users booked on the same day or within three days of first being active and/or creating their accounts, which suggests that most users  have plans of traveling before looking for places to stay on Airbnb. Interestingly, there are also a peak of users who booked within a year of creating their accounts. This can also be used to highlight the uniqueness and viscosity of Airbnb as a one of the go-to site for people looking a place to stay when traveling even long after user registration.
```{r Time between creating an account to booking, warning=FALSE}
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
```