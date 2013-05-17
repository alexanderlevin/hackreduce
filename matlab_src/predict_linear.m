function [ y_hat, y_test ] = predict_linear( b, data_test )

% test data set
[x_test, y_test] = extract_features(data_test);
y_hat = exp([ones(size(x_test, 1), 1) x_test]*b) - 1;

end

