function [ back ] = f1( x , X , Y )


K = length(Y);
A = [X; -ones(1, K)];

back = 1/K * sum(log(1+exp(A'*x)) - Y'.*(A'*x)); 

end