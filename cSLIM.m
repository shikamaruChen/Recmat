function [S] = cSLIM(R, F, alpha, beta, lambda, miter)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

n = size(R,2);
RR = R' * R;
FF = F * (F');
S = rand(n,n);
S = S - diag(diag(S));
RF = RR + alpha*FF;
for iter=1:miter
    % object
    t = R-R*S;
    obj = trace_eff(t) / 2;
    t = F-S*F;
    obj = obj + trace_eff(t) * alpha/2;
    obj = obj + trace_eff(S) * lambda/2;
    obj = obj + sum(sum(abs(S))) * beta;
    
    fprintf('iteration %d, obj=%f\n', iter, obj)
    d = RF*S + lambda*S + beta;
    S = S.*RF;
    S = S./d;
end
%pR = pR - pR.*R;
end

