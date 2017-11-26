function [ S ] = SLIM( R, beta, lambda, miter )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

n = size(R,2);
RR = R' * R;
S = rand(n,n);
S = S - diag(diag(S));

for iter=1:miter
    t = R-R*S;
    obj = trace_eff(t)/2;
    obj = obj + trace_eff(S)*beta/2;
    obj = obj + sum(sum(S))*lambda;
    fprintf('iteration %d, obj=%f\n', iter, obj)
    
    dn = RR*S + beta*S + lambda;
    S = S.*RR;
    S = S./dn;
end
disp(nnz(S(3,:)))
end

