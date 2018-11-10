folder = 'C:\Users\Admin\Desktop\FaceVerification\TestingSpace\NNtest\Image\data';

% list =  collectData(folder);


% 
% function list = collectData(folder)
    subFolders = struct2cell(dir(folder))';
    subFolders = subFolders(3:end, 1);
    files      = cell(size(subFolders));
    name = cell(size(subFolders));
    for i = 1:length(subFolders)
        fprintf('--- Collecting the %dth folder (total %d) ...\n', i, length(subFolders));
        subList  = struct2cell(dir(fullfile(folder, subFolders{i}, '*.jpg')))';
        files{i} = fullfile(folder, subFolders{i}, subList(:, 1));
        [~, name{i}, ~] = fileparts(string(files{i}));
    end
    files      = vertcat(files{:});
    sub = subFolders;
%     sub = vertcat(subFolders{:});
%     dataset    = cell(size(files));
%     dataset(:) = {name};
    list       = cell2struct([files sub name], {'file', 'name','xx'}, 2);
% end