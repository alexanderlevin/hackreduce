hackreduce
==========
Our solution to the dunnhumby hack/reduce product launch challenge

Overview
=========
With limited time, we focused on understanding the nuances of our data set and 
then used a fairly simple prediction that we understood well.  To that end, 
we spent the majority of our time visualizing and extracting informative 
features from the data.  Our initial thought was to suppose that the number 
of units sold per store was roughly constant. Since we knew how many stores 
were selling the product at all 26 weeks of the launch, we could then use the 
historical information (e.g. units sold per store at week 13) to make our 
prediction for the number of units sold at week 26.  This simple idea already 
did reasonably well and we built on this idea as we refined our choice of 
features. We also explored using product categories and other information, 
but we found that the past aggregate sales data seemed to provide the most gain.

For modeling, we used linear regression and random forests primarily because 
they are efficient, easy to tune, and the results are reasonably interpretable.
  We were careful to optimize our model with respect to the objective that the 
contest evaluated instead of the typical objective that linear regression and 
random forests use.  To make sure that our model would generalize to the 
hidden test data and to assess the performance of our models, we used 
cross-validation -- essentially, training the model on a subset of the data, 
and testing it on a complementary subset.  Cross validation allowed us to say 
with confidence which of our models would do best on unseen data, and this 
helped us pick the best two to submit to the contest.

Trying it out
=============
The file setup.m in matlab_src trains our linear model and makes 
predictions on the test data.  It also gives the cross-validation error. 

For our random forest model, we used R.  The function call
is in scripts/simple_linear_regression_model.R

For the contest, we averaged the random forest predictions with the linear
model predictions.