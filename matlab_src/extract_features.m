function [ x, y ] = extract_features( data )
% extract_features( data    Extract features from the raw data.
%                           The features we used are described and
%                           extracted here.

n = size(data, 1);

x = [];
y = zeros(n, 1);

for i = 1:n
    p = data{i};
    
    % 13 features: sales(week_i) / stores( week_i ) * stores( week_26 ) for
    % weeks i=1 to i=13
    x_row = [p.X(1:13, 4)./p.X(1:13, 3)*p.X(26, 3); p.X(1:13, 4)];
    
    % 13 features: raw sales values between weeks 1 and 13
    x_row = [ x_row; p.X(1:13,4) ];
    
    % 13 features: number of stores between weeks 14 and 26    
    % add stores between weeks 14 and 26
    x_row = [ x_row; p.X(14:26,3) ];
    
    % add some interaction terms
    % 3 features: interaction terms
    finalstores_midsales = exp( log(p.X(26,3) + 1 ) * log(p.X(13,4) + 1) );
    midz_midsales = exp( ( log( p.X(13,4) / p.X(13,3) * p.X( 26,3) + 1 )  ) * ( log(p.X(13,4) + 1 )  ) );
    finalscores_midz  = exp( ( log( p.X(13,4) / p.X(13,3) * p.X(26,3) +1) ) * log(p.X(26,3)+1) );
    x_row = [ x_row; finalstores_midsales; midz_midsales; finalscores_midz ];
    
    x = [x; x_row'];
    
    y(i) = p.y;
end


end

