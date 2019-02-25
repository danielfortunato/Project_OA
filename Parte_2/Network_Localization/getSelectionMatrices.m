function [] = getSelectionMatrices(filename)
load(filename);

N1=length(iA); % number of observations of y
N2=length(iS); % number of observations of y
M=length(A); %number os anchors
P=8; %number of sensors
 
pA=zeros(P,N1);
pS=zeros(P,N2);
qS=zeros(P,N2);

for i=1:P
    pA(i,find(iA(:,2)'==i))=1;
    pS(i,find(iS(:,1)'==i))=1;
    qS(i,find(iS(:,2)'==i))=1;        
end

save 'processed_data.mat' 

end

