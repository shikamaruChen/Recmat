function [ F ] = center( F )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = sum(F,2)/2;
d = size(F,2);
F = F - repmat(n,1,d);
end

