function [ x, y ] = extract_features( data )

n = size(data, 1);

x = [];
y = zeros(n, 1);

for i = 1:n
    p = data{i}.X;
    
    x_row = [p(1:13, 4)./p(1:13, 3)*p(26, 3); p(1:13, 4); p(14:end, 3)];
    x = [x; x_row'];
    
    y(i) = p(26, 4);
end

x = log(x + 1);

end

