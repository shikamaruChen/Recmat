function [ pR ] = sRec( R, F, beta, miter )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
RF = R*F;
FRRF = RF' * RF;
FF = F'*F;
d = size(F,2);
W = rand(d,d);
for iter=1:miter
    W = W .* FRRF;
    W = W ./ (FRRF*W*FF + beta*W + 1e-8);
    fprintf('iteration %d, obj=%f\n', iter, object());
end
S = F*W*(F');
S = S - diag(diag(S));
pR = R*S;
    function obj = object()
        t = R - RF*W*(F');
        obj = trace_eff(t) / 2;
        obj = obj + trace_eff(W)*beta/2;
    end
end

