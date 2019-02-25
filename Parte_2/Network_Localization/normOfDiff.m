function [ v_norm, diff ] = normOfDiff( X , Y )
% Computes the difference and respetive norm of all X(i)-Y(j), for every
% i and j in X and Y.
%
% Examples: 
%
% X = [a1_1 a2_2]  Y=[s1_1 s2_1 s3_1 s4_1]
%     [a1_2 a2_2]    [s1_2 s2_2 s3_2 s4_2]
%
% diff = [a1_1-s1_1 a1_1-s2_1 a1_1-s3_1 a2_1-s4_1 a2_1-s1_1 a2_1-s2_1 a2_1-s3_1 a2_1-s4_1]
%        [a1_2-s1_2 a1_2-s2_2 a1_2-s3_2 a2_2-s4_2 a2_2-s1_2 a2_2-s2_2 a2_2-s3_2 a2_2-s4_2]
%
% vertical_norm=[((a1_1-s1_1)^2+(a1_2-s1_2)^2)^1/2 ...((a2_1-s4_1)^2+(a2_2-s4_2)^2)^1/2]

%separate the coordinates
[A1,S1]=meshgrid(X(1,:),Y(1,:)); 
[A2,S2]=meshgrid(X(2,:),Y(2,:)); 

%get the difference
diff1=A1-S1; 
diff2=A2-S2;

%convert to array (collumn vectors)
diff1=diff1(:);
diff2=diff2(:);

%
diff=[diff1'; diff2']; 

%vertical norm of the vector 
v_norm=vecnorm(diff); 

% convert to collumn vector
v_norm=v_norm';

end

