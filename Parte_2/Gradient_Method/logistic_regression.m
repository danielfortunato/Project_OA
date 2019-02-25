function f = log_regression(s_,X,y_)
K=size(X,2);

f = (1/K)*(sum(log(1+exp(s_*X)))-y_*(s_*X)');

end
