function [ L, D ] = laplace_mat( S )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
column = sum(S, 1);
row = sum(S, 2);
v = (column'+row) / 2;
D = diag(v);
L = D - (S+S')/2;
end

