function [ W ] = uRec( R, F, beta, miter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
m = size(R,1);
d = size(F,2);
RF = R*F;
FF = F'*F+beta*eye(d);
W = rand(d,m);
for iter=1:miter
    W = W ./ (FF*W + 1e-8);
    W = W .* (RF');
    fprintf('iteration %d, obj=%f\n',iter,object());
end
    function obj = object()
        t = R'-F*W;
        obj = trace_eff(t) / 2;
        obj = obj + trace_eff(W)*beta/2;
    end
end

