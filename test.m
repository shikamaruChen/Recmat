function [res] = test(pR, T)
% idx = sum(pR,2)>0;
% idx = gather(idx);
% pR = pR(idx,:);
% T = T(idx,:);
pR = gather(pR);
[m,n] = size(pR);

nT = nnz(T);
[~,I] = sort(pR,2,'descend');
%I = gather(I);
HR = zeros(1,4);
ARHR = zeros(1,4);
N = 20;
col = I(:,1:N);
col = col(:);
row = repmat(1:m,1,N);
val = repmat(1:N,m,1);
val = val(:);
pR = sparse(row, col, val, m, n);
hit = T.*pR;
[~,~,hit] = find(hit);
N = [5,10,15,20];
for i=1:4
    nhit = hit(hit<=N(i));
    fprintf('hit=%d\n', length(nhit))
    HR(i) = length(nhit) / nT;
    ARHR(i) = sum(1./nhit) / nT;
end

res.HR = HR;
res.ARHR = ARHR;
end

