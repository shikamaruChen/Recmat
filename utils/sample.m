function [ ] = sample( datadir )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
R = mmread(strcat(datadir, '/rating'));
F = mmread(strcat(datadir, '/feature'));
[m,n]=size(R);
fprintf('(%d,%d,%d)\n', m, n, nnz(R));
user = sum(R,2)>=10;
R = R(user, :);
item = find(sum(R,1)>=8);
R = R(:, item);
[m,n]=size(R);
fprintf('(%d,%d,%d)\n', m, n, nnz(R));
% nR = zeros(size(R));
% idx = find(R);
% nR(idx(randperm(nnz(R), 10000))) = 1;
% nR = nR(sum(nR,2)>1, :);
% nR = nR(:, sum(nR,1)>0);
% [m,n]=size(nR);
% fprintf('(%d,%d,%d)\n', m, n, nnz(nR));
% item = item(sum(nR,1)>0);
% nR = sparse(nR);
mmwrite(strcat(datadir, '/sub/rating'), R);
mmwrite(strcat(datadir, '/sub/feature'), F(item,:));


end

