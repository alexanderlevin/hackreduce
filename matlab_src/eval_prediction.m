function [ score ] = eval_prediction( p, a )

% Scoring function from Kaggle site
score = sqrt(mean((log(p + 1) - log(a + 1)).^2));

end

