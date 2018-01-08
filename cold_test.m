function [ res ] = cold_test( pR, T )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pR = gather(pR);
[m,n] = size(pR);
[~,I] = sort(pR,2,'descend');
Rec = zeros(1,4);
DCG = zeros(1,4);
N = 20;
H = ind2hot(I,N);
H(H==1)=2;
hit = T.*H;
[~,~,hit] = find(hit);
N = [5,10,15,20];
for i=1:4
    nT = N(i)*m;
    nhit = hit(hit<=N(i));
    fprintf('hit=%d\n', length(nhit))
    Rec(i) = length(nhit) / nT;
    DCG(i) = sum(log(2)./log(nhit)) / nT;
end

res.Rec = Rec;
res.DCG = DCG;
end

