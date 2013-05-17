function [ y_hat, y_test ] = predict_linear_frozen( fit, data_test )

% test data set
[x_test, y_test] = extract_features(data_test);

n = length(data_test);
frozen = logical(zeros(n, 1));
frozen_foods = {'Frzn Meatless', ...
    'Frozen Handhelds & Snacks', ...
    'Frzn Ss Premium Meals', ...
    'Frozen Snacks And Handhelds', ...
    'Frozen Pizza'};

for i = 1:n
    frozen(i) = nnz(strcmp(data_test{i}.cat, frozen_foods)) > 0;
end

y_hat = zeros(n, 1);
y_hat(frozen) = exp([ones(size(x_test(frozen, :), 1), 1) x_test(frozen, :)]*fit.b_frozen) - 1;
y_hat(~frozen) = exp([ones(size(x_test(~frozen, :), 1), 1) x_test(~frozen, :)]*fit.b) - 1;

end

