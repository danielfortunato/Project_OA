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
Umax=100;
lambda=[10^-3 10^-2 10^-1 10^0 10 10^2 10^3];

% Task 3 

% Do everything that was done in task 1 but now we use a regulizer based on
% the l1 norm 



cvx_begin
    variable x(4,T); 
    variable u(2,T);
    F1=0;
    F2=0;
    
    for i=1:6
        F1= F1 + square_pos(norm(x(1:2,tau(i))-w(:,i)));
    end
    
    for t=2:T-1
        F2 = F2 + norm(u(:,t)-u(:,t-1),1);
    end
    
    minimize(F1 + lambda(7)*F2)
    
    subject to
        x(:,1) == [pinitial; 0; 0];
        x(:,T) == [pfinal; 0; 0];
        
        for i=1:T-1
            norm(u(:,i))<=Umax;
        end
        
        for j=1:T-1
            x(:,j+1)==A*x(:,j) + B*u(:,j);
        end
       
cvx_end

%% question a)

figure
    plot (x(1,:), x(2,:), 'o','LineWidth',1.5, 'MarkerSize',4)
    hold on
    for i=1:K
        plot (x(1,tau(i)), x(2,tau(i)), 'mo', 'LineWidth',1.5, 'MarkerSize',10)
    end
    hold on 
    plot(w(1,:),w(2,:),'sr','LineWidth',1.5, 'MarkerSize',10)
    xlabel('X coordinate')
    ylabel('Y coordinate')
    title('Optimal positions')
    grid('on')
 
%% question b)

figure
    plot (1:T, u(1,:), 1:T, u(2,:))
    xlabel('t time')
    ylabel('u(t)')
    title('Optimal control signal')
    legend('u1(t)','u2(t)')
    grid('on')
    
    
    
%% question c)

changes=0;
for i=2:T-1
    if norm(u(:,i)-u(:,i-1)) > 10^-6
        changes=changes+1;
    end
end
    
%% question d)
mean=0;
for i=1:K
        mean = mean + norm(x(1:2,tau(i))-w(:,i));
    end
meantotal = (1/K)*mean;
 
 