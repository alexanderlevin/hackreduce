training.filename = "training.csv"
challenge.filename = "challenge.csv"

training.data = read.csv(training.filename)
logX26 = log(training.data$X26 + 1)
Z = training.data$X13 * (training.data$stores26 / training.data$stores13)
training.data = data.frame(training.data, logX26, Z)

challenge.data = read.csv(challenge.filename)
logX26 = log(challenge.data$X26 + 1)
Z = challenge.data$X13 * (challenge.data$stores26 / challenge.data$stores13)
challenge.data = data.frame(challenge.data, logX26, Z)

lm.fit = lm(logX26 ~ log(X13 + 1)  + log(X12 + 1)  + log(X11+1) + log(Z+1), 
      data = training.data)
lm.predictions = predict(lm.fit)

# test error
sqrt(mean((lm.predictions - training.data$logX26)^2))


lm.fit.interactions = lm(logX26 ~ 
		      log(X13 + 1) * log(Z + 1) * log(stores26 + 1)
		      )	

