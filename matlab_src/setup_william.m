test = importdata('../data/test.csv');
train = importdata('../data/training.csv');

%%
rng default;
data_train = raw_to_cell(train);

scores = [];
lambda = [0.001, 0.01, 0.1, 1, 10, 100];
for t = 1:length(lambda);
    scores(t) = cv_train(data_train, @(x) train_linear(x, lambda(t)), @predict_linear, 10);
end

scores


%%
[data_train] = raw_to_cell(train);
b = train_linear(data_train, 10);

[data_test, uniq_prod] = raw_to_cell(test);

[x_test, y_test] = extract_features(data_test);
y_hat = exp([ones(size(x_test, 1), 1) log(x_test+1)]*b) - 1;

write_predictions(y_hat, uniq_prod);



