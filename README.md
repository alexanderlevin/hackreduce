hackreduce
==========
Our solution to the dunnhumby hack/reduce product launch challenge.

Slides from our presentation at the Boston Data Mining Meetup (6/4) 
https://docs.google.com/presentation/d/1Md7Xi09_LxnpPPjM0tNCtcq6aU4--9xTglBMk_Vb6po/pub?start=false&loop=false&delayms=3000

Slides from Lightning Talks @ Predictive Analytics World (9/30) 
http://goo.gl/EvxND0

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

The final set of features were:
* for each of weeks 1 to 13, the ratio of stores in week 26 to stores in week 13, 
multiplied by the sales in that week. 
* the raw sales in weeks 1 through 13
* the number of stores in weeks 14 through 26
* three interaction terms (products between some of the above features)

These features are expressed mathematically in the file
matlab_src/extract_features.m

For modeling, we used linear regression and random forests primarily
because they are efficient, easy to tune, and the results are
reasonably interpretable. It's worth noting that we used the natural
logs of the feature and target values, which seemed to work well. We
were careful to optimize our model with respect to the objective that
the contest evaluated instead of the typical objective that linear
regression and random forests use.  To make sure that our model would
generalize to the hidden test data and to assess the performance of
our models, we used cross-validation -- essentially, training the
model on a subset of the data, and testing it on a complementary
subset.  Cross validation allowed us to say with confidence which of
our models would do best on unseen data, and this helped us pick the
best two to submit to the contest.

Trying it out
=============
The file setup.m in matlab_src trains our linear model and makes 
predictions on the test data.  It also gives the cross-validation error.

For our random forest model, we used R.  The function call
is in scripts/simple_linear_regression_model.R

For the contest, we averaged the random forest predictions with the linear
model predictions.

How to add features
=============
It is possible to extend the model by adding more features. This can
be done in matlab_src/extract_features.m without affecting the rest of
the pipeline.

We tried to train separate models for frozen and non-frozen foods by
using scripts/prefilter_product_categories.py and then running
separate training/question set files through the MATLAB pipeline. The
MATLAB code has been improved so that it is easier to access the
product category, and this information could also be used in extract_features.m
