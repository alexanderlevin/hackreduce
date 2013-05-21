%% Import raw data

% The training and test data are in the same format
% as the data provided by the challenge, except for one change.
% We swap the first two columns, so that in the files below, 
% the product category is the first column, and the
% product launch id is the second.

test = importdata('../data/test.csv');
train = importdata('../data/training.csv');

%% Training

[data_train, ~, cat] = raw_to_cell(train);

scores = [];
lambda = [0.001, 0.01, 0.1, 1, 10, 100];

% 10-fold cross-validation
for i = 1:10
    % sweep through regularization parameters
    for t = 1:length(lambda);
        scores(i, t) = cv_train(data_train, @(x) train_linear(x, lambda(t)), ...
            @predict_linear, 10);
    end
end

boxplot(scores);

%% Train on full data set and write predictions

lambda = 10;

% Load test data
[data_test, uniq_prod] = raw_to_cell(test);

% Train on full training set
fit = train_linear(data_train, lambda);

% Predict on training set
y_hat = predict_linear(fit, data_test);

% write the predictions to  predictions.csv for uploading to Kaggle
write_predictions(y_hat, uniq_prod);
