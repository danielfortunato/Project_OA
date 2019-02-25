function [ x_next ] = getNextX( x, h1, h2, dh1, dh2, lambda)
load processed_data.mat

A1=zeros(length(dh1),length(x)*2);
for i=1:length(dh1)
    for j=1:length(x)
        if j==iA(i,2)
            A1(i,j*2-1:j*2)=-dh1(i,:);
        end
    end
end

for i=1:length(dh2)
    for j=1:length(x)
        if j==iS(i,1);
            A2(i,j*2-1:j*2)=dh2(i,:);
        end
        if j==iS(i,2);
            A2(i,j*2-1:j*2)=-dh2(i,:);
        end
    end
end

sqr_lambda=(lambda)^0.5*eye(length(x)*2);
b1=A1*x(:)-h1;
b2=A2*x(:)-h2;
A=[A1;A2;sqr_lambda];
b=[b1;b2;(lambda)^0.5*x(:)];

x_next=A\b;
end

