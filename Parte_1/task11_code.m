%Task 11


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
M=10;
epsilon=10^-6;

for i=1:M
    ind(i).x=zeros(size(x_task10)); %saves the memory for the structure that have all the positions through the weighted iterations
end

ind(1).x=x_task10;

for i=1:M
    ind(i).u=zeros(size(u_task10)); %saves the memory for the structure that have all the controls through the weighted iterations
end

ind(1).u=u_task10;

for m=1:M
    
    cvx_begin
        variable x(4,T); 
        variable u(2,T);
        F=0;

        for k=1:K
            F = F +  (1/(norm(ind(m).x(1:2,tau(k))-w(:,k))+epsilon))*norm(x(1:2,tau(k))-w(:,k));
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
    
    ind(m+1).x=x;
    ind(m+1).u=u;


end
%% question a)

figure
    plot (ind(10).x(1,:), ind(10).x(2,:), 'o','LineWidth',1.5, 'MarkerSize',4)
    hold on
    for i=1:K
        plot (ind(10).x(1,tau(i)), ind(10).x(2,tau(i)), 'mo', 'LineWidth',1.5, 'MarkerSize',10)
    end
    hold on 
    plot(w(1,:),w(2,:),'sr','LineWidth',1.5, 'MarkerSize',10)
    xlabel('X coordinate')
    ylabel('Y coordinate')
    title('Optimal positions')

% question b)

figure
    plot (1:T, ind(10).u(1,:), 1:T, ind(10).u(2,:))
    xlabel('t time')
    ylabel('u(t)')
    title('Optimal control signal')
    legend('u1(t)','u2(t)')
    
%question c)

waypoints_captured=0;

for k=1:K
    if norm(ind(10).x(1:2,tau(k))-w(:,k)) <= 10^-6
        waypoints_captured=waypoints_captured+1;
    end
end


