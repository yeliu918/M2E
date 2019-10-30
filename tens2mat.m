%Reference:
%Authors: Na Li, Carmeliza Navasca, Christina Glenn
%Iterative Methods for Symmetric Outer Product Tensor Decompositions,
%Electronic Transactions on Numerical Analysis, 44, pp. 124-139, 2015.


%% This function gives the 3 equivalent matrices of a third order tensor 
%% by unfolding operation (3 ways of slicing)
%% Warning: The equivalent matrices are horizontal here, i.e. X1 (I*JK) X2(J*KI) X3(K*IJ)
%%
%% **********************************************************************************************
 
function X_mat = tens2mat(X,mode)
%% Given a third-order tensor X 
[I J K]=size(X);

%% Left-right slicing, we build a I*JK matrix by concatenation
if mode==1    
X1=[];
for j=1:J
    X1=[X1  reshape(X(:,j,:),I,K)];  
end
X_mat=X1;


%% Front-back slicing, we build a J*KI matrix 
elseif mode==2
X2=[];
for k=1:K
    X2=[X2  X(:,:,k).'];     %No need to use reshape X(:,:,k) is already a matrix
end                        
X_mat=X2;


%% Top-Bottom slicing, We build a K*IJ matrix
elseif mode==3
X3=[];

for i=1:I
    X3=[X3 reshape(X(i,:,:),J,K).'];
end
X_mat=X3;

end
