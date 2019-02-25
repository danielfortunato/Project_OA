clc
clear all;

A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
B=[0 0; 0 0; 0.1 0; 0 0.1];

E=[1 0 0 0; 0 1 0 0];
T=80+1;
pinitial=[0; 5];
pfinal=[15; -15];
K=6;
w=[10 20 30 30 20 10; 10 10 10 0 0 -10];
tau=[10 25 30 40 50 60]+1;
Umax=15;
lambda=[10^-3 10^-2 10^-1 10^0 10 10^2 10^3];

% Task 7 

cvx_begin
    variable x(4,T); 
    variable u(2,T);
    
    minimize(0)
    
    subject to
        x(:,1) == [pinitial; 0; 0];
        x(:,T) == [pfinal; 0; 0];
        
        for i=1:T-1
            norm(u(:,i))<=Umax;
        end
        
        for j=1:T-1
            x(:,j+1)==A*x(:,j) + B*u(:,j);
        end
        
        for k=1:K
            x(1:2,tau(k))==w(:,k);
        end
       
cvx_end
