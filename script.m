%run('coSim', 'alpha', 0.5)
%run('Frequent','dataset','nips','weight','fre')
%run('PSInfo','task',1,'alpha',0.1,'k',10,'z',5,'miter',5,'weight','1.w')
%run('PSInfo','task',1,'dataset','nips','GPU',1,'item',100,'alpha',0.1,'k',100,'z',5,'miter',5,'weight','1.w')
%run('PSInfo','task',2,'alpha',0.1,'k',10,'z',5,'miter',5,'feature','pro1')
%run('PSInfo','task',2,'dataset','nips','GPU',1,'weight','1.w','feature','pro1','N',100,'alpha',0.1,'k',50,'z',5,'miter',5)
%run('cSLIM','dataset','nips','feature','pro1','alpha',0.1,'beta',0.1,'lambda',0.1,'miter',10)
for k=0:5
    run('FSInfo','home','../','dataset','beauty','weight',strcat('alpha_',num2str(k),'.w'),'GPU',1,'alpha',0.02*k,'gamma',0.1,'k',8000,'z',1000,'miter',5)
end
% for k=1:5
%     run('PSInfo','task',2,'dataset','beauty','weight',strcat(num2str(k),'.w'),'feature', ...
%        strcat(num2str(k),'.pro'),'N',5000,'GPU',1,'alpha',0.1,'gamma',0.01,'k',1000,'z',10,'miter',3);
%     run('fSLIM','beta',0.1,'lambda',0.1,'dataset','beauty','feature',strcat(num2str(k),'.pro'),'miter',5,'GPU',1);
% %     run('FSInfo','task',1,'dataset','beauty','weight',strcat(num2str(k),'_alpha.w'),'GPU',1,'alpha',0.1,'gamma',0.01,'k',1000*k,'z',10,'miter',3)
% end 
% Fpath = '/Users/chenyifan/jianguo/dataset/beauty/dataset2/feature';
% F = full(mmread(Fpath));
% w = dlmread('/Users/chenyifan/jianguo/dataset/beauty/dataset2/select/fre');