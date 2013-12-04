lambdas = [.0001, .1, 10];

train_errors = [];
val_errors = [];

for lambda = lambdas
    [err_train err_val] = learning_curve(data_train, ...
            @(x)(train_linear(x, lambda)), @predict_linear, @eval_prediction);
       
    train_errors = [train_errors err_train];
    val_errors = [val_errors, err_val];

end


c = size(train_errors, 1);

colors = ['r', 'g', 'b'];

hold on;

for i=1:length(lambdas)
    plot(train_errors(10:end, i), colors(i));
    plot(val_errors(10:end, i), colors(i));
end