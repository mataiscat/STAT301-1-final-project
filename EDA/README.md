## Finding 1: Age and Gender Preference on Travel Destination

Both old and young users have approximately 50% of booking with a slightly higher proportion for young users ~55%, but this difference has not been tested for significance. Both male and female users have approximately the same percentage of booking and not booking (~50%).

1. Users that have not specified their ages and genders seem to have a significantly higher percentage of not booking. This findings can hint to two potential hypotheses: 1) users that have not filled their personal information are less committed to using the site for booking, or 2) users are more likely or required to fill their personal information when deciding to book a place to stay on Airbnb.

2. Users who specific their gender as "OTHER" has a significantly higher percentage of booking (58.3%) than both male and female groups. This can be reasoned for higher stake and effort of the other gender groups to identify differently than the binary genders that again emphasizes the importance of personal information on booking status.

3. Generally, there are a higher proportion of booking in the US as the destination country across gender and age groups. Interestingly, there is a slightly more percentage of male users who booked a place to stay in other non-European countries whereas female users have a slightly higher percentage in booking a place to stay in European countries. In addition, there are also a slightly higher percentage of users identified as other genders to book a place outside of US than other groups.

![](README_figs/README-Effect-of-age-on-destination-country-1.png)<!-- -->

![](README_figs/README-Effect-of-gender-in-destination-country-1.png)<!-- -->

## Finding 2: Accessibility improvement on languages

Over the course of 2010-2014, users with English preference has been the main target group and has grew significantly along with the total user population. Now with Airbnb's effort in accommodating more language preferences, it has became more accessible to people of other cultures and regions. We can examine their accessibility improvement by analyze the growth of user populations for other language preferences. In 2010, more languages are made available to users among which are French, German, Spanish, Chinese, and Korean. These also turn out to be the top five user language preferences beside English and made up ~99% of the user population other than English users. Users that prefer Chinese and Korean gradually grow over 2010-2014. And users that prefer French, German, and Spanish all shows a growth until a drop in 2012-2013 when more European languages are made available and split the user groups (further details see `EDA_long_form`).

![](README_figs/README-Booking-growth-across-languages-1.png)<!-- -->

## Finding 3: Time between creating an account to booking

Now I want to examine the time between users created an account and made a booking. To do so, I create an `urgency()` function that divides the time difference into 7 categories: "before" when users book before creating an account, "on the same day" when users book on the same day as creating an account, "within three days", "within a week", "within a month", "within one year", and "more than one year" after creating an account.

From the result below, we can see from users who booked on Airbnb, most users booked on the same day or within three days of first being active and/or creating their accounts, which suggests that most users have plans of traveling before looking for places to stay on Airbnb. Interestingly, there are also a peak of users who booked within a year of creating their accounts. This can also be used to highlight the uniqueness and viscosity of Airbnb as a one of the go-to site for people looking a place to stay when traveling even long after user registration.

![](README_figs/README-Time-between-creating-an-account-to-booking-1.png)<!-- -->

# Conclusion

Overall, the user demographic of Airbnb comprised of younger users and those with English preference. In general, users who filled out their personal informations such as age and gender are more likely to book a place to stay through the website than those that choose not to provide their information. Young users of below 45 years old are more likely to book through Airbnb. The destination between age groups also differs in that older users also tend to be outside of the US especially higher in European countries while younger users tend to book a place to stay within US. While there are slightly more female users, the proportions of booking a place on Airbnb for male and female users are similar. Interestingly, people who identified as other genders has a significantly higher percentage of booking that might due to their higher stake and value to identify away from the binary genders. While most users prefer English on their interface, there is also a stable growth of users that prefers other languages, and as Airbnb increases its language diversity, there are more users using the minority languages which reaffirms the accessibility by incorporating more language preferences. When we dive deeper into the time for users to take the action of booking a place on Airbnb, most people who booked on the same day or within three days of first being active on the website and creating their accounts. People also tends to make their decision of booking a place during weekdays especially from Tuesday to Friday, and more people booked on the month of May and June probably due to the time corresponding the beginning of the summer break (further details see `EDA_long_form`).
