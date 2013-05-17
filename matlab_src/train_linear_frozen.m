function [ fit ] = train_linear_frozen( data_train, lambda )

%% Extract features and train model
[x, y] = extract_features(data_train);

n = length(data_train);

frozen = logical(zeros(n, 1));
frozen_foods = {'Frzn Meatless', ...
    'Frozen Handhelds & Snacks', ...
    'Frzn Ss Premium Meals', ...
    'Frozen Snacks And Handhelds', ...
    'Frozen Pizza'};

for i = 1:n
    frozen(i) = nnz(strcmp(data_train{i}.cat, frozen_foods)) > 0;
end

b_frozen = ridge(log(y(frozen)+1), x(frozen, :), lambda, 0);
b = ridge(log(y(~frozen) + 1), x(~frozen, :), lambda, 0);

fit.b_frozen = b_frozen;
fit.b = b;
end

