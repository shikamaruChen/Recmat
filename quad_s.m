function [ s ] = quad_s( H, f, i )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
n = length(f);
Aeq = zeros(2, n);
Aeq(1,:) = 1;
Aeq(2,i) = 1;
options = optimoptions(@quadprog, 'Display', 'off');
[s, val, flag] = quadprog(H, f, [], [], Aeq, [1; 0], zeros(n,1), ones(n,1),[], options);
%fprintf('sim vec for item %d finished\n',i);
end

