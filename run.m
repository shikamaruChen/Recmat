function [] = run(algo, varargin)
%rng(5);
addpath('utils')
parser = inputParser;
parser.addParameter('weight', '');
parser.addParameter('feature','');
parser.addParameter('split', 1);
% prediction(0), feature selection(1), feature projection(2)
parser.addParameter('task', 0);
parser.addParameter('datadir','/Users/chenyifan/jianguo/dataset/test/');
parser.addParameter('item', 0);
parser.addParameter('GPU', 0);
parser.addParameter('CPU', 1);
parser.addParameter('miter', 0);
parser.addParameter('N', 0);
parser.addParameter('alpha', -1);
parser.addParameter('beta', -1);
parser.addParameter('gamma', -1);
parser.addParameter('lambda', -1);
parser.addParameter('k', -1);
parser.addParameter('c', -1);
parser.addParameter('z', -1);
parser.parse(varargin{:});

results = parser.Results;
weight = results.weight;
feature = results.feature;
datadir = results.datadir;
split = results.split;
item = results.item;
miter = results.miter;
N = results.N;
GPU = results.GPU;
CPU = results.CPU;
alpha = results.alpha;
beta = results.beta;
gamma = results.gamma;
lambda = results.lambda;
task = results.task;
k = results.k;
c = results.c;
z = results.z;
R = [];
F = [];

fprintf('dataset: %s\n', datadir)

switch task
    case 0
        disp('Top-N recommendation')
        Rpath = strcat(datadir, 'LOO/train', num2str(split));
        Tpath = strcat(datadir, 'LOO/test', num2str(split));
    case 1
        disp('Item cold start recommendation')
        Rpath = strcat(datadir, 'split/train', num2str(split));
        Tpath = strcat(datadir, 'split/test', num2str(split));
    case 2
        if isempty(weight)
            disp('feature weight file required')
            return
        else
            disp('feature selection')
        end
end

% training dataset
fprintf('split %d of train dataset\n', split)
R = full(mmread(Rpath));
T = mmread(Tpath);

% side information
Fpath = strcat(datadir,'feature');
F = full(mmread(Fpath));
if N > 0
%     if task == 0 && ~isempty(feature)
%         fprintf('using projected feature: %s\n', feature)
%         Fpath = strcat(datadir,'project/',feature);
%         F = dlmread(Fpath);
%     else
%         Fpath = strcat(datadir,'feature');
%         
%     end
    path = sprintf('%sselect/%s',datadir, weight);
    w = dlmread(path);
    [~, w] = sort(w, 'descend');
    F = F(:, w(1:N));
end

if GPU
    R = gpuArray(R);
    F = gpuArray(F);
end

if item > 0
    fprintf('number of sampled items: %d\n', item)
    n = max(size(R,2), size(F,1));
    item = randperm(n, item);
    if ~isempty(R)
        R = R(:, item);
        T = T(:, item);
    end
    if ~isempty(F)
        F = F(item, :);
    end
end
    
% CPU configure
if CPU > 1
    pool = gcp('nocreate');
    if ~isempty(pool)
        if pool.NumWorkers ~= CPU
            delete(pool);
            parpool(CPU);
        end
    else
        parpool(CPU);
    end
    fprintf('CPU: num of workers=%d\n', CPU)
end

[m,n] = size(R);
d = size(F,2);
fprintf('user=%d, item=%d, feature=%d\n',m,n,d);
paramstr = sprintf('%d\t%d\t%d', split, size(R,2), size(F,2));

disp('Parameters:')
if alpha>=0
    paramstr = strcat(paramstr, sprintf('\t%.2f',alpha));
    fprintf('alpha=%f\n',alpha)
end
if beta>=0
    paramstr = strcat(paramstr,sprintf('\t%.2f',beta));
    fprintf('beta=%f\n',beta)
end
if gamma>=0
    paramstr = strcat(paramstr,sprintf('\t%.2f',gamma));
    fprintf('gamma=%f\n',gamma)
end
if lambda>=0
    paramstr = strcat(paramstr,sprintf('\t%.2f',lambda));
    fprintf('lambda=%f\n',lambda)
end
if k>=0
    paramstr = strcat(paramstr, sprintf('\t%d', k));
    fprintf('k=%d\n',k)
end
if c>=0
    paramstr = strcat(paramstr, sprintf('\t%d', c));
    fprintf('k=%d\n',c)
end
if z>=0
    paramstr = strcat(paramstr, sprintf('\t%d', z));
    fprintf('z=%d\n',z)
end

w = [];

