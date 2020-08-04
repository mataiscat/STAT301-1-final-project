# Welcome to Junhua's Final Project for STAT301-1!

This GitHub Repo is a place to present my final project for Northwestern Univeristy STAT301-1 (Fall 2019).

### Data Source

This data was published 4 years ago on Kaggle by Airbnb for the purpose of training a model in which predict where a new user will book their first travel experience [data source](https://www.kaggle.com/c/airbnb-recruiting-new-user-bookings/overview). With this information, the company Airbnb hope to share more personalized content with the target users and better forecast their demands. The data folder contains mant csv files in addition to the training and testing set for building this prediction model. However, for our purpose of this final project, I will conduct a full Exploratory Data Analysis on the user demographics of Airbnb using these data, specifically the train dataset provided in `"train_users_2.csv"` and the test dataset `"test_users.csv"` which includes the over 200000+ unique users information of this site. In the future if I found them insufficient, I might also consider included `"age_gender_bkts.csv"` which divides the users' age group for each destination country and `"countries.csv"` which provides the summary statistics of destination countries.

### Why this Data

I chose this data because personally I am a heavy-user on Airbnb when I travel, and I am interested in the analysis behind a common user action: booking their first travel experience. I am curious behind what factors decide a new user to book their first travel experience in Airbnb and how do they come up with the decision. From there, I can compare and reflect upon my own user experience, and from this, I can also gain insights to user experience as a developer in the future. Specifically, I want to know how different demographic factors such as gender, age group, weekdays, times and many more influences user's decision on purchasing the travel experience. This will  be a challenging process involving multiple data files and over 200000+ unique user data and will surely be a part of a larger research project that can extend into building prediction models and other insights in the future.

### Potential Data Issues
First, because the `"train_users_2.csv"` and `"test_users.csv"` datasets have similar columns, I will merge the two datasets together for more observations. The combination will contain a total of over 200000+ user data. The scale of this data can be a potential problem because larger than any we had dealt with in class and thus might take more time to be processed, but it should still be workable on my personal computer. 
Next, by skimming through the datasets, there are many potential cleaning works need to be done on the data.1) There are many missing values in `age`, `gender`, and `date_first_booking` columns to be treated. Noted that `date_first_booking` column is used for the original purpose of this dataset to predict the destination which new users booked their first travel experience. For the purpose of this Exploration Data Analysis, we might be able to ignore this column. 2) There are also many "-unknown-" values in `gender` and `first_browser` columns that should be treated as `NA` values. 3) There are some unusual values in `age` ranging from minimum of 1 year old to 2014 years old. This inconsistency might due to the fact that the users voluntarily input their ages and was not sanitized. We can later handle this data by setting these unreasonable outliers to either the average age or `NA` values.  4) There are many categorical columns that should be change to factor types instead of character. For example, the `gender` has only three unique levels `"MALE"`, `"FEMALE"` and `"-<unknown>-"`, and `signup_method` contains only four unique levels `"facebook"`, `"basic"`, `"google"` and `"weibo"` that can be turn into factors. Many other columns such as `"language"`, `"affiliate_channel"`, `"affiliate_provider"`, `"signup_app"`, `"first_device_type"`, and `"first_browser"` can all be turned into factor types with its unique levels. 5) The `timestamp_first_active` column should be parsed as a datetime type for access. 6) For our purpose, we can drop the `id` column entirely and assume each row represents an unique observation.


```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/mataiscat/STAT301-1-final-project/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
