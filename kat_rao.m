%Reference:
%Authors: Na Li, Carmeliza Navasca, Christina Glenn
%Iterative Methods for Symmetric Outer Product Tensor Decompositions,
%Electronic Transactions on Numerical Analysis, 44, pp. 124-139, 2015.


function C = kat_rao(A,B)

% Calculate the Kthari Rao product of 2 matrices

if size(A,2)~=size(B,2)
    disp('The Kathri Rao product can not be calculated')
    disp('the input matrices do not have the same number of columns!')
   
else
    for j=1:size(A,2)
        C(:,j)=kron(A(:,j),B(:,j));     % column wise kronecker product
    end
end
