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

lm.fit = lm(logX26 ~ log(X13 + 1)  + log(X12 + 1)  + log(X11+1) + log(Z+1), 
      data = training.data)
lm.predictions = predict(lm.fit)

# test error
sqrt(mean((lm.predictions - training.data$logX26)^2))


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