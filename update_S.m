function [ S ] = update_S( H, P )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n = size(H,1);
H = (H+H')/2;
H = gather(H);
P = gather(P);
S = zeros(n);
parfor i=1:n
    S(:,i) = quad_s(H, P(:,i), i);
end
end

