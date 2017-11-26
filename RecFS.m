function [ w ] = RecFS(R, F, alpha, beta, lambda, gamma, k, miter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

S = PSRec( R, F, alpha, beta, lambda, k, miter );
L = laplace_mat(S);
FLF = F'*L*F;
FLF = (FLF+FLF') / 2;
W = update_W(FLF, gamma, k, miter);
w = sqrt(sum(W.*W, 2));
end

