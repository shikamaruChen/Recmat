function [ W, S ] = LFS( R, F, alpha, gamma, k, z, miter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
n = size(R, 2);
d = size(F, 2);
% W = eye(d);
X0 = square_diff(R');
X = X0 + alpha * square_diff(F);
S = get_S();
L = laplace_mat(S);
% F = corrupt(F,0.01);
% for iter=1:miter
% fprintf('iteraction for %d times\n',iter)

FLF = F'*L*F;
FLF = (FLF+FLF') / 2;
W = update_W();
% X = X0 + (1-alpha) * square_diff(F*W);
%     S = get_S();
% end

    function [S] = get_S()
        [~, I] = sort(X);
        I = I(1:(n-z),:);
        J = repmat(1:n,n-z,1);
        idx = sub2ind(size(X),I(:), J(:));
        X(idx) = 0;
        s = sum(X);
        S = X./repmat(s,n,1);
    end
    function [ W ] = update_W()
        FLF = (FLF+FLF')/2;
        d = size(FLF, 1);
        Q = eye(d);
        obj0 = 0;
        for i=1:miter
            fprintf('iteraction %d, ',i)
            W = eig1(FLF + gamma * Q, k, 0);
            Q = sqrt(sum(W.^2,2)+eps);
            Q = diag(0.5 * Q.^(-1));
            obj = sum(sqrt(sum(W.*W,2))) * gamma;
            obj = obj + trace(W'*FLF*W);
            fprintf('obj=%f\n',obj);
            if abs(obj-obj0) < 1e-5
                break;
            end
            obj0 = obj;
        end
    end
end

