function [ y_hat, y_test ] = predict_linear( fit, data_test )

% test data set
[x_test, y_test] = extract_features(data_test);

bias = zeros(length(y_test), 1);
%for i = 1:length(data_test)
%    bias(i) = data_test{i}.cat_mean;
%end

cats = zeros(length(data_test), 1);
for i = 1:length(data_test)
    cats(i) = data_test{i}.cat_i;
end

frozen = cats == 97 | cats == 88 | cats == 102 | cats == 94 | cats == 92;

y_hat(find(frozen)) = exp([ones(size(x_test(frozen, :), 1), 1) log(x_test(frozen, :)+1)]*fit.b_frozen) - 1;
y_hat(find(~frozen)) = exp([ones(size(x_test(~frozen, :), 1), 1) log(x_test(~frozen, :)+1)]*fit.b) - 1;

%y_hat = exp([ones(size(x_test, 1), 1) log(x_test+1)]*b + bias) - 1;

end

