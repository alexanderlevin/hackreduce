function write_predictions( y_hat, uniq_prod, file_name )
% y_hat is the prediction, uniq_prod gives the product id for the
% respective entry of y_hat.

if nargin < 3
    file_name = '../predictions.csv';
end

out = fopen(file_name, 'w');

fprintf(out, 'Product_Launch_Id,Weeks_Since_Launch,Units_that_sold_that_week\n');

for i = 1:length(y_hat)
    fprintf(out, '%d,%d,%g\n', uniq_prod(i), 26, y_hat(i));
end


end

