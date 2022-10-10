# Gaming-College-Rankings

## Summary

The goal of this project was to use supervised machine learning on a college ranking dataset to identify whether any metrics have an outsized influence on the overall ranks. In other words, **if we were a college president with money to invest and had the goal of improving our college's ranking, which metrics would offer the best ROI?** 

The dataset used was the Fall 2022 Washington Monthly rankings data. The Washington Monthly data <a href="https://washingtonmonthly.com/2022-college-guide/national/">can be found here</a> and is included in the Resources folder of this repository.

This project was presented during 2U's September 2022 Demo Day event. The <a href="https://docs.google.com/presentation/d/1sIsP8V9POlaAX15FoTc-cSyBhuIiCIckmcTLBudotPE/edit?usp=sharing">slide deck can be found here</a>. 


## Tools

- Python
- R
- Supervised Machine Learning models: 
  - Multiple Linear Regression
  - Random Forest Regressor
  - Decision Tree Regression
  - Support Vector Regression


## Context

An explanation of the Washington Monthly methodology <a href="https://washingtonmonthly.com/2022/08/28/a-note-on-methodology-4-year-colleges-and-universities-13/">can be found here</a>. I have represented this visually below:

![image](https://user-images.githubusercontent.com/100863488/193078954-0bb4335c-137e-4fed-811c-2cec7cbcdc8b.png)

This provides the context for comparison to the machine learning model. We may expect that the feature importances shown in our machine learning model would reflect the published methodology and assigned weights of various metrics.

## Process

The data were very clean, so after encoding the single categorical varable, the data were usable for machine learning regression models.

### Overall rank as target, no feature reduction

I first applied the machine learning models using the overall school rank as the target, without removing any usable features. The R-squared values were high, especially for Random Forest and Linear Regression, which lent confidence to the model fit for the data.

![image](https://user-images.githubusercontent.com/100863488/193072826-04888e78-b73b-417e-9ccb-a3a5728aee40.png)

I applied Random Forest feature importances and R linear regression statistical summaries to learn more about how the individual metrics influence the overall rank.

![image](https://user-images.githubusercontent.com/100863488/193075965-04c77766-b3a4-4eba-adaa-56356b7a25dc.png)

The Random Forest feature importances pointed to 88% of the influence coming from the Social Mobility Rank, which was a feature in the Washington Monthly dataset and also a subrank derived from the other social mobility features, like graduation rate. 

The R statistical summary also pointed to an outsized influence coming from the Social Mobility Rank. 

![image](https://user-images.githubusercontent.com/100863488/193074127-1dda9341-c2c4-42e8-b5d6-765c796541d8.png)

This was highly unexpected relative to the published Washington Monthly methodology and may be explained by hidden correspondences between the various metrics. 


### Attempting feature reduction with overall rank

I then attempted feature reduction to improve the accuracy of the model and learn more about the influence of various factors. However, all feature reduction attempts resulted in significantly less accurate models. Please view the Jupyter Notebooks available in this repository for more information regarding features removed and the resulting levels of model accuracy.


### Social Mobility Rank as target, no feature reduction

The next step was to use the Social Mobility Rank itself as a target to learn more about the feature importances of the social mobility features. The R-squared value was lower for the Random Forest model, but still high enough to be considered significant. Using the Social Mobility Rank as target resulted in a much more even distribution of feature importances, as can be seen in the Random Forest results and R statistical summary:

![image](https://user-images.githubusercontent.com/100863488/193075335-96cfe1e4-882d-41db-b5e1-886fe46604b5.png)

![image](https://user-images.githubusercontent.com/100863488/193075570-783820a5-a9a9-4427-8b13-b61cfeac4f90.png)


## Conclusion

The most significant metrics indicated by Random Forest (and confirmed as significant by R) were: 

- Repayment rate performance rank
- Graduation rate performance rank
- Earnings performance rank
- Net price for incomes under $75,000
- Net price rank
- Pell graduation gap rank
- Pell/non Pell graduation gap 

"Pell" refers to students receiving Pell grants, which are federal grants given to the lowest-income students. 

The first three items in this list are difficult for a university to change. The first and third refer to student outcomes after the student has graduated. However, the last four are closely correlated to one another and all refer to a university's financial support of its lowest-income students. **Therefore, the most direct way to influence a school's rank would be to increase its support of its lowest-income students.**

![image](https://user-images.githubusercontent.com/100863488/193078590-b503c742-45b3-4e4c-b38b-443f8f73d6fd.png)



## Additional information

I also attempted to compare the feature importances between the Washington Monthly dataset and the Fall 2022 US News rankings. US News does not make its dataset freely available to the public, so I added the US News overall rankings in place of the Washington Monthly rankings in the Washington Monthly data and ran the machine learning models. 

![image](https://user-images.githubusercontent.com/100863488/193418963-0f06d950-bf47-476d-88d3-bcf5e0b1168a.png)

The pie chart on the left depics US News' <a href="https://www.usnews.com/education/best-colleges/articles/how-us-news-calculated-the-rankings">published methodology</a>, which is rather different from Washington Monthly's, especially in that academic distinction is given much more weight in US News' rankings. Unsurprisingly, the R-squared value for all the machine learning models (using US News' rankings with Washington Monthly's features) was very low, so the models were not a good fit. 

