X = importdata('../data/training.csv');

textdata = X.textdata;
data = X.data;

%%
cat = textdata(2:end, 1);

cat = strrep(cat, '/', '');
cat = strrep(cat, '\', '');

uniq_cat = unique(cat);


for i = 1:length(uniq_cat)
    I = strcmp(uniq_cat(i), cat);
    
    x = data(I, :);
    
    prod = x(:, 1);
    uniq_prod = unique(prod);
    
    J = prod == uniq_prod(1);
    plot(x(J, 2), x(J, 4)./x(J, 3));
    
    hold on;
    for j = 1:length(uniq_prod)
        J = prod == uniq_prod(j);
        
        plot(x(J, 2), x(J, 4)./x(J, 3));
    end
    hold off;
    
    title(uniq_cat{i});
    pause;
    %saveas(gcf, sprintf('../figs/%s.png', uniq_cat{i}));
    
end