function [ w ] = FreFS(F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
F(F>1) = 1;
w = sum(F);
end

