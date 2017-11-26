function [w] = fslim_w(RF, r, c, lambda, beta, miter, j)
    %UNTITLED3 Summary of this function goes here
    %   Detailed explanation goes here
    d = length(c);
    RFr = RF'*r;
    FRRF = RF'*RF;
    w = rand(d,1);
    for iter=1:miter
        t = r - RF*w;
        obj = trace_eff(t)/2;
        obj = obj + w'*w*beta/2;
        obj = obj + lambda*c*w;
        fprintf('w_%d, iteration %d, obj=%f\n',j,iter,obj)

        dn = FRRF*w + beta*w + lambda*(c');
        w = w.*RFr;
        w = w./dn;
    end
    end