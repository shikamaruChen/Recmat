function [Rpath, Fpath, Tpath] = initial( results )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
home = results.home;
dataset = results.dataset;
feature = results.feature;
split = results.split;
valid = results.valid;
cpu = results.cpu;

% print
fprintf('home directory: %s\n', home)
fprintf('dataset: %s\n', dataset)
fprintf('split %d of dataset\n', split)
% Fpath
dataset = strcat(home, 'dataset/', dataset);
if isempty(feature)
    disp('no side information')
    Fpath = '';
else
    fprintf('feature file: %s\n', feature)
    Fpath = strcat(dataset,'/', feature);
end
% Rpath
Rpath = strcat(dataset, '/train',num2str(split));
% Tpath
if valid
    disp('evaluation method: validation')
    file = 'valid';
else
    disp('evaluation method: testing')
    file = 'test';
end
Tpath = strcat(dataset, '/', file, num2str(split));
% parfor setup

end

