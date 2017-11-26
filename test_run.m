% run('Frequent','dataset','beauty/dataset2','weight','fre')
% F = mmread('/Users/chenyifan/jianguo/dataset/beauty/dataset2/feature');
% w = dlmread('/Users/chenyifan/jianguo/dataset/beauty/dataset2/select/fre');
% [~, w] = sort(w, 'descend');
% F = F(:, w(1:10000));
% mmwrite('/Users/chenyifan/jianguo/dataset/beauty/dataset2/F',F);


run('Rec','home','../','dataset','beauty','weight','alpha_1.w','N',5000,'alpha',0.02,'beta',0.1,'lambda',0.3,'miter',10,'GPU',1,'miter',1)

% run('PSInfo','dataset','beauty/dataset2','weight','5k_0.w','N',5000,'feature','5k_0.pro','GPU',1,'alpha',0.1,'k',2000,'z',10,'miter',3,'item',1000);
% run('fSLIM','beta',0.1,'lambda',0.1,'dataset','beauty/dataset2','feature','5k_0.pro','GPU',1);
% run('coSim','alpha',0.1,'dataset','beauty/dataset2','feature','5k.pro','GPU',1);
% run('coSim','alpha',1.0,'dataset','beauty/dataset2','weight','5k.w','N',3000,'GPU',1);
%run('fSLIM','beta',0.1,'lambda',0.1,'dataset','beauty/dataset2','weight','5k_0.w','N',3000,'GPU',1);
% run('PSInfo','feature','t.pro','alpha',0,'k',5,'z',3,'miter',5)
% F0 = full(mmread('/Users/chenyifan/jianguo/dataset/test/feature'));
% F = dlmread('/Users/chenyifan/jianguo/dataset/test/project/t.pro');
% S0 = square_diff(F0);
% S = square_diff(F);
%run('coSim','alpha',0.1,'dataset','beauty/dataset2','weight','alpha_1.kw','N',5000)
%run('PSInfo','dataset','nips','weight','fre','N',5000,'feature','nips.pro','alpha',0.1,'k',4900,'z',10,'miter',3,'item',1500);\
% F = full(mmread('/Users/chenyifan/jianguo/dataset/beauty/dataset2/feature'));
% w = dlmread('/Users/chenyifan/jianguo/dataset/beauty/dataset2/select/alpha_1.kw');
% [~, w] = sort(w, 'descend');
% for N=[9000,8000,7000,6000,5000,4000,3000,2000,1000]
%   disp(preserve(F,F(:, w(1:N))));
% end
% F = rnorm(F);