function [ pR ] = iRec(R, F, beta, miter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = size(R,2);
d = size(F,2);
RF = R*F;
FRR = RF'*R;
den = RF'*RF+beta*eye(d);
W = rand(d,n);
for iter=1:miter
    W = W ./ (den*W + 1e-8);
    W = W .* FRR;
    fprintf('iteration %d, obj=%f\n',iter,object());
end

S = F*W;
S = S - diag(diag(S));
pR = R*S;

    function obj = object()
        t = R-RF*W;
        obj = trace_eff(t) / 2;
        obj = obj + trace_eff(W)*beta/2;
    end
end

