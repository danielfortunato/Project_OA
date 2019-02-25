
%% TASK 8 ------------------------------------------------------------------------------
clc
clear;
close all;

%compute matrices to select the point in order to a_m, s_p or s_q
getSelectionMatrices('datasets/lmdata1.mat');

load processed_data.mat %data from lmdata + Selection Matrices

%constants for LM Algorithm
lambda=1;
e=10^-6;
max_iterations=100;

%get initial values
xk=[xinit(1:2:end),xinit(2:2:end)]';
[f_k,g_k,h1_k,h2_k,dh1_k,dh2_k,n1,n2,norm1,norm2]=getFunctions(xk);

ngk_vec=norm(g_k(:)); %plot array

%LM algorithm
for i=1:max_iterations
    
    if norm(g_k(:))< e
        break;
    end
    
    %solve the LS to get the next x
    xk_1=getNextX(xk,h1_k,h2_k,dh1_k,dh2_k,lambda);
    xk_1=[xk_1(1:2:end),xk_1(2:2:end)]';
    
    %get f, the gradient of f and auxiliary functions of the new x
    [f_k1,g_k1,h1_k1,h2_k1,dh1_k1,dh2_k1]=getFunctions(xk_1);

    if f_k1 <= f_k %good iteration
        %update values
        xk=xk_1;
        f_k=f_k1;
        g_k=g_k1;
        h1_k=h1_k1;
        h2_k=h2_k1;
        dh1_k=dh1_k1;
        dh2_k=dh2_k1;
        lambda=0.7*lambda;
    else %bad iteration
        lambda=2*lambda;
    end
    %save norm of gk for plots
    ngk_vec=[ngk_vec norm(g_k(:))];
end
%% plots
figure()
plot(S(1,:),S(2,:),'bo', A(1,:),A(2,:),'rsq',xk(1,:),xk(2,:),'b*', 'MarkerSize',7, 'LineWidth',1);
xlim([-15 15]);
ax1=gca;
ax1.XTick = -15:5:15;
grid on

figure()
plot(ngk_vec(1:end-1))
set(gca,'Yscale','log');
grid('minor');
ax=gca;
ax.XTick = 0:5:20;
title('||\nabla f(x_k)|| (LM method)');
xlabel('k');

%% TASK 9 ------------------------------------------------------------------------------
close all
clear all

getSelectionMatrices('datasets/lmdata2.mat');
load procesed_data.mat

%constants for LM Algorithm
lambda=1;
e=10^-6;
max_iterations=100;
number_of_xinit=1000;

f_best=10^100;
i_max=0;
for n=1:number_of_xinit
 
    if n~= 1 && f_k < f_best
        f_best=f_k;
        xk_best=xk;
        if i>i_max
            i_max=i
        end
    end
    
    %initial conditions
    xk=randi([-10^5 10^5],2,8);
    [f_k,g_k,h1_k,h2_k,dh1_k,dh2_k,n1,n2,norm1,norm2]=getFunctions(xk);

    %LM algorithm
    for i=1:max_iterations

        if norm(g_k(:))< e
            break;
        end

        %solve the LS to get the next x
        xk_1=getNextX(xk,h1_k,h2_k,dh1_k,dh2_k,lambda);
        xk_1=[xk_1(1:2:end),xk_1(2:2:end)]';

        %get f, the gradient of f and auxiliary functions of the new x
        [f_k1,g_k1,h1_k1,h2_k1,dh1_k1,dh2_k1]=getFunctions(xk_1);

        if f_k1 <= f_k %good iteration
            %update values
            xk=xk_1;
            f_k=f_k1;
            g_k=g_k1;
            h1_k=h1_k1;
            h2_k=h2_k1;
            dh1_k=dh1_k1;
            dh2_k=dh2_k1;
            lambda=0.7*lambda;
        else %bad iteration
            lambda=2*lambda;
        end

    end
end

%%
figure()
plot(A(1,:),A(2,:),'rsq',xk(1,:),xk(2,:),'b*','MarkerSize',7, 'LineWidth',1);
xlim([-15 15]);
ax1=gca;
ax1.XTick = -15:5:15;
grid on

figure()
plot(ngk_vec(1:end-1));
% semilogy(fk_vec);
set(gca,'Yscale','log');
grid minor;
title('||\nabla f(x_k)|| (LM method)');
xlabel('k');

%% save best iteration

save 'bestX0.mat' x0 f_k xk


