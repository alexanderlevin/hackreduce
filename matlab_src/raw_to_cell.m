function [ data, uniq_prod, cat, X, cat_mean, Icat ] = raw_to_cell( imported_data )
cat = imported_data.textdata(2:end, 1);
X = imported_data.data;

% Process data into cell array based on products
prod = X(:, 1);
[uniq_prod, I] = unique(prod);
cat = cat(I);
[uniq_cat, ~, Icat] = unique(cat);

data = cell(length(uniq_prod), 1);

for i = 1:length(uniq_prod)
    data{i}.X = X(prod == uniq_prod(i), :);
    data{i}.prod = uniq_prod(i);
    data{i}.cat = cat(i);
    data{i}.y = data{i}.X(26, 4);
    data{i}.cat_i = Icat(i);
end

cat_mean = zeros(length(uniq_cat));
for i = 1:length(uniq_cat)
    I = strcmp(cat, uniq_cat(i));
    
    v = [];
    for j = find(I)'
        v = [v; log(data{j}.y + 1)];
    end
    
    cat_mean(i) = mean(v);
end

for i = 1:length(uniq_prod)
    data{i}.cat_mean = cat_mean(data{i}.cat_i);
end
