function [ error_train error_val ] = learning_curve( data, train_func, predict_func, eval_func)
%LEARNING_CURVE get training and validation errors for a learning curve plot

m = length(data);
%cutoff = floor(2 * m / 3);
cutoff = 1500;

error_train = zeros(cutoff, 1);
error_val = zeros(cutoff, 1);

I = randperm(m);
data_train = data(I(1:cutoff));
data_val = data(I(cutoff+1:end));

for i = 2:cutoff,
    fit = train_func(data_train(1:i));
    % size(fit)
    [yhat_train y_train] = predict_func(fit, data_train(1:i));
    error_train(i) = eval_func(yhat_train, y_train);
    
    [yhat_val y_val] = predict_func(fit, data_val);
    error_val(i) = eval_func(yhat_val, y_val);
    
end

end

