function [S] = coSim(R, F, alpha)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

S = (1-alpha)*(R')*R + alpha * F*(F');
S = S - diag(diag(S));
end

