function [ F ] = corrupt( F, epsilon )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
F = F + normrnd(0, epsilon, size(F));
end