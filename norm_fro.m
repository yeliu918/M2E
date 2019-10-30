%Reference:
%Authors: Na Li, Carmeliza Navasca, Christina Glenn
%Iterative Methods for Symmetric Outer Product Tensor Decompositions,
%Electronic Transactions on Numerical Analysis, 44, pp. 124-139, 2015.


function [frob_norm]=norm_fro(X)
% Calculate the frobenius norm of a tensor or a matrix
frob_norm=sqrt(sum(sum(sum(abs(X).^2))));
