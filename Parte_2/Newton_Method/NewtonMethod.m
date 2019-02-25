clc
clear all

load('data1.mat');
Miterations = 15;

s = -ones(1,size(X,1))';
r =0;

epsilon=10^-6;
a=1;
gamma=10^-4;
beta=0.5;

P=[s; r];

norm_vec = zeros(1,Miterations);
ak_vec = zeros(1,Miterations);

K = length(Y);
A = [X; -ones(1, K)];

tic()

for k = 1:Miterations
    
    v = exp(A'*P)./(1 + exp(A'*P)) - Y';
    g = 1/K * (A*v);
    
    norm_vec(k) = norm(g);
    if ( norm(g) <= epsilon )
        break;
    end
    
    D = 1/K * diag(exp(A'*P)./((1+exp(A'*P)).^2));
    hessian = A*D*A';
    d = -inv(hessian)*g;

 
    ak = a;
    while(1)
        if( f1(P + ak*d , X , Y) < f1(P, X, Y) + gamma * g * (ak*d)' )
            break;
        end
        ak = beta * ak;
    end
        
    
    ak_vec(k) = ak;
    P = P + ak*d;
    
end

toc()


% Aux method to print ak in standard form
n=1;
ak_print= zeros(1,k-1);
while(n~=k)
    ak_print(n)=ak_vec(n);
    n=n+1;
end
