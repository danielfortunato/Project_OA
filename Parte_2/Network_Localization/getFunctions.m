function [f, grad_f, h1,h2, dh1, dh2,n1,n2,norm1,norm2] = getFunctions( x )
load processed_data.mat

%------------------------------------------------------------------------------------------------
% Notation:
%------------------------------------------------------------------------------------------------

% f1(x)= Sum (||am - sp|| -  ymp)^2 = Sum (h1_mp)^2 = ||h1||^2
%       (m,p)                        (m,p)
%
% * n1_mp = am - sp;
% * n1 = [ a1_1 - s1_1 ... a1_1-sP_1 ... aM_1-s1_1 ... aM_1-sP_1]
%        [ a1_2 - s1_2 ... a1_1-sP_1 ... aM_1-s1_1 ... aM_1-sP_1]
% * norm1_mp=||n1_mp|| ; norm1 = [norm1_11 ... norm1_1M ... norm1_M1 ... norm1_MP]
% * dh1=[ n1(1,1)/norm1_11 ... n1(1,P*M)/norm1_PM]
%       [ n1(2,1)/norm1_11 ... n1(2,P*M)/norm1_PM]
% * h1_mp = ||n1_mp|| - ymp = norm1_mp - ymp
% * h1= norm1 - y , where y=[y_11 ... y1P ... yM1 ... yMP]
%     = [h1_11,...,h1_1p,...,h1_1P ... h1_m1,...,h1_mp,...,h1_mP ... h1_M1,...,h1_Mp,...,h1_MP]'

%------------------------------------------------------------------------------------------------

% f2(x)= Sum (||sp - sq|| -  zpq)^2 = Sum (h2_pq)^2 = ||h2||^2
%       (p,q)                        (p,q)
%
% n2_pq = sp - sq; 
% n2 = [ s1_1 - s1
%      [
% norm2_pq=||n2_pq||
% h2_pq = ||sp-sq|| - zpq =||n2_pq|| - zpq = norm2_pq - zpq 
% h2=[h2_11,...,h2_1p,...,h2_1P ... h2_m1,...,h2_mp,...,h2_mP ... h2_M1,...,h2_Mp,...,h2_MP]'

%------------------------------------------------------------------------------------------------
% Conclusion: f(x)=f1(x)+f2(x)=||h1||^2+||h2||^2  


%get norm vectors
[norm1, n1]=normOfDiff(A,x);
[norm2, n2]=normOfDiff(x,x);

%select values correspondent to the set (prune values)
n1=n1(:,(iA(:,1)-1)*length(x)+iA(:,2));
n2=n2(:,(iS(:,1)-1)*length(x)+iS(:,2));
norm1=norm1((iA(:,1)-1)*length(x)+iA(:,2));
norm2=norm2((iS(:,1)-1)*length(x)+iS(:,2));

h1=norm1-y;
h2=norm2-z;

f1=norm(h1)^2;
f2=norm(h2)^2;

f=f1+f2;

%find gradient of f1
dh1=n1'./[norm1,norm1];
df1=-2*dh1.*[h1,h1];
grad_f1=pA*df1;

%find the gradient of f2
dh2=n2'./[norm2,norm2];
df2=2*dh2.*[h2,h2];
grad_f2=pS*df2-qS*df2;

grad_f=grad_f1+grad_f2;

end

