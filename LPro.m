function W = LPro( R, F, alpha, k, z, miter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = size(R, 2);
d = size(F, 2);
W = eye(d);
X0 = alpha * square_diff(R');
for iter=1:miter
    fprintf('iteraction for %d times, ',iter)
    X = X0 + (1-alpha) * square_diff(F*W);
    beta = get_S();
    L = laplace_mat(S);
    fprintf('obj=%f\n',object());
    FLF = F'*L*F;
    %FDF = F'*D*F;
    FLF = (FLF+FLF')/2;
    %FDF = (FDF+FDF')/2;
    FLF = corrupt(FLF,0.01);
    %disp(rank(FLF))
    W = eig1(FLF,k,0);
    %W = eig2(FLF,FDF,k);
end
    function [beta] = get_S()
        [data, I] = sort(X);
        beta = sum(data(z+1,:)*z-sum(data(1:z,:)))/n;
        I = I(1:(n-z),:);
        J = repmat(1:n,n-z,1);
        idx = sub2ind(size(X),I(:), J(:));
        X(idx) = 0;
        s = sum(X);
        S = X./repmat(s,n,1);
    end
    function obj = object()
        %obj = trace_eff(R*L, R)*alpha*2;
        FW = F*W;
        obj = trace_eff(FW, L*FW)*(1-alpha)*2;
        %obj = obj + trace_eff(S)*beta/2;
    end
end

