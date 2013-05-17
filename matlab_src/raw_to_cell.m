function [ data, uniq_prod, cat, X ] = raw_to_cell( imported_data )

cat = imported_data.textdata(2:end, 1);
X = imported_data.data;

% Process data into cell array based on products
prod = X(:, 1);
[uniq_prod, I] = unique(prod);

cat = cat(I);

data = cell(length(uniq_prod), 1);

for i = 1:length(uniq_prod)
    data{i}.X = X(prod == uniq_prod(i), :);
    data{i}.prod = uniq_prod(i);
    data{i}.cat = cat(i);
    data{i}.y = data{i}.X(26, 4);
end
