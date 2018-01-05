function [ X ] = rnorm( X )
c = size(X,2);
n = sqrt(sum(X.*X, 2));
X = X./max(repmat(n,1,c),1e-5);
end

