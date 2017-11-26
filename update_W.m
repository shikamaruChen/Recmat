function [ W ] = update_W(D, gamma, k, miter)

D = (D+D')/2;
d = size(D, 1);
Q = eye(d);
for iter=1:miter
    fprintf('iteraction %d, ',iter)
    W = eig1(D + gamma * Q, k, 0);
    Q = sqrt(sum(W.^2,2)+eps);
    Q = diag(0.5 * Q.^(-1));
    obj = sum(sqrt(sum(W.*W,2))) * gamma;
    obj = obj + trace(W'*D*W);
    fprintf('obj=%f\n',obj);
end
end

