function [ fit ] = train_linear( data_train, lambda )

%% Extract features and train model
[x, y] = extract_features(data_train);

b = ridge(log(y + 1), x, lambda, 0);

fit = b;

end

