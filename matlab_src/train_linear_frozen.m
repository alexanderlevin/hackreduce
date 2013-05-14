function [ fit ] = train_linear( data_train, lambda )

%% Extract features and train model
[x, y] = extract_features(data_train);

bias = zeros(length(y), 1);
%for i = 1:length(data_train)
%    bias(i) = data_train{i}.cat_mean;
%end

%b = ridge(log(y+1) - bias, log(x+1), lambda, 0);
cats = zeros(length(data_train), 1);
for i = 1:length(data_train)
    cats(i) = data_train{i}.cat_i;
end

frozen = cats == 97 | cats == 88 | cats == 102 | cats == 94 | cats == 92;

b_frozen = ridge(log(y(frozen)+1), log(x(frozen, :)+1), lambda, 0);
b = ridge(log(y(~frozen) + 1), log(x(~frozen, :) + 1), lambda, 0);

fit.b_frozen = b_frozen;
fit.b = b;
end

