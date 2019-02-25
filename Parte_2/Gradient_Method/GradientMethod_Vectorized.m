%% Task 2


clc
clear all



load ('data1.mat')
%load ('data2.mat')
%load ('data3.mat')
%load ('dataset4.mat')


s=-ones(1, size(X,1));
r=0;
epsilon=10^-6;
alpha_hat=1;
gama=10^-4;
beta=0.5;
K=size(X,2);       
k=0;

P=[s r];
actual_x = [X;-ones(1,size(X,2))];
g=ones(size(actual_x,1));

G=[];
%%
tic()

while norm(g) > epsilon
    g=(1/K)*(sum(actual_x.*(exp(P*actual_x)./(1+exp(P*actual_x))),2)- sum(actual_x.*Y,2));
    G=[G g];
    d=-g;
    alpha=alpha_hat;
    while log_regression(P+alpha*d',actual_x,Y)>log_regression(P,actual_x,Y)+gama*g'*(alpha*d)
        alpha=beta*alpha;
    end
    P=P+alpha*d';
    k=k+1;

end
toc()


figure
for i=1:K
    if Y(i)==0
        plot(X(1,i), X(2,i), 'or', 'LineWidth',1)
    end
    if Y(i)==1
        plot(X(1,i), X(2,i), 'ob', 'LineWidth',1)
    end
    hold on
end

x1=-4:0.1:6;
x2 = P(3)/P(2) -(P(1)/P(2))*x1;
hold on 
plot(x1,x2,'--g', 'LineWidth',1.5)
xlabel('x1')
ylabel('x2')


figure
for i=1:k
    plot(i, norm(G(:,i)), '.b')
    hold on
end
set(gca, 'YScale', 'log')
grid('on')
xlabel('k')
ylabel('gradient norm')
title('Norm of the gradient')