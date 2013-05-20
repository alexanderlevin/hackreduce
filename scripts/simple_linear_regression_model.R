training.filename = "training.csv"
challenge.filename = "challenge.csv"

training.data = read.csv(training.filename)
logX26 = log(training.data$X26 + 1)
Z = training.data$X13 * (training.data$stores26 / training.data$stores13)
training.data = data.frame(training.data, Z, logX26)

challenge.data = read.csv(challenge.filename)
logX26 = log(challenge.data$X26 + 1)
Z = challenge.data$X13 * (challenge.data$stores26 / challenge.data$stores13)
challenge.data = data.frame(challenge.data, Z, logX26)


# Some linear fits we can try

# simplest model
lm.fit = lm(logX26 ~ log(X13 + 1)  + log(X12 + 1)  + log(X11+1) + log(Z+1), 
      data = training.data)

# adding interaction terms
lm.fit.interactions = lm(logX26 ~ 
		      log(X13 + 1) * log(Z + 1) * log(stores26 + 1)
		      , data=training.data)	



library(lars)
library(glmnet)
library(parcor)

training.matrix = data.matrix(log(training.data[,2:30]+1))
challenge.matrix = data.matrix(log(challenge.data[,2:30]+1))

ridge.fit = glmnet(training.matrix[,c(11, 12, 13, 27, 28, 29)],
	   training.matrix[, 26], family="gaussian", alpha=0,
	   standardize=FALSE, lambda=0
	   )

# ridge.fit = ridge.cv(training.matrix[,c(11, 12, 13, 27, 28, 29)],
# 	   training.matrix[, 26], 
# 	   lambda = c(100, 10, 1, .1, .01, 0), 
# 	   scale=FALSE)


lasso.fit = lars(training.matrix[,c(11, 12, 13, 27, 28, 29)],
	   training.matrix[, 26], normalize=FALSE)

#ridge.predictions = predict(ridge.fit, challenge.matrix[,-26], 
#		  type="response", s=10)



library(randomForest)
rf.fit = randomForest(training.matrix[,c(11, 12, 13, 27, 28, 29)],
       training.matrix[, 26])
rf.predictions = predict(rf.fit, 
	       challenge.matrix[, c(11, 12, 13, 27, 28, 29)])
rf.predictions = exp(rf.predictions) - 1

# In the contest we used fewer features in our random forest
# The code below reproduces the model we used
rf.fit1 = randomForest(
	training.matrix[, c("X13", "stores26", "stores13", "Z")], 
	training.matrix[,"X26"])

