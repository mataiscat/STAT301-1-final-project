# Predict new user bookings for their first travel experience - STAT301-1 Final Project

This GitHub Repo is a place to present my final project for Northwestern University STAT301-1 (Fall 2019).

### Data Source: [Airbnb New User Bookings (Kaggle)]((https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/overview))

This data was published 4 years ago (2016) by Airbnb on Kaggle for the purpose of building a predictive model to predict in which country a new user will book for his or her first travel experience. The downloaded data contain both training and testing datasets with user information and activity logs, a web session for users, summary statistics of users' age group, gender, and country of destination. The evaluation metric for this competition is NDCG (Normalized discounted cumulative gain) with k = 5, the maximum number of predicted destinations for each new user. With this information, the company hopes to create and share personalized content with the target users and better forecast their demands.

I will first approach this dataset by conducting an Exploratory Data Analysis on the user demographics of Airbnb using 20% of the training dataset provided in `"train_users_2.csv"`, which includes over 40000+ observations. Then using the initial analysis, I will begin the data cleaning and wrangling process to address with potential data issues mentioned in the next section below. Finally, after data cleaning, I will proceed to the model building process trying different classification algorithms and compare their performance in predicting our target.

### Why this Data

I am a heavy-user on Airbnb when I travel. I became interested in exploring this particular dataset because I want to analyze the possible hidden hints behind an important user decision as well as the company's main source of profit. I am curious behind what factors are important or perhaps indicative to a new user on booking their first travel experience. From there, I can compare and reflect upon my own experience from the perspective of a user and gain insights into designing user experience as a developer in the future. Specifically, I want to explore how different demographic factors such as gender, age group, weekdays, and other factors influence a user's decision on purchasing the travel experience. This will be a challenging process involving multiple data files and over 200000+ unique user data and will surely be a part of a larger research project that can extend into building prediction models and other insights in the future.

### Potential Data Issues

From a brief skimming through the datasets, many potential cleanings that need to be done on the data.
1. There are many missing values in `age`, `gender`, and `date_first_booking` to be handled. There are also  ``"-unknown-"`` values in `gender` and `first_browser` coexists with the missing values and I suspect these unknown values would mean differently than the missing values and they should be treated with caution.
2. There are some unusual outliers in `age` ranging from a minimum of 1 to 2014-years-old. This inconsistency might due to the voluntarily user input for their personal information.
3. Many categorical columns that should be change to factor types instead of character.
4. The `timestamp_first_active` column should be parsed in as a `datetime` type for access.
5. For the purpose of EDA, I will drop the `id` column entirely and assume each row represents a unique observation.
