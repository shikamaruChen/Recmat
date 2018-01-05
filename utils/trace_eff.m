function [ val ] = trace_eff(A, B)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
if nargin == 0
    disp('please input the matrix')
    val = [];
elseif nargin == 1
    val = full(sum(sum(A.*A)));
else
    val = full(sum(sum(A.*B)));
end
end

