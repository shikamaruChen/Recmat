function [ Y ] = square_diff( X )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
n = size(X, 1);
v = sum(X.*X, 2);
V = repmat(v, 1, n);
Y = V+V'-2*X*(X');
end

