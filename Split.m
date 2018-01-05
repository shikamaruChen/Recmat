function [ ] = Split( datadir, fold, train, test )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
addpath('../utils')
R = mmread(strcat(datadir,'/rating'));
F = mmread(strcat(datadir,'/feature'));
n = size(R, 2);
train = ceil(train/10*n);
test = ceil(test/10*n);

if ~exist(strcat(datadir, '/split'), 'dir')
    mkdir(strcat(datadir, '/split'));
end

for f=1:fold
    cols = randperm(n);
    Rtrain = R(:,cols(1:(train+test)));
    Rtrain(:,cols((train+1):end)) = 0;
    Rtest = R(:,cols(1:(train+test)));
    Rtest(:,cols(1:train)) = 0;
    Rother = R(:,cols((train+test+1):end));
    mmwrite(strcat(datadir, '/split/Rtrain',num2str(f)), Rtrain);
    mmwrite(strcat(datadir, '/split/Rtest',num2str(f)), Rtest);
    mmwrite(strcat(datadir, '/split/Rother',num2str(f)), Rother);
    Ftrain = F(cols(1:(train+test)),:);
    Fother = F(cols((train+test+1):end),:);
    mmwrite(strcat(datadir, '/split/Ftrain',num2str(f)), Ftrain);
    mmwrite(strcat(datadir, '/split/Fother',num2str(f)), Fother);
end
end

