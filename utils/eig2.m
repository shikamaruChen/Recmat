function [ eigvec ] = eig2( A,B,k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[v, d] = eig(A, B);
[~, idx] = sort(d);
eigvec = v(:,idx(1:k));
end

