function [ x, y ] = extract_features_william( data )

n = size(data, 1);

x = [];
y = zeros(n, 1);

extract_feat = @(p) [p(1:13, 4)./p(1:13, 3)*p(26, 3); p(1:13, 4)];

for i = 1:n
    p = data{i};
    
    x_row = extract_feat(p);
    x = [x; x_row'];
    
    y(i) = p(26, 4);
end


end

