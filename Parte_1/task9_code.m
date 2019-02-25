% Task 9 

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


cvx_begin
    variable x(4,T); 
    variable u(2,T);
    F=0;
    
    for k=1:K
        F = F + square_pos(norm(x(1:2,tau(k))-w(:,k)));
    end
    
    minimize(F)
    
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

% question b)

figure
    plot (1:T, u(1,:), 1:T, u(2,:))
    xlabel('t time')
    ylabel('u(t)')
    title('Optimal control signal')
    legend('u1(t)','u2(t)')
    
%question c)

waypoints_captured=0;

for k=1:K
    if norm(x(1:2,tau(k))-w(:,k)) <= 10^-6
        waypoints_captured=waypoints_captured+1;
    end
end