%training
if task == 1
    coldstart(R, F, T);
end


% switch task
%     case 0 
%         pR = pR - pR.*R;        
%         res = test(pR,T);
%         HR = res.HR;
%         ARHR = res.ARHR;
%         path = strcat(datadir, algo, '_res');
%         file = fopen(path, 'a');
%         fprintf(file, ...
%             '%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\n', ...
%             paramstr,HR(1),HR(2),HR(3),HR(4), ...
%             ARHR(1),ARHR(2),ARHR(3),ARHR(4));
%         fclose(file);
%         disp(res);
%     case 1 % feature selection
%         path = sprintf('%sselect', datadir);
%         if ~exist(path,'dir')
%             mkdir(path);
%         end
%         path = strcat(path, '/', weight);
%         dlmwrite(path, w);
%     case 2 % feature projection
%         path = sprintf('%sproject',datadir);
%         if ~exist(path,'dir')
%             mkdir(path);
%         end
%         path = strcat(path,'/',feature);
%         dlmwrite(path, nF*W);
%     otherwise
%         disp('task within (0, 1, 2)')
% end

    function [pR] = training(R,F)
        if strcmp(algo, 'SLIM')
            pR = SLIM( R, beta, lambda, miter );
        elseif strcmp(algo, 'cSLIM')
            pR = cSLIM(R, F, alpha, beta, lambda, miter);
        elseif strcmp(algo, 'iRec')
            W = iRec(R, rnorm(F), beta, miter);
            S = F*W;
            S = S - diag(diag(S));
            pR = R*S;
        elseif strcmp(algo, 'uRec')
            W = uRec(R, rnorm(F), beta, miter);
            pR = (F*W)';
        elseif strcmp(algo, 'sRec')
            W = sRec(R, rnorm(F), beta, miter);
            S = F*W*(F');
            S = S - diag(diag(S));
            pR = R*S;
        elseif strcmp(algo, 'Rec')
        %     F = rnorm(F);
        %     F = corrupt(F,0.01);
            pR = Rec( R, F, T, alpha, beta, lambda, miter );
        elseif strcmp(algo, 'PCF')
            F = rnorm(F);
            pR = PCF( R, F, beta, gamma, lambda );
        elseif strcmp(algo, 'SRec')
            F = rnorm(F);
            pR = SRec( R, F, alpha, beta );
        elseif strcmp(algo, 'PSRec')
            F = rnorm(F);
            pR = PSRec( R, F, alpha, beta, k, miter );
        elseif strcmp(algo, 'RecClus')
            pR = RecClus( R, alpha, beta, gamma, c, miter );
        elseif strcmp(algo, 'coSim')
            F = rnorm(F);
            pR = coSim(R, F, alpha);
        elseif strcmp(algo, 'Frequent')
            pR = Frequent(F);
        elseif strcmp(algo, 'LPro')
            F = corrupt(F,0.01);
            F = rnorm(F);
            R = rnorm(R);
            pR = LPro( R, F, alpha, k, z, miter );
            %w = sum(W.*W, 2);
            %w = RecFS(R, F, alpha, beta, lambda, gamma, k, miter);
        elseif strcmp(algo, 'LFS')
        %     F = rnorm(F);
            pR = FSInfo( R, F, alpha, gamma, k, z, miter );
            %w = sum(W.*W, 2);
        elseif strcmp(algo, 'factorF')
        else
            disp('named algorithm not found')
        end
    end

    function [pR] = coldstart(R,F,T)
        itemset = sum(R,1)>0;
        tF = F(~itemset,:);
        T = T(:,~itemset);
        R = R(:,itemset);
        F = F(itemset,:);
        if strcmp(algo, 'uRec')
            W = uRec(R, rnorm(F), beta, miter);
            pR = (tF*W)';
        elseif strcmp(algo, 'iRec')
            W = iRec(R, rnorm(F), beta, miter);
            S = (tF*W)';
            pR = R*S;
        elseif strcmp(algo, 'sRec')
            W = sRec(R, rnorm(F), beta, miter);
            S = F*W*(tF');
            pR = R*S;
        end
        res = cold_test(pR, T);
        disp(res);
        Rec = res.Rec;
        DCG = res.DCG;
        path = strcat(datadir, algo, '_res');
        file = fopen(path, 'a');
        fprintf(file, ...
            '%s\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\n', ...
            paramstr,Rec(1),Rec(2),Rec(3),Rec(4), ...
            DCG(1),DCG(2),DCG(3),DCG(4));
        fclose(file);
    end
end



