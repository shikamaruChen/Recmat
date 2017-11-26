function [ S,W ] = PSRec( R, F, alpha, beta, k, miter )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

n = size(R,2);
%[m, n] = size(R);
%d = size(F,2);
RR = R'*R;
H = RR + beta*eye(n);
FW = F;
X = alpha * square_diff(F);
P = X - RR;
S = update_S(H, P);
L = laplace_mat(S);
fprintf('iteraction for 1 time, obj=%f\n', object())

%H = eye(n)-1/n;
%St = F'*H*F+eye(d)*lambda;
%SF = St\(F');
pR = R*S;
pR = pR - pR.*R;
Tpath = strcat('../../../dataset/beauty/test1');
T = mmread(Tpath);
res = test(pR,T);
disp(res);

for iter=2:miter
    FLF = F'*L*F;
    FLF = (FLF+FLF') / 2;
    W = eig1(FLF, k, 0);
    FW = F*W;
    X = alpha * square_diff(FW);
    H = RR + beta*eye(n);
    P = X - RR;
    S = update_S(H, P);
    
    
    pR = R*S;
    pR = pR - pR.*R;
    res = test(pR,T);
    disp(res);
    
    
    L = laplace_mat(S);
    %obj = obj + sum(sqrt(sum(W.*W,2))) / gamma;
    fprintf('iteraction for %d times, obj=%f\n', iter, object())
end

    function [obj] = object()
        obj = trace_eff(R-R*S) / 2;
        obj = obj + trace_eff(FW,L*FW)*alpha*2;
        obj = obj + trace_eff(S)*beta/2;
    end
end