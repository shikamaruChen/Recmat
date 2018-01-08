function [ H ] = ind2hot( X, N )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[m,n] = size(X);
col = X(:,1:N);
H = zeros(size(X));
col = col(:);
row = repmat(1:m,1,N);
val = repmat(1:N,m,1);
val = val(:);
H = full(sparse(row, col, val, m, n));
end

