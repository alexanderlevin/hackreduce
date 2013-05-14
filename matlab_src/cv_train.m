function [ cv_err ] = cv_train( data, train_fun, predict_fun, n_folds )

n = length(data);
I = randi(n_folds, n, 1);

score = zeros(n_folds, 1);
for i = 1:n_folds
    data_train = data(I ~= i);
    data_test = data(I == i);
    
    fit = train_fun(data_train);
    [y_hat, y] = predict_fun(fit, data_test);

    score(i) = eval_prediction(y_hat, y);
end

cv_err = sqrt(mean(score.^2));

end

