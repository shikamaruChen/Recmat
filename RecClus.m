function [ S ] = RecClus( R, alpha, beta, gamma, c, miter )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

disp('Parameters: ')
fprintf('max number iterations: %d\n', miter)
fprintf('alpha=%f\n', alpha)
fprintf('beta=%f\n', beta)
fprintf('gamma=%f\n', gamma)
fprintf('num of clusters=%d\n', c)

n = size(R,2);
RR = R' * R;
S = rand(n,n);
S = S - diag(diag(S));
P = rand(n,c);

for iter=1:miter
    Q = square_diff(P);
    for i=1:10
        dn = RR*S + beta*S + gamma*Q + alpha;
        S = S.*RR;
        S = S./dn;
    end
    L = laplace_mat(S);
    P = eig1(L, c, 0);
    
    t = R - R*S;
    obj = trace_eff(t) / 2;
    obj = obj + sum(sum(S))*alpha;
    obj = obj + trace_eff(S)*beta/2;
    obj = obj + 2*gamma*trace_eff(L'*P,P);
    fprintf('iteration %d, obj=%f\n', iter, obj)
end
end

