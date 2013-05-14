
%%

% plot errors on each category, plus number of products in cat

b = train_linear(data_train, 10);
[y_hat, y] = predict_linear(b, data_train);

uniq_cat = unique(cat);
n_prod = zeros(length(uniq_cat), 1);
v = zeros(length(uniq_cat), 1);

for i = 1:length(uniq_cat)
    I = strcmp(uniq_cat(i), cat);
    
%    boxplot(log(y(I)+1) - log(y_hat(I)+1));
    
    n_prod(i) = nnz(I);
    v(i) = mean(abs(log(y(I)' +1) - log(y_hat(I) + 1)));
    
    vals = log(y(I)' +1) - log(y_hat(I) + 1);
    
   % [fi, x] = ksdensity(vals);
   % plot(x, fi);
   % title(sprintf('%s with %d products', uniq_cat{i}, nnz(I)));
    
    %pause;
    
%    saveas(gcf, sprintf('../figs/residual_by_cat/%d.png', i));
end

